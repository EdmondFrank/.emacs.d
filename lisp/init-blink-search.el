;; init-blink-search.el --- Initialize BlinkSearch configurations.	-*- lexical-binding: t -*-
;;; Commentary:
;;
;; BlinkSearch configuration
;;

;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/blink-search" user-emacs-directory))
(require 'blink-search)

(setq blink-search-posframe-standalone nil)
(setq blink-search-enable-posframe nil)
(setq blink-search-enable-icon nil)
(setq blink-search-enable-debug nil)
(setq blink-search-db-path (expand-file-name "priv/snails.db" user-emacs-directory))
(setq blink-search-search-backends '("Buffer List" "Recent File" "IMenu" "Elisp Symbol" "Key Value"))

(provide 'init-blink-search)
;;; init-blink-search.el ends here
