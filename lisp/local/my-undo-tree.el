;;; my-undo-tree.el --- undo tree mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'undo-tree)
;; Global settings (defaults)
(global-undo-tree-mode 1)
(defalias 'redo 'undo-tree-redo)

;; Prevent undo tree files from polluting your git repo
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
(provide 'my-undo-tree)
;;; my-undo-tree.el ends here
