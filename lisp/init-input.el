;;; init-input.el --- Use smart input method -*- lexical-binding: t -*-
;;; Commentary:

(if (eq system-type 'darwin)
    ;; macOS specific settings
    (progn
      (require 'sis)
      (sis-ism-lazyman-config
       "com.apple.keylayout.ABC"
       "com.apple.inputmethod.SCIM.ITABC")
      (sis-global-respect-mode))
  (when (eq system-type 'gnu/linux)
    ;; Linux specific settings
    (add-to-list 'load-path (expand-file-name "site-lisp/emacs-rime" user-emacs-directory))
    (require 'rime)
    (setq rime-user-data-dir "~/.config/fcitx/rime")
    (setq rime-posframe-properties
          (list :background-color "#333333"
                :foreground-color "#dcdccc"
                :font "WenQuanYi Micro Hei Mono-14"
                :internal-border-width 10))
    (setq default-input-method "rime"
          rime-show-candidate 'posframe)))

(provide 'init-input)
;;; init-input.el ends here
