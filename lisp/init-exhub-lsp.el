;;; init-exhub-lsp.el --- ExHub LSP client (replaces lsp-bridge) -*- lexical-binding: t -*-
;;; Commentary:
;;
;; ExHub is now the LSP client.  The `Exhub.LspBridge' Elixir backend owns the
;; language servers and `exhub-lsp.el' is the Emacs front end; the Python
;; lsp-bridge bridge has been removed.
;;
;; acm — the completion menu — used to ship inside the lsp-bridge submodule.
;; It is now vendored under `site-lisp/exhub/vendor/acm', so the menu depends
;; only on ExHub.  The handful of acm backends that call into lsp-bridge
;; (`acm-enable-ctags', `acm-enable-telega', plus the already-off copilot /
;; codeium / tabnine ones) are disabled below, leaving acm standalone.
;;
;;; Code:

;; acm (vendored into ExHub) backs `acm-backend-exhub-lsp.el'.  Put it on
;; `load-path' before anything requires it.
(add-to-list 'load-path (expand-file-name "site-lisp/exhub/vendor/acm" user-emacs-directory))

(require 'acm)

;; acm configuration (moved from the retired init-lsp-bridge.el).
(setq acm-enable-yas t)
(setq acm-enable-icon nil)
(setq acm-enable-citre nil)
(setq acm-enable-tabnine nil)
(setq acm-enable-codeium nil)
(setq acm-enable-copilot nil)
(setq acm-enable-ctags nil)     ; would call lsp-bridge-call-async
(setq acm-enable-telega nil)    ; would reference lsp-bridge-mode
(setq acm-enable-tabby nil)
(setq acm-enable-jupyter nil)
(setq acm-enable-capf nil)

(setq acm-completion-backend-merge-order '("codeium-candidates"
                                           "mode-first-part-candidates"
                                           "template-first-part-candidates"
                                           "tabnine-candidates"
                                           "copilot-candidates"
                                           "template-second-part-candidates"
                                           "mode-second-part-candidates"))

;;; The ExHub LSP client.

(require 'exhub-lsp)

;; Manual completion by default, as `lsp-bridge-complete-manually' used to be.
(setq exhub-lsp-completion-auto nil)

;; Languages ExHub serves (see `exhub-lsp-language-id-alist').
(setq exhub-lsp-enabled-modes '(elixir-mode elixir-ts-mode
                                python-mode python-ts-mode
                                js-mode js-ts-mode typescript-ts-mode
                                ruby-mode ruby-ts-mode
                                go-mode go-ts-mode
                                rust-mode rust-ts-mode
                                c-mode c-ts-mode c++-mode c++-ts-mode))

(defun exhub-lsp-auto-mode ()
  "Toggle automatic completion, mirroring the old `lsp-bridge-auto-mode'."
  (interactive)
  (if exhub-lsp-completion-auto
      (progn (setq exhub-lsp-completion-auto nil)
             (message "exhub-lsp auto mode off"))
    (setq exhub-lsp-completion-auto t)
    (message "exhub-lsp auto mode on")))

;; Keep the lsp-bridge `C-b' completion prefix (muscle memory).  The TRAMP
;; remote-file keys (`C-b o'/`C-b k') are dropped — ExHub has no remote layer —
;; and the documentation-scroll keys `C-j'/`C-k' are gone: acm scrolls its own
;; documentation frame while the menu is up.
(define-key exhub-lsp-mode-map (kbd "C-b d") #'exhub-lsp-hover)
(define-key exhub-lsp-mode-map (kbd "C-b v") #'exhub-lsp-completion)
(define-key exhub-lsp-mode-map (kbd "C-b a") #'exhub-lsp-auto-mode)
(define-key exhub-lsp-mode-map (kbd "C-b f") #'exhub-lsp-format)
(define-key exhub-lsp-mode-map (kbd "C-b s") #'exhub-lsp-document-symbols)
(define-key exhub-lsp-mode-map (kbd "C-b S") #'exhub-lsp-workspace-symbols)
(define-key exhub-lsp-mode-map (kbd "C-b r") #'exhub-lsp-rename)
(define-key exhub-lsp-mode-map (kbd "C-b t") #'exhub-fim-show-suggestion)
(define-key exhub-lsp-mode-map (kbd "C-b TAB") #'exhub-fim-accept-suggestion)
(define-key exhub-lsp-mode-map (kbd "C-b m") #'exhub-fim-complete-with-minibuffer)

(exhub-lsp-global-mode 1)

(require-package 'yafolding)
(add-hook 'prog-mode-hook (lambda () (yafolding-mode)))

(provide 'init-exhub-lsp)
;;; init-exhub-lsp.el ends here