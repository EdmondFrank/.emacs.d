;; init-lsp-bridge.el --- Initialize LspBridge configurations.	-*- lexical-binding: t -*-
;;; Commentary:
;;
;; LspBridge configuration
;;

;;; Code:
(add-to-list 'load-path (expand-file-name "site-lisp/lsp-bridge" user-emacs-directory))

(require 'lsp-bridge)
(global-lsp-bridge-mode)

(setq lsp-bridge-complete-manually t)
(setq lsp-bridge-enable-diagnosics nil)
(setq lsp-bridge-enable-search-words nil)
(setq lsp-bridge-enable-auto-format-code nil)
(setq lsp-bridge-enable-with-tramp nil)
(setq acm-enable-yas t)
(setq acm-enable-icon nil)
(setq acm-enable-citre nil)
(setq acm-enable-tabnine nil)
(setq acm-enable-codeium nil)

(setq acm-completion-backend-merge-order '("codeium-candidates"
                                           "mode-first-part-candidates"
                                           "template-first-part-candidates"
                                           "tabnine-candidates"
                                           "copilot-candidates"
                                           "template-second-part-candidates"
                                           "mode-second-part-candidates"))

(defun lsp-bridge-auto-mode ()
  "Switch on/off lsp-bridge auto mode."
  (interactive)
  (if lsp-bridge-complete-manually
      (or
       (setq lsp-bridge-complete-manually nil)
       (message "lsp-bridge auto mode on"))
    (and
     (setq lsp-bridge-complete-manually t)
     (message "lsp-bridge auto mode off"))))

(defun lsp-bridge-auto-format-mode ()
  "Switch on/off lsp-bridge auto mode."
  (interactive)
  (if lsp-bridge-enable-auto-format-code
      (or
       (setq lsp-bridge-enable-auto-format-code nil)
       (message "lsp-bridge auto format off"))
    (and
     (setq lsp-bridge-enable-auto-format-code t)
     (message "lsp-bridge auto format on"))))

(add-hook 'lsp-bridge-mode-hook
          (lambda ()
            (define-key lsp-bridge-mode-map (kbd "C-j") 'lsp-bridge-popup-documentation-scroll-up)
            (define-key lsp-bridge-mode-map (kbd "C-k") 'lsp-bridge-popup-documentation-scroll-down)
            (define-key lsp-bridge-mode-map (kbd "C-b d") 'lsp-bridge-popup-documentation)
            (define-key lsp-bridge-mode-map (kbd "C-b v") 'lsp-bridge-popup-complete-menu)
            (define-key lsp-bridge-mode-map (kbd "C-b a") 'lsp-bridge-auto-mode)
            (define-key lsp-bridge-mode-map (kbd "C-b f") 'lsp-bridge-auto-format-mode)
            (define-key lsp-bridge-mode-map (kbd "C-b o") 'lsp-bridge-open-remote-file)
            (define-key lsp-bridge-mode-map (kbd "C-b s") 'lsp-bridge-remote-save-buffer)
            (define-key lsp-bridge-mode-map (kbd "C-b k") 'lsp-bridge-remote-kill-buffer)
            (define-key lsp-bridge-mode-map (kbd "C-b t") 'exhub-fim-show-suggestion)
            (define-key lsp-bridge-mode-map (kbd "C-b TAB") 'exhub-fim-accept-suggestion)
            (define-key lsp-bridge-mode-map (kbd "C-b m") 'exhub-fim-complete-with-minibuffer))
          )
;; (setq lsp-bridge-enable-log t)

(require-package 'yafolding)
(add-hook 'prog-mode-hook (lambda () (yafolding-mode)))

(provide 'init-lsp-bridge)
;;; init-lsp-bridge.el ends here
