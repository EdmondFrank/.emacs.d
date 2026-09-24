;;; init-exhub.el --- Basic support for Exhub -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(add-to-list 'load-path (expand-file-name "site-lisp/emacs-websocket" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp/exhub" user-emacs-directory))

(require 'exhub)

(exhub-start-elixir)
(exhub-start)

(require 'exhub-chat)
(require 'exhub-translate)
(require 'exhub-gitee)
(require 'exhub-tool)
(require 'exhub-agent)
(require 'exhub-file)
(require 'exhub-fim)
(require 'exhub-vault)
(require 'blink-search-exhub)


;; Codestral is served by the ExHub Elixir backend (Exhub.Fim.Server) which
;; runs the completion requests concurrently and pushes results back over the
;; WebSocket, so typing never blocks on HTTP.
(setq exhub-fim-provider 'codestral)
(add-hook 'org-mode-hook #'exhub-vault-mode)

(setopt pi-coding-agent-project-trust-policy 'default)

;;; ExHub model catalog ------------------------------------------------------
;; The authoritative list of chat models is served by the ExHub backend at
;; GET /llms (see lib/exhub/router.ex).  It is fetched asynchronously and we
;; fall back to a local snapshot while the backend is still booting.

(require 'json)
(require 'cl-lib)

(defconst exhub-llms-url "http://127.0.0.1:9069/llms"
  "ExHub endpoint serving the model catalog.")

;; gptel-specific capability metadata (not modelled by ExHub); merged onto the
;; model names returned by /llms.
(defconst exhub-model-capabilities
  '((step3
     :capabilities (tool-use json media)
     :mime-types ("image/png" "image/jpeg" "image/webp" "image/heic" "image/heif"
                  "application/pdf" "text/plain" "text/csv" "text/html")
     :context-window 32000)
    (internvl3-78b
     :capabilities (tool-use json media)
     :mime-types ("image/png" "image/jpeg" "image/webp" "image/heic" "image/heif"
                  "application/pdf" "text/plain" "text/csv" "text/html")
     :context-window 32000)
    (glm-4_5v
     :capabilities (tool-use json media)
     :mime-types ("image/png" "image/jpeg" "image/webp" "image/heic" "image/heif"
                  "application/pdf" "text/plain" "text/csv" "text/html")
     :context-window 64000)
    (kimi-k2.5
     :capabilities (tool-use json media)
     :mime-types ("image/png" "image/jpeg" "image/webp" "image/heic" "image/heif"
                  "application/pdf" "text/plain" "text/csv" "text/html")
     :context-window 200000))
  "Per-model gptel capability plists merged onto the ExHub catalog.")

;; Used only while the backend is unreachable (e.g. still starting up).
(defconst exhub-model-fallback
  '(step3 internvl3-78b glm-4_5v kimi-k2.5
    claude-opus-4-5-20251101 claude-sonnet-4-20250514 claude-sonnet-4-5-20250929
    claude-haiku-4-5-20251001 claude-opus-4-6 claude-sonnet-4-6
    tngtech/deepseek-r1t2-chimera:free
    minimax-m2 minimax-m2.1 minimax-m2.5 minimax-m2-preview
    qwen3-235b-a22b-instruct-2507 qwen3-coder-480b-a35b-instruct
    kimi-k2-instruct kimi-k2-thinking deepseek-v3_1
    glm-4_5 glm-4.6 glm-4.7 glm-5 glm-5.1 glm-5-turbo
    deepseek-v3.2 deepseek-v3.2-exp deepseek-v3_1-terminus gemini-2.5-pro
    qwen3-next-80b-a3b-instruct qwen3-next-80b-a3b-thinking qwen3-235b-a22b)
  "Model names used until the ExHub catalog can be fetched.")

(defun exhub-models--with-capabilities (names)
  "Return NAMES as gptel model entries, adding local capability plists."
  (mapcar (lambda (name)
            (let ((sym (if (stringp name) (intern name) name)))
              (if-let ((props (alist-get sym exhub-model-capabilities)))
                  (cons sym props)
                sym)))
          (delete-dups (append names nil))))

(defun exhub-refresh-models (&optional callback)
  "Fetch the model catalog from ExHub and update the gptel backend.
The request is asynchronous; CALLBACK runs after a successful update."
  (interactive)
  (let ((attempt 0))
    (cl-labels
        ((fetch ()
           (setq attempt (1+ attempt))
           (url-retrieve
            exhub-llms-url
            (lambda (status)
              (let ((ok nil))
                (when (and (not (plist-get status :error))
                           (buffer-live-p (current-buffer)))
                  (goto-char (point-min))
                  (when (re-search-forward "\r?\n\r?\n" nil t)
                    (let* ((body (buffer-substring-no-properties (point) (point-max)))
                           (json (let ((json-object-type 'alist)
                                       (json-key-type 'symbol))
                                   (json-read-from-string body)))
                           (models (exhub-models--with-capabilities
                                    (alist-get 'models json))))
                      (when models
                        (setf (gptel-backend-models gptel-backend)
                              (gptel--process-models models))
                        (setq ok t)
                        (when callback (funcall callback))))))
                (when (buffer-live-p (current-buffer))
                  (kill-buffer (current-buffer)))
                ;; Retry a few times while the backend is still booting.
                (unless (or ok (>= attempt 5))
                  (run-with-timer 8 nil (lambda () (fetch))))))
            nil t)))
      (fetch))))

(use-package gptel
  :load-path (lambda () (expand-file-name "site-lisp/gptel" user-emacs-directory))
  :config
  (require 'gptel-integrations)
  (setq
   gptel-model 'kimi-k2.5
   gptel-backend (gptel-make-openai "Exhub api" ;Any name you want
                   :host "127.0.0.1:9069"
                   :endpoint "/openai/v1/chat/completions"
                   :stream t            ;for streaming responses
                   :protocol "http"
                   :key "edmondfrank" ;can be a function that returns the key
                   ;; Seeded from `exhub-model-fallback'; `exhub-refresh-models'
                   ;; replaces it with the catalog served by ExHub (GET /llms).
                   :models (exhub-models--with-capabilities exhub-model-fallback)))
  ;; ExHub may still be booting when gptel loads; sync the catalog once it is up.
  (run-with-timer 5 nil #'exhub-refresh-models))

(use-package mcp
  :load-path (lambda () (expand-file-name "site-lisp/mcp.el" user-emacs-directory))
  :after gptel
  ;; ExHub's MCP Hub is one unified gateway (streamable HTTP) fronting every
  ;; upstream server (desktop, github, gitee, browser-use, brain, agent, ...).
  ;; It exposes two meta-tools rather than one endpoint per server:
  ;;   retrieve_tools : TF-IDF + Smart Decide search across all upstream tools
  ;;   call_tools     : invoke a tool as "{server}__{tool}"
  ;; Upstreams are managed via /mcp-hub/servers, so this list stays static.
  ;; Port 9069 = ExHub HTTP endpoint (same host as the gptel backend above).
  :custom (mcp-hub-servers
           `(("mcphub" . (:url "http://127.0.0.1:9069/mcp-hub/mcp"
                                :timeout 120))))
  :config (require 'mcp-hub)
  :hook (after-init . mcp-hub-start-all-server))

(use-package gptel-agent
  :load-path (lambda () (expand-file-name "site-lisp/gptel-agent" user-emacs-directory))
  :after gptel
  :config (gptel-agent-update))

(maybe-require-package 'templatel)
(use-package gptel-prompts
  :load-path (lambda () (expand-file-name "site-lisp/gptel-prompts" user-emacs-directory))
  :after gptel
  :demand t
  :config
  (gptel-prompts-update)
  ;; Ensure prompts are updated if prompt files change
  (gptel-prompts-add-update-watchers))

(global-set-key (kbd "C-c z") 'gptel-menu)
(global-set-key (kbd "C-c x") 'gptel-agent)

(use-package exhub-probe
  :bind (("C-c s s" . exhub-probe-search)
         ("C-c s q" . exhub-probe-at-point)
         ("C-c s g" . exhub-probe-glob)
         ("C-c s f" . exhub-probe-content))
  :config
  (setq exhub-probe-include-tests nil
        exhub-probe-max-results 100))

(use-package ai-code
  :load-path (lambda () (expand-file-name "site-lisp/ai-code-interface.el" user-emacs-directory))
  :bind ("C-c C-a" . ai-code-menu)      ; Set your favorite keybinding
  :config
  (ai-code-set-backend  'opencode) ;; use open-code as backend
  ;; Optional: Set up Magit integration for AI commands in Magit popups
  (with-eval-after-load 'magit
    (ai-code-magit-setup-transients)))

;; install claude-code-ide.el
(use-package claude-code-ide
  :load-path (lambda () (expand-file-name "site-lisp/claude-code-ide.el" user-emacs-directory))
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (setenv "ANTHROPIC_MODEL" "openai/kimi-k2-instruct")
  (setenv "ANTHROPIC_SMALL_FAST_MODEL" "openai/kimi-k2-instruct")
  (setenv "ANTHROPIC_BASE_URL" "http://127.0.0.1:9069")
  (setenv "ANTHROPIC_AUTH_TOKEN" "edmondfrank")
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools

(provide 'init-exhub)
;;; init-exhub.el ends here
