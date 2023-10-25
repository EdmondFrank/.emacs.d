;;; init-doom-themes.el --- Customize doom themes -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;;custom theme
(require-package 'doom-themes)

;; Global settings (defaults)
(after-load 'doom-themes
(setq doom-themes-enable-bold t ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-dracula t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config))

(provide 'init-doom-themes)
;;; init-doom-themes.el ends here
