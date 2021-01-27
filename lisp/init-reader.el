;;; init-reader.el --- documents readers -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(require-package 'pdf-tools)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/private/inherit-org"))
(require 'inherit-org)
(provide 'init-reader)
;;; init-reader.el ends here
