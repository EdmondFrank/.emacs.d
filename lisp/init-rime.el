;;; init-rime.el --- Use Rime as default input method -*- lexical-binding: t -*-
;;; Commentary:

(add-to-list 'load-path (expand-file-name "site-lisp/emacs-rime" user-emacs-directory))
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

(provide 'init-rime)
;;; init-rime.el ends here
