;;; init-aider.el --- Basic support for Aider -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/aider.el" user-emacs-directory))

(require 'aider)

(setq aider-args '("--no-auto-commits" "--model" "openai/Qwen/Qwen2.5-Coder-32B-Instruct"))
(setenv "OPENAI_API_BASE" "https://api.siliconflow.cn/v1/")
(setenv "OPENAI_API_KEY" "your api token")


(global-set-key (kbd "C-c q") 'aider-transient-menu)

(provide 'init-aider)
;;; init-aider.el ends here
