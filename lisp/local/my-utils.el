;;; my-utils.el --- Adjustments to upstream init-utils -*- lexical-binding: t -*-

;;; Commentary:

;; Third-party snippets still call the pre-24.4 `after-load' macro; keep the
;; compatibility alias upstream no longer defines.

;;; Code:

(define-obsolete-function-alias 'after-load 'with-eval-after-load "24.4")

(provide 'my-utils)
;;; my-utils.el ends here