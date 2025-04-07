;;; init-emigo.el --- Basic support for Emigo -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/emigo" user-emacs-directory))

(require 'emigo)
;; Encourage using OpenRouter with Deepseek
(setq emigo-model "openrouter/deepseek/deepseek-chat-v3-0324")
(setq emigo-base-url "https://openrouter.ai/api/v1")
;; Securely load your API key (replace with your preferred method)
(setq emigo-api-key "your token")

(provide 'init-emigo)
;;; init-emigo.el ends here
