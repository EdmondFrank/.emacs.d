;;; init-gemini.el --- Basic support for Google Bard -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/Gemini.el" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp/aider.el" user-emacs-directory))

(require 'aider)
(require 'gemini)

(setq gemini-api-token "your token")

(setq gemini-http-proxy "http://localhost:1081")

(gemini-start-process)

;; (setenv "HTTPS_PROXY" "http://localhost:1081")

(setq aider-args '("--no-auto-commits" "--model" "openai/Qwen/Qwen2.5-Coder-7B-Instruct"))
(setenv "OPENAI_API_BASE" "https://api.siliconflow.cn/v1/")
(setenv "OPENAI_API_KEY" "access-token")



(global-set-key (kbd "C-c q") 'aider-transient-menu)

(provide 'init-gemini)
;;; init-gemini.el ends here
