;;; my-dired.el --- Adjustments to upstream init-dired -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package dired-rsync
  :bind (:map dired-mode-map
              ("C-c C-r" . dired-rsync)))

(use-package dired-rsync-transient
  :bind (:map dired-mode-map
              ("C-c C-x" . dired-rsync-transient)))

(provide 'my-dired)
;;; my-dired.el ends here