;;; init-reader.el --- documents readers -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require-package 'nov)
(require-package 'proxy-mode)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(add-to-list 'load-path (expand-file-name "site-lisp/go-translate" user-emacs-directory))
(require 'go-translate)

(add-to-list 'load-path (expand-file-name "site-lisp/sdcv" user-emacs-directory))
(require 'sdcv)

(setq gts-translate-list '(("en" "zh") ("zh" "en")))
(setq gts-default-translator
      (gts-translator
       :picker (gts-prompt-picker)
       :engines (list (gts-google-engine) (gts-google-rpc-engine))
       :render (gts-buffer-render)))

;; (setq sdcv-say-word-p t)               ;say word after translation

;; (setq sdcv-dictionary-data-dir "/usr/share/startdict/dic") ;setup directory of stardict dictionary

(setq sdcv-only-data-dir nil)

(setq sdcv-dictionary-simple-list ;setup dictionary list for simple search
      '("懒虫简明英汉词典"
        "懒虫简明汉英词典"
        "朗道英汉字典5.0"
        "朗道汉英字典5.0"
        "KDic11万英汉词典"))

(setq sdcv-dictionary-complete-list     ;setup dictionary list for complete search
      '("quick_eng-zh_CN"
        "新世纪英汉科技大词典"
        "简明英汉词典"
        "stardict1.3英汉辞典"
        "朗道英汉字典5.0"
        "朗道汉英字典5.0"
        "懒虫简明英汉词典"
        "懒虫简明汉英词典"
        "KDic11万英汉词典"))

(use-package calibredb
  :defer t
  :config
  (setq calibredb-root-dir "~/Documents/CalibreLibrary")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist '(("~/Documents/CalibreLibrary"))))
(require-package 'pdf-tools)
(provide 'init-reader)
;;; init-reader.el ends here
