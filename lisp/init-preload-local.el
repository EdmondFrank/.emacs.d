;;; init-preload-local.el --- Fork settings that must run before the module list -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream init.el loads this file right after init-elpa/init-exec-path and
;; before any language module, so it is the place for settings that later
;; modules depend on.
;;
;; The one rule of this configuration (see FORK.org): no file owned by
;; purcell/emacs.d is edited.  Everything here and in lisp/local/ is ours.

;;; Code:

(add-to-list 'load-path
             (expand-file-name "local"
                               (file-name-directory (or load-file-name buffer-file-name))))

;; This fork completes in the minibuffer with ivy/counsel (see my-ivy.el), not
;; with vertico/embark/consult.  Marking the feature as provided turns
;; upstream init.el's `(require 'init-minibuffer)' into a no-op without
;; touching that file.  Delete this line to get upstream's stack back.
(provide 'init-minibuffer)

;; Package archives (mirrors) and use-package must be in place before the
;; module list below starts calling `require-package'.
(require 'my-package)

;; GUI Emacs.app does not inherit a login shell's environment: pull an explicit
;; allow-list of secrets from the envless vault before anything reads a key.
(require 'my-envless)

;; A stable emacsclient socket: the default lives under the GUI session's
;; $TMPDIR, which SSH sessions cannot reach.
(setq server-auth-dir (expand-file-name "server/" user-emacs-directory)
      server-socket-dir (expand-file-name "server/" user-emacs-directory))

;; The mirrored archives ship tarballs this setup has always installed without
;; signature checks (upstream's CI sets the same value); keeping the behaviour
;; explicit rather than silently relaxing it elsewhere.
(setq package-check-signature nil)

(provide 'init-preload-local)
;;; init-preload-local.el ends here