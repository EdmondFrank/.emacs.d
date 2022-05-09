;; init-elixir.el --- Initialize elixir configurations.	-*- lexical-binding: t -*-
;;; Commentary:
;;
;; Elixir configurations.
;;

;;; Code:

(use-package elixir-mode
  :config
  (use-package alchemist
    :hook ((elixir-mode . alchemist-mode)
           (elixir-mode . alchemist-phoenix-mode)))
  (use-package eglot
    :hook ((elixir-mode . eglot-ensure))
    :init (add-to-list 'exec-path (expand-file-name "elixir-ls-1.13" user-emacs-directory)))

  (use-package flycheck-credo
    :after flycheck
    :init (flycheck-credo-setup)))
(provide 'init-elixir)
;;; init-elixir.el ends here
