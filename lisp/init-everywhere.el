;; init-everywhere.el --- Initialize Emacs Everywhere configurations.	-*- lexical-binding: t -*-
;;; Commentary:
;;
;; Emacs Everywhere configuration
;;

;;; Code:

(add-to-list 'load-path (expand-file-name "site-lisp/emacs-everywhere" user-emacs-directory))

(require 'emacs-everywhere)

(defun emacs-everywhere-toggle-input-method ()
  "Toggle default input method."
  (toggle-input-method))

(setq emacs-everywhere-frame-parameters
      `((name . "emacs-everywhere")
        (width . 40)
        (height . 6)))

(setq emacs-everywhere-init-hooks
      '(emacs-everywhere-set-frame-name
        emacs-everywhere-set-frame-position
        emacs-everywhere-apply-major-mode
        emacs-everywhere-remove-trailing-whitespace
        emacs-everywhere-init-spell-check
        emacs-everywhere-toggle-input-method))

(add-hook 'emacs-everywhere-mode-hook
          (lambda ()
            (define-key emacs-everywhere-mode-map (kbd "M-q") 'emacs-everywhere-finish-or-ctrl-c-ctrl-c)))

(provide 'init-everywhere)
;;; init-everywhere.el ends here
