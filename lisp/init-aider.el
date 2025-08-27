;;; init-aider.el --- Basic support for Aider -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/aider.el" user-emacs-directory))

(require 'aider)
(setq aider-program (expand-file-name ".local/bin/aider" (getenv "HOME")))

(setenv "OPENAI_API_BASE" "http://localhost:9069/openai/v1")
(setenv "OPENAI_API_KEY" "edmondfrank")

(setq aider-args '("--no-auto-commits" "--architect" "--model" "openai/deepseek-v3_1" "--editor-model" "openai/qwen3-coder-480b-a35b-instruct" "--editor-edit-format" "editor-diff" "--map-tokens" "0"))

(setq aider-popular-models '("openai/glm-4_5"
                             "openai/glm-4_5v"
                             "openai/gemini-2.5-pro"
                             "openai/deepseek-r1"
                             "openai/deepseek-v3"
                             "openai/deepseek-v3_1"
                             "openai/gpt-oss-120b"
                             "openai/qwen3-235b-a22b"
                             "openai/qwen3-235b-a22b-instruct-2507"
                             "openai/qwen3-coder-480b-a35b-instruct"
                             "openai/kimi-k2-instruct"
                             "mistral/mistral-large-latest"
                             "codestral/codestral-latest"
                             "openai/cursor/gpt-4.1"
                             "openai/cursor/gpt-4o-mini"
                             "openai/cursor/gemini-2.5-pro"
                             "openai/cursor/claude-3-5"
                             "openai/cursor/claude-3-5-sonnet-200k"
                             "openai/cursor/deepseek-r1"
                             "openai/cursor/claude-3.7-sonnet"
                             ))


(global-set-key (kbd "C-c q") 'aider-transient-menu)

(provide 'init-aider)
;;; init-aider.el ends here
