;;; init-undo-tree.el --- undo tree mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'undo-tree)
;; Global settings (defaults)
(global-undo-tree-mode 1)
(defalias 'redo 'undo-tree-redo)
(provide 'init-undo-tree)
;;; init-undo-tree.el ends here
