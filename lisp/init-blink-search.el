;; init-blink-search.el --- Initialize BlinkSearch configurations.	-*- lexical-binding: t -*-
;;; Commentary:
;;
;; BlinkSearch configuration
;;

;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/blink-search" user-emacs-directory))
(require 'blink-search)

(setq blink-search-enable-posframe t)
(setq blink-search-enable-icon nil)
(setq blink-search-backends '("Buffer List" "Common Directory" "Find File" "Recent File" "IMenu" "Elisp Symbol"))

(provide 'init-blink-search)
;;; init-blink-search.el ends here
