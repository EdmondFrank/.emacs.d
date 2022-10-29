;;; init-reader.el --- documents readers -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(add-to-list 'load-path (expand-file-name "site-lisp/go-translate" user-emacs-directory))
(require 'go-translate)

(setq gts-translate-list '(("en" "zh") ("zh" "en")))
(setq gts-default-translator
      (gts-translator
       :picker (gts-prompt-picker)
       :engines (list (gts-google-engine) (gts-google-rpc-engine))
       :render (gts-buffer-render)))

(use-package calibredb
  :defer t
  :config
  (setq calibredb-root-dir "~/Documents/CalibreLibrary")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist '(("~/Documents/CalibreLibrary"))))
(require-package 'pdf-tools)
(provide 'init-reader)
;;; init-reader.el ends here
