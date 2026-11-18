;;; my-clojure.el --- Adjustments to upstream init-clojure -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream prefers clojure-ts-mode and only falls back to clojure-mode.  This
;; fork runs cider against clojure-mode, so clojure-mode is made the mode for
;; .clj/.cljs/.cljc/.edn again.  (clojure-mode prepends its own
;; `auto-mode-alist' entries when it loads, so they win over clojure-ts-mode's.)

;;; Code:

(with-eval-after-load 'init-clojure
  (require-package 'clojure-mode)
  (add-hook 'clojure-mode-hook 'sanityinc/lisp-setup)
  (when (featurep 'clojure-ts-mode)
    (setq auto-mode-alist (rassq-delete-all 'clojure-ts-mode auto-mode-alist))))

(provide 'my-clojure)
;;; my-clojure.el ends here