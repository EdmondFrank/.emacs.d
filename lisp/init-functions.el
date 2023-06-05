;;; init-functions.el --- customize functions -*- lexical-binding: t -*-
;;; Commentary:
(require 'org-element)

;;; Code:
;; 优化卡顿
(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))

;; Set garbage collection threshold to 1GB.
(setq gc-cons-threshold #x40000000)

;; When idle for 15sec run the GC no matter what.
(defvar k-gc-timer
  (run-with-idle-timer 15 t
                       (lambda ()
                         (message "Garbage Collector has run for %.06fsec"
                                  (k-time (garbage-collect))))))
(defun put-file-name-on-clipboard ()
  "Put the current file name on the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))
(defun copy-diff-region ()
  "Copy diff region without + or - markers."
  (interactive)
  (deactivate-mark)
  (let ((text (buffer-substring-no-properties
               (region-beginning) (region-end))))
    (kill-new (replace-regexp-in-string "^[\\+\\-]" "" text))))

(require 'ansi-color)
(defun display-ansi-colors ()
  "Display ansi color characters."
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

(defun load-org-babel-executor ()
  "Org babel load languages runtime."
  (interactive)
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((shell . t))))
(defun org-copy-link-url ()
  "Extract URL from `org-mode link and add it to kill ring."
  (interactive)
  (kill-new (org-element-property :raw-link (org-element-context)))
  (message "Copied Successfully !"))

(define-key org-mode-map (kbd "C-x C-l") 'org-copy-link-url)

(defun pandora ()
  "Start a vterm terminal, run the pandora COMMAND, and rename the buffer to 'pandora'."
  (interactive)
  (let ((buffer (generate-new-buffer "*vterm*")))
    (with-current-buffer buffer
      (vterm-mode)
      (vterm-send-string "pandora")
      (vterm-send-return))
    (switch-to-buffer buffer)
    (rename-buffer "pandora" t)))

(defun enlarge-frame-horizontally ()
  "Enlarges the Emacs frame horizontally by 5 columns."
  (interactive)
  (set-frame-size (selected-frame) (+ (frame-width) 5) (frame-height)))

(defun shrink-frame-horizontally ()
  "Shrinks the Emacs frame horizontally by 5 columns."
  (interactive)
  (set-frame-size (selected-frame) (- (frame-width) 5) (frame-height)))

(defun enlarge-frame-vertically ()
  "Enlarges the Emacs frame vertically by 5 rows."
  (interactive)
  (set-frame-size (selected-frame) (frame-width) (+ (frame-height) 5)))

(defun shrink-frame-vertically ()
  "Shrinks the Emacs frame vertically by 5 rows."
  (interactive)
  (set-frame-size (selected-frame) (frame-width) (- (frame-height) 5)))

(provide 'init-functions)
;;; init-functions.el ends here
