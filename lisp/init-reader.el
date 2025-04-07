;;; init-reader.el --- documents readers -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'nov)
(require-package 'pdf-tools)
(require-package 'proxy-mode)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(use-package calibredb
  :defer t
  :config
  (setq calibredb-root-dir "~/Documents/CalibreLibrary")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist '(("~/Documents/CalibreLibrary"))))
(provide 'init-reader)
;;; init-reader.el ends here
