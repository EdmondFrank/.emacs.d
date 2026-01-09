;;; init-aider.el --- Basic support for Aider -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/aider.el" user-emacs-directory))

(require 'aider)

(setq aider-program (expand-file-name "miniconda3/bin/aider-ce" (getenv "HOME")))
;; (setq aider-program (expand-file-name ".local/bin/aider" (getenv "HOME")))

(setenv "OPENAI_API_BASE" "http://localhost:9069/openai/v1")
(setenv "OPENAI_API_KEY" "edmondfrank")

(setq aider-args '("--linear-output" "--no-auto-commits" "--no-show-model-warnings" "--analytics-disable" "--no-auto-accept-architect" "--yes-always" "--disable-playwright" "--agent" "--use-enhanced-map" "--enable-context-compaction" "--map-tokens" "0"))
;; (setq aider-args '("--no-auto-commits" "--yes" "--architect" "--model" "openai/minimax-m2" "--editor-model" "openai/qwen3-next-80b-a3b-instruct" "--weak-model" "openai/kimi-k2-instruct" "--editor-edit-format" "editor-diff" "--map-tokens" "0"))

(setq aider-popular-models '("openai/glm-4_5"
                             "openai/glm-4.6"
                             "openai/glm-4.7"
                             "openai/glm-4_5v"
                             "openai/gemini-2.5-pro"
                             "openai/deepseek-r1"
                             "openai/deepseek-v3"
                             "openai/deepseek-v3_1"
                             "openai/deepseek-v3.2"
                             "openai/deepseek-v3.2-exp"
                             "openai/deepseek-v3_1-terminus"
                             "openai/gpt-oss-120b"
                             "openai/qwen3-235b-a22b"
                             "openai/qwen3-235b-a22b-instruct-2507"
                             "openai/qwen3-next-80b-a3b-thinking"
                             "openai/qwen3-next-80b-a3b-instruct"
                             "openai/qwen3-coder-480b-a35b-instruct"
                             "openai/tngtech/deepseek-r1t2-chimera:free"
                             "openai/minimax-m2"
                             "openai/minimax-m2.1"
                             "openai/minimax-m2-preview"
                             "openai/minimax/minimax-m2:free"
                             "openai/kimi-k2-instruct"
                             "openai/kimi-k2-thinking"
                             "openai/kimi-for-coding"
                             "openai/openrouter/polaris-alpha"
                             "mistral/mistral-large-latest"
                             "codestral/codestral-latest"
                             ))


(global-set-key (kbd "C-c q") 'aider-transient-menu)

(provide 'init-aider)
;;; init-aider.el ends here
