;;; init-agent.el --- Basic support for Agent-shell -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require 'exhub-translate)

(use-package agent-shell
  ;; `use-package-always-defer' is set globally (see init-package.el), which
  ;; would defer agent-shell forever: the load-path checkout has no autoloads
  ;; and the transient menu below references its commands.  `:demand' forces
  ;; the package to load at startup so those commands are defined.
  :demand t
  :load-path (lambda () (expand-file-name "site-lisp/agent-shell" user-emacs-directory))
  :config
  (require 'transient)
  (require-package 'acp)
  (require-package 'shell-maker)
  (setq agent-shell-show-config-icons nil) ; no icons in agent/menu prompts
  (setq agent-shell-header-style 'text) ; text-only header (skip SVG icon path)
  (setq agent-shell-show-usage-at-turn-end t)
  (setq agent-shell-tool-use-expand-by-default t)
  (setq agent-shell-thought-process-expand-by-default t)
  (setq agent-shell-context-sources '(files region error))
  )

;;;###autoload
(defun agent-shell-kill ()
  "Kill the current agent shell buffer."
  (interactive)
  (unless (derived-mode-p 'agent-shell-mode)
    (user-error "Not in an agent shell buffer"))
  (agent-shell--clean-up)
  (kill-buffer (current-buffer)))

;;;###autoload
(defun projectile-insert-relative-path ()
  "Find a file using projectile and insert its relative path at point.
This function uses projectile's file finding mechanism but instead of
opening the file, it inserts the relative path from the project root at
the current cursor position. Also adds the selected file to the current
agent session."
  (interactive)
  (require 'projectile)
  (let* ((project-root (projectile-project-root))
         (files (projectile-project-files project-root))
         (selected-file (projectile-completing-read "Find file to insert path: " files)))
    (when selected-file
      (let ((relative-path (file-relative-name selected-file project-root)))
        (insert relative-path)
        (message "Inserted relative path: %s" relative-path)))))

;;;###autoload
(defun projectile-copy-relative-path ()
  "Find a file using projectile and copy its relative path to clipboard.
This function uses projectile's file finding mechanism but instead of
opening the file, it copies the relative path from the project root to
the kill ring."
  (interactive)
  (require 'projectile)
  (let* ((project-root (projectile-project-root))
         (files (projectile-project-files project-root))
         (selected-file (projectile-completing-read "Find file to copy path: " files)))
    (when selected-file
      (let ((relative-path (file-relative-name selected-file project-root)))
        (kill-new relative-path)
        (message "Copied relative path: %s" relative-path)))))



(defun agent-shell-fix-grammar ()
  "Fix grammar and spelling errors in the current agent-shell prompt input.

Replaces the unsubmitted input at the active shell prompt (or the region
in the shell buffer if one is active) with the LLM-corrected version via
the exhub-translate fix-grammar action."
  (interactive)
  (let* ((shell-buffer (or (agent-shell--current-shell)
                           (user-error "Not in an agent shell buffer")))
         (input (with-current-buffer shell-buffer (agent-shell--input))))
    (if (null input)
        (message "Nothing input, cancel grammar fix.")
      (with-current-buffer shell-buffer
        (let ((start (or (marker-position comint-accum-marker)
                         (process-mark (get-buffer-process (current-buffer)))))
              (end (point-max)))
          (kill-region start end)
          (goto-char start)
          (exhub-translate-query-translation-with-action
           input "origin" "EN" "fix-grammar"))))))


;;;###autoload
(defun agent-shell-posframe-translate-region-zh ()
  "Translate the region to Chinese and show the result in a posframe."
  (interactive)
  (exhub-translate-posframe "ZH"))


;;;###autoload
(transient-define-prefix agent-shell-transient-menu ()
  "Transient menu for Agent Shell commands."
  ["Agent Shell"
   ["Shell Control"
    ("s" "Start Agent Shell" agent-shell)
    ("k" "Kill Agent Shell" agent-shell-kill)
    ("m" "Switch Model" agent-shell-set-session-model)]
   ["Send Content"
    ("f" "Send File (C-u: choose)" agent-shell-send-file)
    ("r" "Send Region" agent-shell-send-region)]
   ["Exhub"
    ("i" "Fix Grammar" agent-shell-fix-grammar)
    ("p" "Translate Region to Chinese (Posframe)" agent-shell-posframe-translate-region-zh)]
   [
    "Context Manage"
    ("!" "Shell command" agent-shell-insert-shell-command-output)
    ("y" "Copy Relative Path" projectile-copy-relative-path)
    ("@" "Insert Relative Path" projectile-insert-relative-path)
    ]])

(global-set-key (kbd "M-q") 'agent-shell-transient-menu)

(provide 'init-agent)
;;; init-agent.el ends here
