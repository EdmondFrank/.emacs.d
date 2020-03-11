;;; init-tags.el --- customize etags/ctags settings -*- lexical-binding: t -*-
;; Don't ask before rereading the TAGS files if they have changed
;;; Commentary:
;;; Code:
;; 自定义tags加载
(setq tags-revert-without-query t)
;; Don't warn when TAGS files are large
(setq large-file-warning-threshold nil)
;; Setup auto update now
(add-hook 'prog-mode-hook
          (lambda ()
            (add-hook 'after-save-hook
                      'counsel-etags-virtual-update-tags 'append 'local)))
(add-hook 'after-save-hook 'counsel-etags-virtual-update-tags)
(provide 'init-tags)
;;; init-tags.el ends here
