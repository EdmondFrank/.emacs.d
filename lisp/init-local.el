;;; init-local.el --- The fork layer: everything upstream does not own -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream init.el ends with `(require 'init-local nil t)', so this file is the
;; single entry point for this fork's own configuration.
;;
;; Layout (see FORK.org):
;;
;;   lisp/local/my-<module>.el   either a module upstream does not have, or an
;;                               adjustment to upstream's lisp/init-<module>.el
;;   lisp/init-local.el          this file
;;   lisp/init-preload-local.el  settings needed before the module list loads
;;
;; Rules that keep `git merge upstream/main' conflict-free:
;;   1. never edit an upstream-owned file (init.el, early-init.el, lisp/init-*.el);
;;   2. our files all start with `my-' and live in lisp/local/, so `require' can
;;      never resolve to one of ours where upstream expects its own;
;;   3. override upstream behaviour with setq/advice/remove-hook from here,
;;      loaded after everything upstream, instead of editing their file.

;;; Code:

(add-to-list 'load-path
             (expand-file-name "local"
                               (file-name-directory (or load-file-name buffer-file-name))))

;;; Minibuffer: ivy/counsel/smex instead of upstream's vertico stack
;; (init-minibuffer is suppressed in init-preload-local.el)
(require 'my-smex)
(require 'my-ivy)
(require 'my-sort)

;;; Modules the fork adds to the module list
(require 'my-trello)
(require 'my-elixir)
(require 'my-go)
(require 'my-remote)
(require 'my-tramp-rpc)

;;; Adjustments to upstream modules, named after the file they adjust
(require 'my-clojure)
(require 'my-corfu)
(require 'my-dash)
(require 'my-dired)
(require 'my-editing-utils)
(require 'my-eglot)
(require 'my-flymake)
(require 'my-git)
(require 'my-github)
(require 'my-gui-frames)
(require 'my-mmm)
(require 'my-org)
(require 'my-osx-keys)
(require 'my-ruby)
(require 'my-sessions)
(require 'my-utils)
(require 'my-windows)

;;; Personal tail (order preserved from the pre-refactor init.el)
(require 'my-input)
(require 'my-doom-themes)
(require 'my-dumb-jump)
(require 'my-leetcode)
(require 'my-undo-tree)
(require 'my-noter)
(require 'my-blink-search)
(require 'my-keybindings)
(require 'my-functions)
(require 'my-citre)
(require 'my-aider)
(require 'my-exhub)
(require 'my-exhub-lsp)
(require 'my-agent)
(require 'my-appine)

;;; Last: knobs that must win over everything loaded above
(require 'my-misc)

(provide 'init-local)
;;; init-local.el ends here