;;; config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Email - use offlineimap to sync emails
(setq +email-backend 'offlineimap)

;; Mail
;; Allow msmtp to use from as the account
(setq message-sendmail-f-is-evil 't)
(setq message-sendmail-extra-arguments '("--read-envelope-from"))

;; Deft
(after! deft
    (setq deft-directory "~/Dropbox/org"))

;; org-mode
(setq org-directory "~/Dropbox/org"
      org-modules '(
                    org-w3m
                    org-bbdb
                    ;; org-bibtex
                    org-docview
                    ;; org-gnus
                    org-info
                    ;; org-irc
                    ;; org-mhe
                    ;; org-rmail
                    ))
;; org-agenda
(setq org-agenda-include-diary t)
;; org-agenda files
(setq org-agenda-files '("~/Dropbox/org"))
;; org-capture
(setq org-default-notes-file "~/Dropbox/org/notes.org")

;; elfeed
(setq +rss-elfeed-files (list "feeds/elfeed.org"))
(after! elfeed
  (setq elfeed-search-filter "@2-days-ago +unread"
        elfeed-db-directory "~/Dropbox/org/feeds/db/"
        elfeed-enclosure-default-dir "~/Dropbox/org/feeds/enclosures/"))
;; elfeed-goodies
(def-package! elfeed-goodies
  :when (featurep! :app elfeed)
  :after elfeed
  :config
  (elfeed-goodies/setup))

;; notmuch
(setq +notmuch-sync-backend 'offlineimap
    +notmuch-mail-folder "~/mail")

;; treemacs
(def-package! treemacs-icons-dired
  :when (featurep! :emacs dired)
  :after treemacs dired
  :config (treemacs-icons-dired-mode))

(def-package! treemacs-magit
  :after treemacs magit)
(after! treemacs
  (setq treemacs-no-png-images t))

;; Company
(after! company
  (setq company-idle-delay 0.5))

;; Theme
(setq doom-theme 'doom-vibrant)
(setq doom-font (font-spec :family "Knack Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "Knack Nerd Font")
      doom-big-font (font-spec :family "Knack Nerd Font" :size 19))

;; (doom-themes-treemacs-config)
;; (doom-themes-org-config)

;; Keybindings

(when (featurep! :feature evil +everywhere)
  (map! :n "M-k" #'evil-move-up
        :n "M-j" #'evil-move-down
        :n "M-h" #'evil-move-left
        :n "M-l" #'evil-move-right
        ))


;; evil-collection Keybindings
(def-package! evil-collection
  :when (featurep! :feature evil +everywhere)
  :config
  (evil-collection-init))
