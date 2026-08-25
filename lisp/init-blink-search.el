;; init-blink-search.el --- Initialize BlinkSearch configurations.	-*- lexical-binding: t -*-
;;; Commentary:
;;
;; BlinkSearch (ExHub frontend) configuration
;; The legacy Python/EPC package has been replaced by `blink-search-exhub',
;; which is loaded from `init-exhub.el'.
;;

;;; Code:

(setq blink-search-exhub-kv-db-path (expand-file-name "priv/snails.db" user-emacs-directory))
(setq blink-search-exhub-kv-db-table "kvstore")
(setq blink-search-exhub-search-backends '("Buffer List" "Find File" "Recent File" "IMenu" "Elisp Symbol" "Key Value"))

(provide 'init-blink-search)
;;; init-blink-search.el ends here
