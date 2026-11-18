;;; my-mmm.el --- Adjustments to upstream init-mmm -*- lexical-binding: t -*-

;;; Commentary:

;; Mark HTML tags as punctuation inside mmm submodes so they don't unbalance
;; the parser.  Note: upstream's copy of this hook used `(add-hook ... nil t)',
;; which made it buffer-local to whatever buffer was current during startup
;; (i.e. a no-op); this one is global on purpose.

;;; Code:

(defun my/html-after-syntax-propertize (overlay _mode beg end)
  (when overlay
    (with-silent-modifications
      (funcall
       (syntax-propertize-rules ("<\\|>" (0 ".")))
       beg end))))

(add-hook 'mmm-after-syntax-propertize-functions #'my/html-after-syntax-propertize)

(provide 'my-mmm)
;;; my-mmm.el ends here