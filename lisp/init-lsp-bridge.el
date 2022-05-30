;; init-lsp-bridge.el --- Initialize LspBridge configurations.	-*- lexical-binding: t -*-
;;; Commentary:
;;
;; LspBridge configuration
;;

;;; Code:
(add-to-list 'load-path (expand-file-name "site-lisp/lsp-bridge" user-emacs-directory))

(require 'lsp-bridge)
(require 'corfu-history)
(require 'lsp-bridge-orderless)   ;; make lsp-bridge support fuzzy match, optional
(corfu-history-mode t)
(global-lsp-bridge-mode)
(when (> (frame-pixel-width) 3000) (custom-set-faces '(corfu-default ((t (:height 1.3))))))  ;; adjust default font height when running in HiDPI screen.

(add-hook 'lsp-bridge-mode-hook
          (lambda ()
            (add-hook 'xref-backend-functions #'lsp-bridge-xref-backend nil t)
            (define-key lsp-bridge-mode-map (kbd "C-j") 'lsp-bridge-popup-documentation-scroll-up)
            (define-key lsp-bridge-mode-map (kbd "C-k") 'lsp-bridge-popup-documentation-scroll-down)))

;; (setq lsp-bridge-enable-log t)

(require-package 'yafolding)
(add-hook 'prog-mode-hook (lambda () (yafolding-mode)))

(provide 'init-lsp-bridge)
;;; init-lsp-bridge.el ends here
