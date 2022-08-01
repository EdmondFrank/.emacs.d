;; init-lsp-bridge.el --- Initialize LspBridge configurations.	-*- lexical-binding: t -*-
;;; Commentary:
;;
;; LspBridge configuration
;;

;;; Code:
(add-to-list 'load-path (expand-file-name "site-lisp/lsp-bridge" user-emacs-directory))

(require 'lsp-bridge)

(global-lsp-bridge-mode)
(setq acm-enable-icon nil)
(add-hook 'lsp-bridge-mode-hook
          (lambda ()
            (define-key lsp-bridge-mode-map (kbd "C-j") 'lsp-bridge-popup-documentation-scroll-up)
            (define-key lsp-bridge-mode-map (kbd "C-k") 'lsp-bridge-popup-documentation-scroll-down)))

;; (setq lsp-bridge-enable-log t)

(require-package 'yafolding)
(add-hook 'prog-mode-hook (lambda () (yafolding-mode)))

(provide 'init-lsp-bridge)
;;; init-lsp-bridge.el ends here
