;;; init-appine.el --- Basic support for Appine -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/appine" user-emacs-directory))
(require 'appine)

(setq appine-use-for-org-links t)
(global-set-key (kbd "C-x a a") 'appine)
(global-set-key (kbd "C-x a u") 'appine-open-url)
(global-set-key (kbd "C-x a o") 'appine-open-file)

(defun appine-open-pdf-advice (orig-fn file &rest args)
  "Open PDF files with Appine instead of the default Emacs viewer."
  (if (and (stringp file)
           (string-match-p "\\.pdf\\'" file)
           (called-interactively-p 'interactive))
      (appine-open-file file)
    (apply orig-fn file args)))

;; Route PDFs opened via find-file to Appine's PDFKit viewer
(advice-add #'find-file :around #'appine-open-pdf-advice)

(provide 'init-appine)
;;; init-appine.el ends here
