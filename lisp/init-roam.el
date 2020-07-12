;;; init-roam.el --- A plain-text personal knowledge management system -*- lexical-binding: t -*-
;;; Commentary:

;; Private and Secure
;; Edit your personal wiki completely offline, entirely in your control. Encrypt your notes with GPG. Take lasting notes in plain-text.

;; Make Connections
;; Connect notes and thoughts together with ease using backlinks. Discover surprising and previously unseen connections in your notes with the built-in graph visualization.

;; Extensible and Powerful
;; Leverage Emacs' fantastic text-editing interface, and the mature Emacs and Org-mode ecosystem of packages.

;; Free and Open Source
;; Org-roam is licensed under the GNU General Public License version 3 or later. You are free to extend its functionality and contribute back. Find us here.

;;; Code:
(require-package 'org-roam)

(add-hook 'after-init-hook 'org-roam-mode)

(setq org-roam-directory "~/GTD/roam")

(with-eval-after-load 'org-roam-mode
  (define-key org-roam-mode-map (kbd "C-c n l") 'org-roam)
  (define-key org-roam-mode-map (kbd "C-c n f") 'org-roam-find-file)
  (define-key org-roam-mode-map (kbd "C-c n g") 'org-roam-graph-show))

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c n i") 'org-roam-insert)
  (define-key org-mode-map (kbd "C-c n I") 'org-roam-insert-immediate))

(provide 'init-roam)
;;; init-roam.el ends here
