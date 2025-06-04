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

(defun gitee-upload-image-from-clipboard ()
  "Invoke `gitee_cli attach_files upload -c` and insert the result as markdown image format in current buffer if command exit status is 0, otherwise show message with fail and ask user to retry."
  (interactive)
  (let ((result (shell-command-to-string "gitee_cli attach_files upload -c")))
    (if (string-match-p "^http.*\\.png$" result)
        (insert (concat "![image](" result ")"))
      (message "fail to upload image, please retry ~"))))

;; (define-key markdown-mode-map (kbd "C-c C-v") 'gitee-upload-image-from-clipboard)

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

(defun org-copy-link-text ()
  "Copy the text part of an org-mode link at point."
  (interactive)
  (let ((link (org-element-context)))
    (if (not (eq (car link) 'link))
        (error "Not on a link")
      (let ((link-text (buffer-substring
                        (org-element-property :contents-begin link)
                        (org-element-property :contents-end link))))
        (if link-text
            (kill-new link-text)
          (error "Could not extract link text"))
        (message "Copied link text: %s" (car kill-ring))))))

(define-key org-mode-map (kbd "C-x C-l") 'org-copy-link-url)
(define-key org-mode-map (kbd "C-x C-k") 'org-copy-link-text)

(defun pandora ()
  "Start a vterm terminal, run the pandora COMMAND, and rename the buffer to 'pandora'."
  (interactive)
  (let ((buffer (generate-new-buffer "*vterm*")))
    (with-current-buffer buffer
      (vterm-mode)
      (vterm-send-string "pandora -p http://127.0.0.1:1081")
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

(defun insert-current-date ()
  "Insert the current date in Markdown format."
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun show-buffer-modes ()
  "Display the major and minor modes of the current buffer."
  (interactive)
  (message "Major mode: %s" major-mode)
  (message "Minor modes: %s" minor-mode-list))

(defun open-dir-in-system ()
  "Open the current directory or the parent directory of the current file in the system's file manager."
  (interactive)
  (let ((directory
         (if (buffer-file-name)
             (file-name-directory (buffer-file-name))
           (dired-current-directory))))
    (cond
     ((eq system-type 'darwin)
      (call-process "open" nil nil nil directory))
     ((eq system-type 'windows-nt)
      (call-process "explorer" nil nil nil directory))
     ((eq system-type 'gnu/linux)
      (if (file-executable-p "/usr/bin/xdg-open")
          (call-process "/usr/bin/xdg-open" nil nil nil directory)
        (if (file-executable-p "/usr/bin/nautilus")
            (call-process "/usr/bin/nautilus" nil nil nil directory)
          (if (file-executable-p "/usr/bin/thunar")
              (call-process "/usr/bin/thunar" nil nil nil directory)
            (message "No supported file manager found")))))
     (t (message "Unsupported operating system")))))

(provide 'init-functions)
;;; init-functions.el ends here
