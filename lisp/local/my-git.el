;;; my-git.el --- Adjustments to upstream init-git -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream visits diffs in the worktree by default and has no workaround for
;; magit/magit#5600.  Both are expressed here as an override plus advice.

;;; Code:

(with-eval-after-load 'init-git
  ;; Visiting a hunk should open the working-tree file, not the index blob.
  (setq-default magit-diff-visit-prefer-worktree nil))

;; Fix for magit/magit#5600: when `magit-diff-working-tree' produces a
;; single-revision string spec, `magit-split-range' returns nil and magit opens
;; a bogus FILENAME.~nil~ buffer.  Fall back to treating the spec as old-rev
;; with {worktree} as new-rev.
(defun my/magit-diff-visit--sides-worktree-fix (orig)
  (let ((spec (magit-diff--dwim))
        (result (funcall orig)))
    (if (and (stringp spec)
             (null (caar result)))
        (list (list (magit--abbrev-if-hash spec) (cadar result))
              (list "{worktree}" (cadr (cadr result))))
      result)))

(with-eval-after-load 'magit
  (advice-add 'magit-diff-visit--sides :around
              #'my/magit-diff-visit--sides-worktree-fix))

(provide 'my-git)
;;; my-git.el ends here