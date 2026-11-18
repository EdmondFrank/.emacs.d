;;; my-clutch.el --- Basic support for Database -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(add-to-list 'load-path (expand-file-name "site-lisp/clutch" user-emacs-directory))

(require 'clutch)
;; (require 'pg)
;; (require 'mysql)

(setq clutch-connect-timeout-seconds 10
      clutch-read-idle-timeout-seconds 30
      clutch-query-timeout-seconds 20
      clutch-jdbc-rpc-timeout-seconds 15)

(setq clutch-connection-alist
      '(("compass-director-prod"  . (:backend mysql
                                              :host "10.0.64.140" :port 3306
                                              :user "root" :password "rootForAllMariadb"
                                              :database "compass_director"
                                              :connect-timeout 5
                                              :read-idle-timeout 60))
        ;; ("dev-pg"     . (:backend pg
        ;;                           :host "127.0.0.1" :port 5432
        ;;                           :user "postgres" :password "test"
        ;;                           :database "mydb"))
        ;; ("prod-pg"    . (:backend pg
        ;;                           :host "pg.internal" :port 5432
        ;;                           :user "app" :database "appdb"
        ;;                           :ssh-host "bastion-prod"))
        ;; ("dev-sqlite" . (:backend sqlite
        ;;                           :database "/path/to/my.db"))
        ))
(provide 'my-clutch)
;;; my-clutch.el ends here
