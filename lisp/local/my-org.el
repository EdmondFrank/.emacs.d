;;; my-org.el --- Extras for upstream init-org -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream init-org.el covers the basics; these are the fork's additions to
;; the personal GTD setup in ~/GTD.

;;; Code:

;; Inline preview of formats Emacs may have been built without (webp): let an
;; external converter (ffmpeg) handle them.
(setq image-use-external-converter t)

(when (maybe-require-package 'org-download)
  ;; Drag and drop images from dired into a note.
  (add-hook 'dired-mode-hook 'org-download-enable))

(require-package 'org-modern)
(add-hook 'org-mode-hook 'org-modern-mode)

(setq org-agenda-files '("~/GTD/todos.org"))

(when (maybe-require-package 'org-contacts)
  (setq org-contacts-files (file-expand-wildcards "~/GTD/contacts.org")))

(require-package 'org-present)
(with-eval-after-load 'org-present
  (setq org-present-text-scale 3)
  (add-hook 'org-present-mode-hook
            (lambda ()
              (org-present-big)
              (org-display-inline-images)
              (org-present-hide-cursor)
              (org-present-read-only)))
  (add-hook 'org-present-mode-quit-hook
            (lambda ()
              (org-present-small)
              (org-remove-inline-images)
              (org-present-show-cursor)
              (org-present-read-write))))

(provide 'my-org)
;;; my-org.el ends here