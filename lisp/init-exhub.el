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
  :config
  (require 'gptel-integrations)
  (setq
   gptel-model 'Qwen3-235B-A22B
   gptel-backend (gptel-make-openai "Cursor api" ;Any name you want
                   :host "127.0.0.1:9069"
                   :endpoint "/openai/v1/chat/completions"
                   :stream t            ;for streaming responses
                   :protocol "http"
                   :models '(gpt-4o-mini))))

(use-package mcp
  :load-path (lambda () (expand-file-name "site-lisp/mcp.el" user-emacs-directory))
  :after gptel
  :custom (mcp-hub-servers
           `(("probe" . (:command "mcp-go-probe" :args ("-y")))))
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


(provide 'init-exhub)
;;; init-exhub.el ends here
