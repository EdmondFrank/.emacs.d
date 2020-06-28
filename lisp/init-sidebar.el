;;; init-sidebar.el --- Customize emacs sidebar -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'treemacs)
(require-package 'imenu-list)

;; Add global keybindings

;; treemacs
(global-set-key (kbd "C-x C-d") 'treemacs)

;; imenu-list
(global-set-key (kbd "C-'") 'imenu-list-smart-toggle)

;; customize settings

;; treemacs
(setq treemacs-follow-mode t)
(setq treemacs-filewatch-mode t)
(setq treemacs-show-cursor t)
(setq treemacs-width 44)

;; imenu-list
(setq imenu-list-auto-resize t)

(provide 'init-sidebar)
;;; init-sidebar.el ends here
