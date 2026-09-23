;;; init-tramp-rpc.el --- Fast RPC-based TRAMP backend -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Sets up emacs-tramp-rpc (https://github.com/ArthurHeymans/emacs-tramp-rpc)
;; from the git checkout in site-lisp/emacs-tramp-rpc.  It registers the "rpc"
;; TRAMP method, e.g. /rpc:user@host:/path/to/file, which talks to a small
;; Rust server over SSH/MessagePack instead of parsing shell output.
;;
;; Upstream declares Emacs 30.1+, but the checkout only really needs GNU ELPA
;; TRAMP >= 2.8.1.4 (which supports Emacs 28.1+) plus msgpack.el; this has been
;; verified to load and register correctly under Emacs 29.4.  The only
;; Emacs-30-only primitive it references, `connection-local-value', is used on
;; macOS in a dead code path; a compat shim is defined below for safety.

(defconst sanityinc/emacs-tramp-rpc-dir
  (expand-file-name "site-lisp/emacs-tramp-rpc/lisp" user-emacs-directory)
  "Directory containing the emacs-tramp-rpc git checkout.")

(cond
 ((not (file-directory-p sanityinc/emacs-tramp-rpc-dir))
  (message "init-tramp-rpc: checkout missing in %s; skipping"
           sanityinc/emacs-tramp-rpc-dir))
 ((version< emacs-version "29.1")
  (message "init-tramp-rpc: needs Emacs 29.1+ (with TRAMP >= 2.8.1.4); skipping"))
 (t
  ;; TRAMP >= 2.8.1.4 provides the tramp-skeleton machinery and connection
  ;; handling tramp-rpc builds on; the GNU ELPA package installs fine on
  ;; Emacs 28+.
  (let ((deps-ok (and (maybe-require-package 'tramp "2.8.1.4")
                      (maybe-require-package 'msgpack))))
    (if (not deps-ok)
        (message "init-tramp-rpc: could not install tramp/msgpack; skipping")
      ;; `connection-local-value' is new in Emacs 30 (tramp-rpc.el uses it
      ;; once, guarded by (unless (fboundp 'system-move-file-to-trash) ...) so
      ;; it is unreachable on macOS).  Emulate it from buffer/default values
      ;; on Emacs 29.
      (unless (fboundp 'connection-local-value)
        (defun connection-local-value (symbol)
          "Emacs 29 compat shim for `connection-local-value' (new in Emacs 30).
Return SYMBOL's connection-local value, approximated by its buffer-local
value if set, else its default value."
          (if (local-variable-p symbol)
              (symbol-value symbol)
            (default-value symbol))))

      (add-to-list 'load-path sanityinc/emacs-tramp-rpc-dir)

      ;; Auto-load the binary deployment commands without pulling in TRAMP at
      ;; startup; tramp-rpc-deploy.el is self-contained.
      (dolist (cmd (list 'tramp-rpc-deploy-install-binary
                         'tramp-rpc-deploy-status
                         'tramp-rpc-deploy-clear-cache
                         'tramp-rpc-deploy-remove-binary))
        (autoload cmd "tramp-rpc-deploy" nil t))

      (with-eval-after-load 'tramp
        (cond
         ((version< tramp-version "2.8.1.4")
          (message "tramp-rpc: needs TRAMP >= 2.8.1.4, but %s is loaded; not registering rpc method"
                   tramp-version))
         ((require 'tramp-rpc nil t)
          ;; Git checkouts default to the `auto' policy, which never
          ;; auto-downloads a server binary (it would prompt via
          ;; tramp-rpc-deploy-install-binary instead).  `release' restores
          ;; release-install behavior: first connection downloads the
          ;; checksum-verified GitHub release binary into
          ;; ~/.emacs.d/tramp-rpc/ and deploys it to the remote
          ;; ~/.cache/emacs/tramp-rpc/ automatically.
          (setq tramp-rpc-deploy-git-build-policy 'build)
          (setq tramp-rpc-deploy-never-deploy-hosts '("^jms-"))
          (message "tramp-rpc: registered rpc method (tramp %s)"
                   tramp-version))))))))

(provide 'init-tramp-rpc)
;;; init-tramp-rpc.el ends here
