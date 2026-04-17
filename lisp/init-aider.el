;;; init-aider.el --- Basic support for Aider -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/aider.el" user-emacs-directory))

(require 'aider)

(setq aider-program (expand-file-name "miniconda3/bin/aider-ce" (getenv "HOME")))
;; (setq aider-program (expand-file-name ".local/bin/aider" (getenv "HOME")))

(setenv "OPENAI_API_BASE" "http://localhost:9069/openai/v1")
(setenv "OPENAI_API_KEY" "edmondfrank")
(setenv "ANTHROPIC_API_BASE" "http://localhost:9069/anthropic")
(setenv "ANTHROPIC_API_KEY" "edmondfrank")
(setenv "LITELLM_ANTHROPIC_DISABLE_URL_SUFFIX" "false")

;; (setq aider-args '("--linear-output" "--no-auto-commits" "--no-show-model-warnings" "--analytics-disable" "--no-auto-accept-architect" "--yes-always" "--disable-playwright" "--model" "openai/minimax-m2.1" "--agent" "--use-enhanced-map" "--enable-context-compaction" "--map-tokens" "0"))

;; --analytics-disable --no-auto-commits --no-show-model-warnings --yes-always --model openai/kimi-k2.5 --editor-model openai/kimi-k2-instruct --editor-edit-format editor-diff --map-tokens 0

(setq aider-args '("--command-prefix" "rtk" "--linear-output" "--no-auto-commits" "--no-show-model-warnings" "--analytics-disable" "--auto-accept-architect" "--agent" "--yes-always" "--disable-playwright" "--model" "openai/kimi-k2.5" "--editor-model" "anthropic/claude-sonnet-4-20250514" "--weak-model" "openai/minimax-m2.5" "--editor-edit-format" "editor-diff" "--enable-context-compaction" "--map-tokens" "0"))

(setq aider-popular-models '("openai/glm-4_5"
                             "openai/glm-4.6"
                             "openai/glm-4.7"
                             "openai/glm-5"
                             "openai/glm-5.1"
                             "openai/glm-5-turbo"
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
                             "openai/qwen3-coder-next"
                             "openai/qwen3.5-27b-claude-4.6-opus-reasoning-distilled"
                             "openai/tngtech/deepseek-r1t2-chimera:free"
                             "openai/minimax-m2"
                             "openai/minimax-m2.1"
                             "openai/minimax-m2.5"
                             "openai/minimax-m2.7"
                             "openai/minimax-m2-preview"
                             "openai/minimax/minimax-m2:free"
                             "openai/kimi-k2.5"
                             "openai/kimi-k2-instruct"
                             "openai/kimi-k2-thinking"
                             "openai/kimi-for-coding"
                             "openai/openrouter/polaris-alpha"
                             "mistral/mistral-large-latest"
                             "codestral/codestral-latest"
                             "anthropic/claude-opus-4-6"
                             "anthropic/claude-sonnet-4-6"
                             "anthropic/claude-opus-4-5-20251101"
                             "anthropic/claude-sonnet-4-20250514"
                             "anthropic/claude-haiku-4-5-20251001"
                             "anthropic/claude-sonnet-4-5-20250929"
                             ))


(global-set-key (kbd "C-c q") 'aider-transient-menu)

(provide 'init-aider)
;;; init-aider.el ends here
