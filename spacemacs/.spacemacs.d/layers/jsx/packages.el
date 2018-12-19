;;; packages.el -*- lexical-binding: t -*-


(defconst jsx-packages
      '(
        company
        evil-matchit
        flycheck
        lsp-javascript-typescript
        web-mode
        company-flow
        tern
        yasnippet
        (flycheck-flow :toggle (configuration-layer/package-usedp 'flycheck))
        smartparens
        ))

(defun jsx/post-init-company ()
  (add-hook 'web-mode-local-vars-hook #'jsx//setup-company))

(defun jsx/post-init-evil-matchit ()
  (with-eval-after-load 'evil-match
    (plist-put evilmi-plugins 'web-mode
               '((evilmi-simple-get-tag evilmi-simple-jump)
                 (evilmi-javascript-get-tag evilmi-javascript-jump)
                 (evilmi-html-get-tag evilmi-html-jump)))))

(defun jsx/post-init-flycheck ()
  (with-eval-after-load 'flycheck
    ;; Disable unsed checkers
    (dolist (checker '(javascript-jshint json-jsonlint))
      (push checker flycheck-disabled-checkers))
    ;; Enable eslint and standard checkers
    (dolist (checker '(javascript-eslint javascript-standard))
      (flycheck-add-mode checker 'web-mode))
    ;; Tweaks
    (setq flycheck-display-errors-delay 0)
    (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t))
    )

  ;; Add flycheck-flow
  (with-eval-after-load 'flycheck-flow
    (flycheck-add-next-checker 'javascript-eslint 'javascript-flow)
    (flycheck-add-mode 'javascript-flow 'web-mode)
    )

  ;; Enable flycheck in web-mode
  (spacemacs/enable-flycheck 'web-mode)
  (add-hook 'web-mode-hook 'spacemacs//javascript-setup-eslint t)
  )

(defun jsx/post-init-lsp-javascript-typescript ()
  (spacemacs//setup-lsp-jump-handler 'web-mode))

(defun jsx/init-web-mode ()
  (use-package web-mode
    :defer t
    :init
    ;; enable jsx mode by using magic-mode-alist
    (defun +javascript-jsx-file-p ()
      (and buffer-file-name
           (or (equal (file-name-extension buffer-file-name) "js")
               (equal (file-name-extension buffer-file-name) "jsx"))
           (re-search-forward "\\(^\\s-*import React\\|\\( from \\|require(\\)[\"']react\\)"
                              magic-mode-regexp-match-limit t)
           (progn (goto-char (match-beginning 1)) (not (jsx//react-inside-string-or-comment-q)))))

    (add-to-list 'magic-mode-alist (cons #'+javascript-jsx-file-p 'web-mode))

    ;; setup web-mode backend
    (add-hook 'web-mode-local-vars-hook #'jsx//setup-backend)

    :config
    ;; declare prefix
    (spacemacs/declare-prefix-for-mode 'web-mode "mr" "refactor")
    (spacemacs/declare-prefix-for-mode 'web-mode "mrr" "rename")
    (spacemacs/declare-prefix-for-mode 'web-mode "mh" "documentation")
    (spacemacs/declare-prefix-for-mode 'web-mode "mg" "goto")

    (setq
      web-mode-enable-auto-quoting nil
      js2-basic-offet 2
      web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2
      web-mode-attr-indent-offset 2
      web-mode-content-types-alist '(("jsx" . ".\\.js[x]?\\'"))
      )

    ;; (add-hook 'web-mode-hook #'jsx//use-node-modules-bin)
  )
)

(defun jsx/post-init-company-flow ()
  (with-eval-after-load 'company
    (spacemacs|add-company-backends
      :backends company-flow
      :modes web-mode
      :append-hooks nil
      :call-hooks t)))

(defun jsx/post-init-tern ()
  (add-to-list 'tern--key-bindings-modes 'web-mode))

(defun jsx/init-flycheck-flow ()
  (use-package flycheck-flow))

(defun jsx/post-init-smartparens ()
  (if dotspacemacs-smartparens-strict-mode
      (add-hook 'web-mode-hook #'smartparens-strict-mode)
    (add-hook 'web-mode-hook #'smartparens-mode)))

(defun jsx/post-init-yasnippet ()
  (add-hook 'web-mode-hook #'jsx//setup-yasnippet))
