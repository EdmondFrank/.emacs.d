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

(setq exhub-fim-provider 'openai-compatible)

(use-package gptel
  :load-path (lambda () (expand-file-name "site-lisp/gptel" user-emacs-directory))
  :config
  (require 'gptel-integrations)
  (setq
   gptel-model 'qwen3-next-80b-a3b-instruct
   gptel-backend (gptel-make-openai "Exhub api" ;Any name you want
                   :host "127.0.0.1:9069"
                   :endpoint "/openai/v1/chat/completions"
                   :stream t            ;for streaming responses
                   :protocol "http"
                   :key "edmondfrank" ;can be a function that returns the key
                   :models '((step3
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
                             tngtech/deepseek-r1t2-chimera:free minimax-m2 minimax-m2-preview qwen3-235b-a22b-instruct-2507 qwen3-coder-480b-a35b-instruct kimi-k2-instruct kimi-k2-thinking deepseek-v3_1 glm-4_5 glm-4.6 deepseek-v3.2 deepseek-v3.2-exp deepseek-v3_1-terminus gemini-2.5-pro qwen3-next-80b-a3b-instruct qwen3-next-80b-a3b-thinking qwen3-235b-a22b))))

(use-package mcp
  :load-path (lambda () (expand-file-name "site-lisp/mcp.el" user-emacs-directory))
  :after gptel
  :custom (mcp-hub-servers
           `(("probe" . (:command "bunx" :args ("-y" "@buger/probe-mcp")))
             ("commander" . (:command "bunx" :args ("-y" "@wonderwhy-er/desktop-commander")))
             ("web-scout" . (
                             :command "bunx"
                             :args ("-y" "@pinkpixel/web-scout-mcp")
                             :env (
                                   :HTTP_PROXY "https://127.0.0.1:7890"
                                   :HTTPS_PROXY "https://127.0.0.1:7890")))))
  :config (require 'mcp-hub)
  :hook (after-init . mcp-hub-start-all-server))

(use-package gptel-aibo
  :load-path (lambda () (expand-file-name "site-lisp/gptel-aibo" user-emacs-directory))
  :after (gptel)
  :config
  (define-key gptel-aibo-mode-map
              (kbd "C-c /") #'gptel-aibo-apply-last-suggestions))

(global-set-key (kbd "C-c z") 'gptel-menu)
(global-set-key (kbd "C-c x") 'gptel-aibo)

(use-package probe-search
  :load-path (lambda () (expand-file-name "site-lisp/probe.el" user-emacs-directory))
  :bind (("C-c s s" . probe-search)
         ("C-c s q" . probe-query)
         ("C-c s m" . probe-query-method)
         ("C-c s c" . probe-query-class)
         ("C-c s f" . probe-query-function))
  :config
  (setq probe-search-command "probe"
        probe-search-use-project-root t
        probe-search-include-tests nil
        probe-search-max-results 100))

(use-package claude-code
  :load-path (lambda () (expand-file-name "site-lisp/claude-code.el" user-emacs-directory))
  :bind ("C-c C-v" . claude-code-transient)      ; Set your favorite keybinding
  :config
  (setenv "HTTP_PROXY" "http://127.0.0.1:7890")
  (setenv "HTTPS_PROXY" "http://127.0.0.1:7890")
  (setq claude-code-program "gemini")
  (setq claude-code-terminal-backend 'vterm)
  (claude-code-mode))

(use-package ai-code
  :load-path (lambda () (expand-file-name "site-lisp/ai-code-interface.el" user-emacs-directory))
  :after (claude-code)
  :bind ("C-c C-a" . ai-code-menu)      ; Set your favorite keybinding
  :config
  (ai-code-set-backend  'opencode) ;; use open-code as backend
  (setq claude-code-terminal-backend 'vterm)
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
