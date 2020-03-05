;;; init-sort.el --- Use custom ivy sort mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'ivy-prescient)
  (add-hook 'after-init-hook 'ivy-prescient-mode))

(provide 'init-sort)
;;; init-sort.el ends here
