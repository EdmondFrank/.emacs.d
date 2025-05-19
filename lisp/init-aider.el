;;; init-aider.el --- Basic support for Aider -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/aider.el" user-emacs-directory))

(require 'aider)
(setq aider-program (expand-file-name ".local/bin/aider" (getenv "HOME")))
(setq aider-args '("--no-auto-commits" "--model" "openai/Qwen/Qwen2.5-Coder-32B-Instruct"))
(setenv "OPENAI_API_BASE" "https://api.siliconflow.cn/v1/")
(setenv "OPENAI_API_KEY" "your api token")
(setq aider-popular-models '("openai/gpt-4.1"
                             "openai/gpt-4o-mini"
                             "openai/deepseek-v3"
                             "openai/claude-3.7-sonnet"
                             "openai/gemini-2.5-pro-exp-03-25"
                             ))


(global-set-key (kbd "C-c q") 'aider-transient-menu)

(provide 'init-aider)
;;; init-aider.el ends here
