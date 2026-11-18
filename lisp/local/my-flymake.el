;;; my-flymake.el --- Adjustments to upstream init-flymake -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream turns flymake on for every prog/text buffer.  This fork checks on
;; the fly via flycheck (and eglot where a server is attached), so the blanket
;; activation is removed after init-flymake loads instead of editing that file.

;;; Code:

(with-eval-after-load 'init-flymake
  (remove-hook 'flymake-mode-hook 'flymake-flycheck-auto)
  (remove-hook 'prog-mode-hook 'flymake-mode)
  (remove-hook 'text-mode-hook 'flymake-mode))

(provide 'my-flymake)
;;; my-flymake.el ends here