;;; init-bard.el --- Basic support for Google Bard -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/Bard.el" user-emacs-directory))

(setq bard-http-proxy "http://localhost:1081")

(require 'bard)

(provide 'init-bard)
;;; init-bard.el ends here
