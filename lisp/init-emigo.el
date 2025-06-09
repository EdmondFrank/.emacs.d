;;; init-emigo.el --- Basic support for Emigo -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/emigo" user-emacs-directory))

(require 'emigo)

(setq emigo-model "openai/cursor/gpt-4o-mini")
(setq emigo-base-url "http://localhost:9069/openai/v1")
(setq emigo-api-key "edmondfrank")

;; Encourage using OpenRouter with Deepseek
;; (setq emigo-model "openrouter/google/gemini-2.5-pro-exp-03-25:free")
;; (setq emigo-base-url "https://openrouter.ai/api/v1")
;; Securely load your API key (replace with your preferred method)
(setq emigo-api-key "your token")

(provide 'init-emigo)
;;; init-emigo.el ends here
