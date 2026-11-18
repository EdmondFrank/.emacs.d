;;; my-eglot.el --- Adjustments to upstream init-eglot -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream hooks `sanityinc/disable-eglot-semantic-tokens' unconditionally, but
;; `eglot-semantic-tokens-mode' only exists from Emacs 30 on.  On Emacs 29 that
;; hook signals in every eglot buffer, so the fork replaces it with a guarded
;; version.  (Worth reporting upstream: wrap that defun in `when fboundp'.)

;;; Code:

(defun my/disable-eglot-semantic-tokens ()
  "Turn off semantic tokens where eglot has them."
  (when (fboundp 'eglot-semantic-tokens-mode)
    (eglot-semantic-tokens-mode -1)))

(with-eval-after-load 'init-eglot
  (remove-hook 'eglot-managed-mode-hook #'sanityinc/disable-eglot-semantic-tokens)
  (add-hook 'eglot-managed-mode-hook #'my/disable-eglot-semantic-tokens))

(provide 'my-eglot)
;;; my-eglot.el ends here