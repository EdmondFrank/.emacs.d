;;; init-remote.el --- remote file and session management -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package tramp
  :defer t
  :custom
  (tramp-default-method "ssh")
  (tramp-auto-save-directory "~/tmp/tramp/")
  (tramp-chunksize 1024)
  (remote-file-name-inhibit-cache nil)
  (remote-file-name-inhibit-locks t)
  (tramp-use-scp-direct-remote-copying t)
  (remote-file-name-inhibit-auto-save-visited t)
  (tramp-copy-size-limit (* 1024 1024))
  (tramp-verbose 2))

(provide 'init-remote)
;;; init-remote.el ends here
