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
  (setq agent-shell-tool-use-expand-by-default nil)
  (setq agent-shell-session-restore-verbosity 'full)
  (setq agent-shell-thought-process-expand-by-default t)
  (setq agent-shell-context-sources '(files region error))
  (setq agent-shell-aiderdesk-environment
        (agent-shell-make-environment-variables "AIDER_DESK_SSE_TIMEOUT_MS" "3600000"))
  )

;;; Auto code suggestions in the agent-shell prompt (exhub-fim)
;;
;; `init-agent.el' is loaded before `init-exhub.el', which is what requires
;; `exhub-fim', so the whole block waits for that feature to be present.
;; Agent-shell buffers are comint transcripts, so suggestions are restricted
;; to the live input prompt by `agent-shell-exhub-fim-block-p'.

(with-eval-after-load 'exhub-fim
  (defun agent-shell-exhub-fim-block-p ()
    "Return non-nil when exhub-fim should not suggest anything.
Only the live prompt awaiting input is worth completing, and never while
the agent is streaming a response."
    (not (and (fboundp 'shell-maker-point-at-last-prompt-p)
              (shell-maker-point-at-last-prompt-p)
              (or (not (fboundp 'shell-maker-busy))
                  (not (shell-maker-busy))))))

  (defun agent-shell-exhub-fim-enable ()
    "Enable automatic exhub-fim suggestions in agent-shell buffers.
`exhub-fim-auto-suggestion-block-functions' is made buffer-local so the
prompt guard only applies here and keeps the global defaults."
    (setq-local exhub-fim-auto-suggestion-block-functions
                (cons #'agent-shell-exhub-fim-block-p
                      (default-value
                        'exhub-fim-auto-suggestion-block-functions)))
    (exhub-fim-auto-suggestion-mode 1))

  (add-hook 'agent-shell-mode-hook #'agent-shell-exhub-fim-enable)

  ;; In agent-shell `C-b' is `backward-char' and TAB jumps to the next item,
  ;; so the suggestion commands live under the free `C-c f' prefix.
  (with-eval-after-load 'agent-shell
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "TAB") #'exhub-fim-accept-suggestion)
      (define-key map (kbd "n") #'exhub-fim-next-suggestion)
      (define-key map (kbd "p") #'exhub-fim-previous-suggestion)
      (define-key map (kbd "m") #'exhub-fim-complete-with-minibuffer)
      (define-key map (kbd "d") #'exhub-fim-dismiss-suggestion)
      (define-key agent-shell-mode-map (kbd "C-c f") map))))

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
    ("m" "Switch Model" agent-shell-set-session-model)
    ("M" "Switch Mode" agent-shell-set-session-mode)
    ("c" "Cycle Mode" agent-shell-cycle-session-mode)
    ("p" "Switch Agent Profile" agent-shell-aiderdesk-set-agent-profile)
    ("a" "Autonomy Mode" agent-shell-aiderdesk-set-autonomy-mode)]
   ["Send Content"
    ("f" "Send File (C-u: choose)" agent-shell-send-file)
    ("r" "Send Region" agent-shell-send-region)]
   ["History"
    ("h" "Input History (M-<up>/<down> cycles)" agent-shell-aiderdesk-input-history)]
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
