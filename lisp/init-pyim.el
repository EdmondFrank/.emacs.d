;;; init-pyim.el --- Use Pyim as default input method -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'pyim)
(require-package 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置

(after-load 'pyim
  (pyim-basedict-enable))   ; 拼音词库，五笔用户 *不需要* 此行设置
(setq default-input-method "pyim")
(provide 'init-pyim)
;;; init-pyim.el ends here
