;;; init-sidebar.el --- Customize emacs sidebar -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'treemacs)

;; Add global keybindings
(global-set-key (kbd "C-x C-d") 'treemacs)

;; customize settings
(setq treemacs-follow-mode t)
(setq treemacs-filewatch-mode t)
(setq treemacs-show-cursor t)
(setq treemacs-width 44)

(provide 'init-sidebar)
;;; init-sidebar.el ends here
