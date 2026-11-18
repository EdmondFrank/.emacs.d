;;; my-gui-frames.el --- Adjustments to upstream init-gui-frames -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream unbinds C-wheel and C-mouse-4/5 so that `text-scale-mode' owns the
;; bindings.  This fork keeps Emacs's default wheel text scaling.

;;; Code:

(with-eval-after-load 'init-gui-frames
  (global-set-key (kbd "C-<wheel-down>") 'text-scale-decrease)
  (global-set-key (kbd "C-<wheel-up>") 'text-scale-increase)
  (global-set-key (kbd "C-<mouse-4>") 'text-scale-increase)
  (global-set-key (kbd "C-<mouse-5>") 'text-scale-decrease))

(provide 'my-gui-frames)
;;; my-gui-frames.el ends here