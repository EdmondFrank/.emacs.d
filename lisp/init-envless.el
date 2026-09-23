;;; init-envless.el --- Import selected secrets from the envless vault -*- lexical-binding: t -*-
;;; Commentary:

;; envless (https://biliboss.github.io/envless) keeps secrets in a
;; sops/age-encrypted vault at `my/envless-root' - here the shared ~/GTD
;; vault.  GUI Emacs.app does not inherit a login shell's environment, so
;; pull a small, explicit allow-list of secrets into `process-environment'
;; at startup.
;;
;; `envless exec' injects secrets into a child process's environment; they
;; are never passed via argv, disk or stdout.  We keep that contract: values
;; travel only from a child's stdout into a temporary buffer here, then into
;; `process-environment', from where child processes inherit them normally.
;;
;; Refresh manually with M-x my/envless-import.

;;; Code:

(require 'exec-path-from-shell nil t)

(defgroup my/envless nil
  "Import secrets from the shared envless vault."
  :group 'environment)

(defcustom my/envless-root (expand-file-name "~/GTD")
  "Directory holding the envless vault (`.envless/' plus `secrets/')."
  :type 'directory
  :group 'my/envless)

(defcustom my/envless-env "dev"
  "envless environment to read, i.e. `secrets/<env>.env.enc'."
  :type 'string
  :group 'my/envless)

(defcustom my/envless-variables '("SECRET_VAULT_PASSWORD" "COTP_PASS"
                                "MISTRAL_API_KEY" "CODESTRAL_API_KEY"
                                "GEMINI_API_KEY" "OPENROUTER_API_KEY")
  "Secrets to import from the envless vault into `process-environment'.

Keep this list small: every process Emacs spawns inherits these values."
  :type '(repeat string)
  :group 'my/envless)

(defconst my/envless--marker "__ENVLESS_MARKER__"
  "Sentinel bracketing the printf output, so shell chatter can be ignored.")

(defun my/envless--setenv (name value)
  "Set environment variable NAME to VALUE.
Routes through `exec-path-from-shell-setenv' when available, so that
`exec-path' and `eshell-path-env' stay consistent."
  (if (fboundp 'exec-path-from-shell-setenv)
      (exec-path-from-shell-setenv name value)
    (setenv name value)))

(defun my/envless--read-values (names)
  "Return the values of the envless secrets NAMES, in the same order.
Spawns `envless exec' against `my/envless-root' and reads the values out
of the child's environment.  Signals an error if the vault is unreachable."
  (let* ((printf-bin (or (executable-find "printf") "printf"))
         ;; printf applies one %s per argument; NUL separators keep values
         ;; containing newlines intact.
         (format-string (concat my/envless--marker "\\0"
                                (mapconcat (lambda (_) "%s\\0") names "")
                                my/envless--marker))
         (script (concat (shell-quote-argument printf-bin)
                         " '" format-string "' "
                         (mapconcat (lambda (name) (format "\"$%s\"" name))
                                    names " "))))
    (with-temp-buffer
      (set-buffer-multibyte nil)
      (let ((coding-system-for-read 'binary)
            (process-environment
             (cons (concat "ENVLESS_ROOT=" my/envless-root)
                   process-environment)))
        (unless (zerop (call-process "envless" nil t nil
                                     "exec" (concat "--env=" my/envless-env)
                                     "--" "sh" "-c" script))
          (error "envless exec failed (env %s, root %s)"
                 my/envless-env my/envless-root)))
      (goto-char (point-min))
      (unless (re-search-forward
               (concat (regexp-quote my/envless--marker)
                       "\0\\(.*\\)\0"
                       (regexp-quote my/envless--marker))
               nil t)
        (error "envless: could not parse printf output"))
      (split-string (match-string 1) "\0"))))

(defun my/envless-import (&optional names)
  "Import the envless secrets NAMES into `process-environment'.
NAMES defaults to `my/envless-variables'.  Returns the number of secrets
imported; signals an error if any value is missing or empty."
  (interactive)
  (let* ((names (or names my/envless-variables))
         (count (length names))
         (values (my/envless--read-values names)))
    (unless (= (length values) count)
      (error "envless: expected %d values, got %d" count (length values)))
    (while names
      (when (string-empty-p (car values))
        (error "envless: secret %s is missing or empty" (car names)))
      (my/envless--setenv (car names) (car values))
      (setq names (cdr names)
            values (cdr values)))
    count))

;; In the vault and on PATH?  Otherwise stay quiet: a broken vault must not
;; break startup (`debug-on-error' is enabled in init.el).
(when (and (executable-find "envless")
           (file-exists-p (expand-file-name ".envless" my/envless-root)))
  (condition-case err
      (my/envless-import)
    (error (warn "envless: could not import %s: %S"
                 (mapconcat #'identity my/envless-variables " ")
                 err))))

(provide 'init-envless)
;;; init-envless.el ends here