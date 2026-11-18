;;; my-editing-utils.el --- Adjustments to upstream init-editing-utils -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream lisp/init-editing-utils.el loads unchanged; the fork's edits to it
;; live here and are applied after it has run.

;;; Code:

;; Keep huge minified/JSON/TS files responsive: no bidi reordering, no
;; paragraph-direction lookahead, and Emacs 29's long-line shortcuts.
(setq-default bidi-display-reordering nil)
(setq bidi-inhibit-bpa t
      long-line-threshold 1000
      large-hscroll-threshold 1000
      syntax-wholeline-max 1000)

;; Upstream leaves the fill-column indicator at 80.
(when (boundp 'display-fill-column-indicator)
  (setq-default display-fill-column-indicator-column 120))

(with-eval-after-load 'init-editing-utils
  ;; Upstream gives C-- to `expreg-contract'; C-- stays `negative-argument'.
  (global-set-key (kbd "C--") 'negative-argument))

(provide 'my-editing-utils)
;;; my-editing-utils.el ends here