;;; my-ruby.el --- Adjustments to upstream init-ruby -*- lexical-binding: t -*-

;;; Commentary:

;; The fork drives rubies through eglot and activates the matching rvm gemset
;; before opening a console.

;;; Code:

(require-package 'eglot)

(with-eval-after-load 'inf-ruby
  (advice-add 'inf-ruby-console-auto :before #'rvm-activate-corresponding-ruby))

(provide 'my-ruby)
;;; my-ruby.el ends here