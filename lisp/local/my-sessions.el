;;; my-sessions.el --- Session/desktop restore tuning -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream dropped the `session' package; this fork keeps it (it restores more
;; than the desktop does) and restores the desktop frames eagerly enough to be
;; usable over ssh/RustDesk.

;;; Code:

;; Read by `desktop-read', which runs from `after-init-hook', so setting these
;; during init is early enough.
(setq desktop-restore-frame nil
      desktop-restore-eager 2
      desktop-lazy-verbose nil)

(require-package 'session)
(setq session-save-file (locate-user-emacs-file ".session"))
;; session.el matches this with old-style `\\'`-free escaping; upstream's
;; variant ends the alternative with `\\'` and can mis-match in Emacs 29.
(setq session-name-disable-regexp "\\(?:\\`'/tmp\\|\\.git/[A-Z_]+'\\)")
(setq session-save-file-coding-system 'utf-8)

(add-hook 'after-init-hook 'session-initialize)

(provide 'my-sessions)
;;; my-sessions.el ends here