;;; init-aider.el --- Basic support for Aider -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/aider.el" user-emacs-directory))

(require 'aider)
(setq aider-program (expand-file-name ".local/bin/aider" (getenv "HOME")))

(setenv "OPENAI_API_BASE" "http://localhost:9069/openai/v1")
(setenv "OPENAI_API_KEY" "edmondfrank")

(setq aider-args '("--no-auto-commits" "--model" "openai/cursor/gpt-4.1" "--weak-model" "openai/cursor/gpt-4o-mini" "--editor-model" "openai/qwen3-235b-a22b" "--map-tokens" "4096"))

(setq aider-popular-models '("openai/cursor/gpt-4.1"
                             "openai/cursor/gpt-4o-mini"
                             "openai/deepseek-v3"
                             "openai/cursor/claude-3.7-sonnet"
                             "openai/qwen3-235b-a22b"
                             "mistral/mistral-large-latest"
                             "codestral/codestral-latest"
                             ))


(global-set-key (kbd "C-c q") 'aider-transient-menu)

(provide 'init-aider)
;;; init-aider.el ends here
