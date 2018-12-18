;;; packages.el -*- lexical-binding: t -*-


(defconst jsx-packages
      '(
        web-mode
        company
        company-flow
        flycheck
        evil-matchit
        add-node-modules-path
        (flycheck-flow :toggle (configuration-layer/package-usedp 'flycheck))
        smartparens
        ))

(defun jsx/post-init-company ()
  (spacemacs|add-company-hook jsx-mode))

(defun react/post-init-company-tern ()
  (push 'company-tern company-backends-jsx-mode))

(defun jsx/post-init-company-flow ()
  (push 'company-flow company-backends-jsx-mode))

(defun react/post-init-tern ()
  (add-hook 'jsx-mode-hook 'tern-mode)
  (spacemacs//set-tern-key-bindings 'jsx-mode))

(defun jsx/post-init-evil-matchit ()
  (with-eval-after-load 'evil-match
    (plist-put evilmi-plugins 'jsx-mode
               '((evilmi-simple-get-tag evilmi-simple-jump)
                 (evilmi-javascript-get-tag evilmi-javascript-jump)
                 (evilmi-html-get-tag evilmi-html-jump)))))

(defun jsx/post-init-flycheck ()
  (with-eval-after-load 'flycheck
    (dolist (checker '(javascript-jshint json-jsonlint))
      (push checker flycheck-disabled-checkers))
    (flycheck-add-mode 'javascript-eslint 'jsx-mode)
    (setq flycheck-display-errors-delay 0)
    (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t))
    )

  (with-eval-after-load 'flycheck-flow
    (flycheck-add-next-checker 'javascript-eslint 'javascript-flow)
    (flycheck-add-mode 'javascript-flow 'jsx-mode)
    )

  (spacemacs/add-flycheck-hook 'jsx-mode)
  )

(defun jsx/init-flycheck-flow ()
  (use-package flycheck-flow))

(defun jsx/init-add-node-modules-path ()
  (use-package add-node-modules-path
    :defer t
    :init
    (progn
      (add-hook 'jsx-mode-hook #'add-node-modules-path)))
    )

(defun jsx/post-init-smartparens ()
  (if dotspacemacs-smartparens-strict-mode
      (add-hook 'jsx-mode-hook #'smartparens-strict-mode)
    (add-hook 'jsx-mode-hook #'smartparens-mode)))

(defun jsx/post-init-web-mode ()
  (define-derived-mode jsx-mode web-mode "jsx")
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . jsx-mode))
  (setq
   web-mode-enable-auto-quoting nil
   js2-basic-offet 2
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-attr-indent-offset 2
   web-mode-content-types-alist '(("jsx" . ".\\.js[x]?\\'"))
   )
  )
