;;; init-rime.el --- Use Rime as default input method -*- lexical-binding: t -*-
;;; Commentary:

(add-to-list 'load-path (expand-file-name "site-lisp/emacs-rime" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp/key-echo" user-emacs-directory))

(require 'rime)

;;; Code:
(setq rime-user-data-dir "~/.config/fcitx/rime")

(setq rime-posframe-properties
      (list :background-color "#333333"
            :foreground-color "#dcdccc"
            :font "WenQuanYi Micro Hei Mono-14"
            :internal-border-width 10))

(setq default-input-method "rime"
      rime-show-candidate 'posframe)

(require 'key-echo)
(key-echo-enable)

(defun key-echo-shift-to-switch-input-method (key)
  (interactive)
  (when (string-equal key "Key.shift")
    (toggle-input-method)))

(setq key-echo-single-key-trigger-func 'key-echo-shift-to-switch-input-method)

(provide 'init-rime)
;;; init-rime.el ends here
