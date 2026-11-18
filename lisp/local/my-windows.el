;;; my-windows.el --- Adjustments to upstream init-windows -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream hijacks C-x o, C-x 2 and C-x 3.  This fork keeps the standard
;; bindings and moves the enhanced behaviour to C-x x / C-x _ / C-x |, with the
;; "instead" variants on their C- prefixed forms.

;;; Code:

(with-eval-after-load 'init-windows
  (global-set-key (kbd "C-x o") 'other-window)
  (global-set-key (kbd "C-x x") 'switch-window)

  (global-set-key (kbd "C-x 2") 'split-window-below)
  (global-set-key (kbd "C-x 3") 'split-window-right)
  (global-set-key (kbd "C-x _")
                  (split-window-func-with-other-buffer 'split-window-vertically))
  (global-set-key (kbd "C-x |")
                  (split-window-func-with-other-buffer 'split-window-horizontally))

  (global-set-key (kbd "C-x C-|") 'split-window-horizontally-instead)
  (global-set-key (kbd "C-x C-_") 'split-window-vertically-instead))

(provide 'my-windows)
;;; my-windows.el ends here