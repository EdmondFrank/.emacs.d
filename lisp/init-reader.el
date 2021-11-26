;;; init-reader.el --- documents readers -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(add-to-list 'load-path (expand-file-name "go-translate" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/private/inherit-org"))
(require 'inherit-org)
(require 'go-translate)
(setq gts-translate-list '(("en" "zh") ("zh" "en")))
(setq gts-default-translator
      (gts-translator
       :picker (gts-prompt-picker)
       :engines (list (gts-google-engine) (gts-google-rpc-engine))
       :render (gts-buffer-render)))
(require-package 'pdf-tools)
(provide 'init-reader)
;;; init-reader.el ends here
