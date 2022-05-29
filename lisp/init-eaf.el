;; init-eaf.el --- Initialize EAF configurations.	-*- lexical-binding: t -*-
;;; Commentary:
;;
;; Emacs Application Framework configuration
;;

;;; Code:
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")

(require 'eaf)
(require 'eaf-video-player)
(require 'eaf-org-previewer)
(require 'eaf-markdown-previewer)
(require 'eaf-image-viewer)
(require 'eaf-mindmap)
(require 'eaf-file-manager)
(require 'eaf-jupyter)
(require 'eaf-pdf-viewer)
(require 'eaf-browser)
(require 'eaf-git)

(setq eaf-proxy-type "http")
(setq eaf-proxy-host "127.0.0.1")
(setq eaf-proxy-port "1081")

(provide 'init-eaf)
;;; init-eaf.el ends here
