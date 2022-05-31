;; init-citre.el --- Initialize citre configurations.	-*- lexical-binding: t -*-
;;; Commentary:
;;
;; Citre configurations.
;;

;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/citre" user-emacs-directory))

(require 'citre)
(require 'citre-config)

(add-hook
 'citre-mode-hook
 (lambda ()
   (define-key citre-mode-map (kbd "C-x c j") 'citre-jump)
   (define-key citre-mode-map (kbd "C-x c b") 'citre-jump-back)
   (define-key citre-mode-map (kbd "C-x c p") 'citre-peek)
   (define-key citre-mode-map (kbd "C-x c u") 'citre-update-this-tags-file)))

(setq citre-project-root-function #'projectile-project-root)
(setq citre-default-create-tags-file-location 'global-cache)
(setq citre-use-project-root-when-creating-tags t)
(setq citre-prompt-language-for-ctags-command t)
(setq citre-auto-enable-citre-mode-modes '(prog-mode))

(provide 'init-citre)
;;; init-citre.el ends here
