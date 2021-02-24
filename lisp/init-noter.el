;;; init-noter.el --- emacs notes recorder and manager -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'org-noter)
(require-package 'deft)
(require-package 'org-brain)
(require-package 'org-mind-map)
(setq org-brain-path "~/backup")
(setq deft-recursive t)
;; Global settings (defaults)
(setq org-id-track-globally t)
(setq org-id-locations-file "~/.deft/.org-id-locations")
(push '("b" "Brain" plain (function org-brain-goto-end)
        "* %i%?" :empty-lines 1)
      org-capture-templates)
(setq org-brain-visualize-default-choices 'all)
(setq org-brain-title-max-length 12)
(setq org-brain-include-file-entries nil
      org-brain-file-entries-use-title nil)
(setq deft-extensions '("txt" "org" "md" "tex"))
(setq deft-directory org-brain-path)
(defun org-brain-deft ()
  "Use `deft' for files in `org-brain-path'."
  (interactive)
  (let ((deft-directory org-brain-path)
        (deft-recursive t)
        (deft-extensions '("org")))
    (deft)))
(require 'ox-org)
:ensure t
(setq org-mind-map-engine "dot")       ; Default. Directed Graph
(setq org-mind-map-include-text t)
(provide 'init-noter)
;;; init-noter.el ends here
