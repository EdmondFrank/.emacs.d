;;; init-gemini.el --- Basic support for Google Bard -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/Gemini.el" user-emacs-directory))

(require 'gemini)

(setq gemini-api-token "your token")

(setq gemini-http-proxy "http://localhost:1081")

(gemini-start-process)

(provide 'init-gemini)
;;; init-gemini.el ends here
