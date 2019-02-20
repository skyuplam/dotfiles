;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! treemacs-icons-dired
  :recipe
  (:fetcher github :repo "Alexander-Miller/treemacs" :files ("src/extra/treemacs-icons-dired.el")))

(package! treemacs-magit
  :recipe
  (:fetcher github :repo "Alexander-Miller/treemacs" :files ("src/extra/treemacs-magit.el")))

(package! elfeed-goodies)
