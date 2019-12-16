;;; init-noter.el --- emacs notes recorder and manager -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'org-noter)
(require-package 'deft)
;; Global settings (defaults)
(defcustom my-deft-directory (expand-file-name "~/GTD/")
  "Deft directory."
  :type 'directory
  :safe 'stringp
  :group 'deft)
(setq default-directory (expand-file-name my-deft-directory))
(provide 'init-noter)
;;; init-noter.el ends here
