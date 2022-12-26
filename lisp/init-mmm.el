;;; init-mmm.el --- Multiple Major Modes support -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'buffers-with-submode-classes)
(setq mmm-submode-decoration-level 2)
(defun html-after-syntax-propertize (overlay _mode beg end)
  (when overlay
    (with-silent-modifications
      (funcall
       (syntax-propertize-rules ("<\\|>" (0 ".")))
       beg end))))

(add-hook 'mmm-after-syntax-propertize-functions #'html-after-syntax-propertize nil t)

(provide 'init-mmm)
;;; init-mmm.el ends here
