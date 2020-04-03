;;; init-keybindings.el --- Custom keybinding -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;;custom keybinding
(global-set-key (kbd "C-\\") 'toggle-input-method)

(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "S-SPC") 'set-mark-command)

(global-unset-key (kbd "C-x C-b"))
(global-set-key (kbd "C-S-b") 'ibuffer)

;; Try use counsel-grep to replace swiper
(global-unset-key (kbd "C-s"))
(global-set-key (kbd "C-s") 'swiper-isearch)

(global-set-key (kbd "C-f") 'deadgrep)

(global-set-key (kbd "<f2>") 'projectile-find-file)

(global-set-key (kbd "C-S-f") 'xref-find-references)
(global-set-key (kbd "C-.") 'dumb-jump-go)
(global-set-key (kbd "C-,") 'dumb-jump-back)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo tree mode                                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; make ctrl-z undo
(global-set-key (kbd "C-z") 'undo)
;; make ctrl-Z redo
(global-set-key (kbd "C-S-z") 'redo)
(provide 'init-keybindings)
;;; init-keybindings.el ends here
