;;; init-dumb-jump.el --- Customize Code navigation -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'ripgrep)
(require-package 'dumb-jump)
;; Global settings (defaults)
(after-load 'dumb-jump
  (setq dumb-jump-force-searcher 'rg))
(provide 'init-dumb-jump)
;;; init-dumb-jump.el ends here
