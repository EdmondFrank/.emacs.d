;;; my-go.el --- Go tooling on top of upstream init-go -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream opens .go files in go-ts-mode.  This fork drives gopls through
;; eglot from go-mode, so it re-points the major mode and keeps the rest of
;; upstream's Go setup (the go-format reformatter, go.mod project roots).
;;
;; To follow upstream instead, delete the `auto-mode-alist' pin at the bottom
;; and hang these hooks off `go-ts-mode-hook'.

;;; Code:

(require-package 'company)
(require-package 'go-mode)
(require-package 'eglot)

(require 'project)

(defun my/project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'my/project-find-go-module)

;; Format before eglot's willSave notification, so it reports the contents that
;; will actually be saved.
(defun my/eglot-format-buffer-on-save-1 ()
  (when (eglot-current-server)
    (eglot-format-buffer)))

(defun my/eglot-format-buffer-on-save ()
  (add-hook 'before-save-hook #'my/eglot-format-buffer-on-save-1 -10 t))

(add-hook 'go-mode-hook #'my/eglot-format-buffer-on-save)

(setq-default eglot-workspace-configuration
              '((:gopls .
                        ((staticcheck . t)
                         (matcher . "CaseSensitive")))))

;; Keep .go in go-mode rather than upstream's go-ts-mode.
(with-eval-after-load 'init-go
  (setq auto-mode-alist (rassq-delete-all 'go-ts-mode auto-mode-alist))
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))

(provide 'my-go)
;;; my-go.el ends here