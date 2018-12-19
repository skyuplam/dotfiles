;; funcs.el --- jsx layer funcs file for Spacemacs. -*- lexical-binding: t -*-

;; Backend
(defun jsx//setup-backend ()
  "Conditionally setup backend."
  (pcase javascript-backend
    (`tern (spacemacs/tern-setup-tern))
    (`lsp (spacemacs//setup-lsp))))

(defun jsx//setup-company ()
  "Conditionally setup company based on backend."
  (pcase javascript-backend
    (`tern (spacemacs/tern-setup-tern-company 'web-mode))
    (`lsp (spacemacs//setup-lsp-company))))


;; LSP
(defun jsx//setup-lsp ()
  "Setup lsp backend."
  (if (configuration-layer/layer-used-p 'lsp)
      (progn
        (lsp-javascript-typescript-enable))
    (message "`lsp' layer is not installed, please add `lsp' layer to your dotfile.")))

(defun jsx//setup-lsp-company ()
  "Setup lsp auto-completion."
  (if (configuration-layer/layer-used-p 'lsp)
      (progn
        (spacemacs|add-company-backends
          :backends company-lsp
          :modes web-mode
          :variables company-minimum-prefix-length 2
          :append-hooks nil
          :call-hooks t)
        (company-mode)
        (fix-lsp-company-prefix))
    (message "`lsp' layer is not installed, please add `lsp' layer to your dotfile.")))



;; YAS
(defun jsx//setup-yasnippet ()
  (yas-activate-extra-mode 'js-mode))


;; Others
(defun jsx//react-inside-string-q ()
  "Returns non-nil if inside string, else nil.
Result depends on syntax table's string quote character."
  (let ((result (nth 3 (syntax-ppss))))
    result))

(defun jsx//react-inside-comment-q ()
  "Returns non-nil if inside comment, else nil.
Result depends on syntax table's comment character."
  (let ((result (nth 4 (syntax-ppss))))
    result))

(defun jsx//react-inside-string-or-comment-q ()
  "Return non-nil if point is inside string, documentation string or a comment.
If optional argument P is present, test this instead of point."
  (or (jsx//react-inside-string-q)
      (jsx//react-inside-comment-q)))

(defun jsx//use-node-modules-bin ()
  (let* ((local-path (replace-regexp-in-string
                      "[\r\n]+$" "" (shell-command-to-string "npm bin"))))
    (setq-local exec-path (cons local-path exec-path))))
