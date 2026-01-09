;;; init-agent.el --- Basic support for Agent-shell -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package agent-shell
  :ensure t
  :config
  (require 'transient))

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
the current cursor position."
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
   [
    "Context Manage"
    ("!" "Shell command" agent-shell-insert-shell-command-output)
    ("y" "Copy Relative Path" projectile-copy-relative-path)
    ("@" "Insert Relative Path" projectile-insert-relative-path)
    ]])

(global-set-key (kbd "M-q") 'agent-shell-transient-menu)

(provide 'init-agent)
;;; init-agent.el ends here
