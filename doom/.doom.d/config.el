;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Email - use offlineimap to sync emails
(setq +email-backend 'offlineimap)

;; Mail
;; Allow msmtp to use from as the account
(setq message-sendmail-f-is-evil 't)
(setq message-sendmail-extra-arguments '("--read-envelope-from"))

;; Deft
(setq deft-directory "~/Dropbox/org")

;; org-agenda
(setq org-agenda-include-diary t)
;; Setup agenda files
(setq org-agenda-files '("~/Dropbox/org"))

;; org-capture
(setq org-default-notes-file "~/Dropbox/org/notes.org")

;; Theme
(setq doom-theme 'doom-molokai)
(setq doom-font (font-spec :family "Knack Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "Knack Nerd Font")
      doom-big-font (font-spec :family "Knack Nerd Font" :size 19))
