;;; my-misc.el --- Assorted fork defaults -*- lexical-binding: t -*-

;;; Commentary:

;; The grab-bag that used to sit after `(provide 'init)' in the fork's init.el:
;; site-lisp libraries that need loading, plus a few global defaults.

;;; Code:

;;--- site-lisp libraries ------------------------------------------------
(add-to-list 'load-path (expand-file-name "site-lisp/kubel" user-emacs-directory))
(require 'kubel)
(setq kubel-kubectl "/Users/edmondfrank/.docker/bin/kubectl")

(add-to-list 'load-path (expand-file-name "site-lisp/yasnippet" user-emacs-directory))
(require 'yasnippet)
(yas-global-mode 1)

(when (maybe-require-package 'daemons)
  (require 'daemons nil t))

;; Upstream starts `uptimes' from `after-init-hook'; this fork has always left
;; it off (unused mode-line widget).  Dropping the hook entry is cheaper than
;; editing upstream's init.el.
(setq after-init-hook
      (seq-remove (lambda (fn)
                    (and (consp fn)
                         (string-match-p "\\buptimes\\b" (format "%S" fn))))
                  after-init-hook))

;;--- packages with nothing to configure ---------------------------------
(require-package 'auto-complete)
(require-package 'vterm)

(add-hook 'vterm-mode-hook
          (lambda ()
            (local-set-key (kbd "<C-\\>") 'toggle-input-method)
            (local-set-key (kbd "<C-left>") 'windmove-left)
            (local-set-key (kbd "<C-right>") 'windmove-right)
            (local-set-key (kbd "<C-up>") 'windmove-up)
            (local-set-key (kbd "<C-down>") 'windmove-down)))

;;--- global defaults ----------------------------------------------------
(setq lsp-java-jdt-download-url
      "https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz")

(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

(setq selection-coding-system 'utf-8)
(when (display-graphic-p)
  (ignore-errors (gui-get-selection 'utf-8)))

(setq recentf-max-menu-items 250)
(setq org-startup-folded t)
(setq ivy-rich-parse-remote-buffer nil)
(setq vc-handled-backends '(Git))
(setq csv-separators '("," "\t"))

(put 'scroll-left 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(provide 'my-misc)
;;; my-misc.el ends here