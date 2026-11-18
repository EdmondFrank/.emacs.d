;;; my-corfu.el --- Adjustments to upstream init-corfu -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream enables corfu-terminal below Emacs 31 so completion also works in
;; a TTY.  This fork works in GUI frames only and leaves corfu-terminal off.

;;; Code:

;; Registered after upstream's own `with-eval-after-load', so this runs second
;; and wins when corfu loads.
(with-eval-after-load 'corfu
  (when (fboundp 'corfu-terminal-mode)
    (corfu-terminal-mode -1)))

(provide 'my-corfu)
;;; my-corfu.el ends here