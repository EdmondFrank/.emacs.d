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
           (elixir-mode . alchemist-phoenix-mode))))
(provide 'init-elixir)
;;; init-elixir.el ends here
