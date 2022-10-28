;; init-deno-bridge.el --- Initialize DenoBridge configurations.	-*- lexical-binding: t -*-
;;; Commentary:
;;
;; DenoBridge configuration
;;

;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/emacs-websocket" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp/deno-bridge" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp/insert-translated-name" user-emacs-directory))

(require 'deno-bridge)

(require 'insert-translated-name)

(provide 'init-deno-bridge)
;;; init-deno-bridge.el ends here
