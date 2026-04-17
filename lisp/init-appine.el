;;; init-appine.el --- Basic support for Appine -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/appine" user-emacs-directory))
(require 'appine)

(setq appine-use-for-org-links t)
(global-set-key (kbd "C-x a a") 'appine)
(global-set-key (kbd "C-x a u") 'appine-open-url)
(global-set-key (kbd "C-x a o") 'appine-open-file)

(provide 'init-appine)
;;; init-appine.el ends here
