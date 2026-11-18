;;; my-osx-keys.el --- Adjustments to upstream init-osx-keys -*- lexical-binding: t -*-

;;; Commentary:

;; Upstream maps Command to Meta and leaves Option dead.  This Mac is also
;; driven from Android over RustDesk, where Command/Meta is unreliable but Alt
;; is forwarded, so Meta is exposed on Option as well.

;;; Code:

(when *is-a-mac*
  (setq mac-option-modifier 'meta))

(provide 'my-osx-keys)
;;; my-osx-keys.el ends here