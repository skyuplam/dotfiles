;;; autoload/evil-move-lines.el -*- lexical-binding: t; -*-
;;;###if (featurep! :feature evil)

;; Universal evil integration
;;;###autoload (autoload 'evil-move-up' "autoload/evil-move-lines" nil t)
(evil-define-operator evil-move-up (beg end)
  "Move region up by one line."
  :motion evil-line
  (interactive "<r>")
  (evil-visual-line)
  (let ((beg-line (line-number-at-pos beg))
        (end-line (line-number-at-pos end))
        (dest (- (line-number-at-pos beg) 2)))
    (evil-move beg end dest)
    (goto-line (- beg-line 1))
    (exchange-point-and-mark)
    (goto-line (- end-line 2))
    (evil-visual-line)
    )
  )

;;;###autoload (autoload 'evil-move-down' "autoload/evil-move-lines" nil t)
(evil-define-operator evil-move-down (beg end)
  "Move region down by one line."
  :motion evil-line
  (interactive "<r>")
  (evil-visual-line)
  (let ((beg-line (line-number-at-pos beg))
        (end-line (line-number-at-pos end))
        (dest (+ (line-number-at-pos end) 0)))
    (evil-move beg end dest)
    (goto-line (+ beg-line 1))
    (exchange-point-and-mark)
    (goto-line (+ end-line 0))
    (evil-visual-line)
    )
  )

;;;###autoload (autoload 'evil-move-left' "autoload/evil-move-lines" nil t)
(evil-define-operator evil-move-left (beg end)
  :motion evil-line
  (interactive "<r>")
  (evil-visual-line)
  (evil-shift-left beg end 1)
  (evil-visual-line)
  )

;;;###autoload (autoload 'evil-move-right' "autoload/evil-move-lines" nil t)
(evil-define-operator evil-move-right (beg end)
  :motion evil-line
  (interactive "<r>")
  (evil-visual-line)
  (evil-shift-right beg end 1)
  (evil-visual-line)
  )

;;;###autoload
(defun evil-move-region-default-bindings ()
  "Bind `evil-move-up', `evil-move-down`, `evil-move-left' and `evil-move-right' to M-k, M-j, M-h and M-l respectively"
  (define-key evil-normal-state-map (kbd "M-k") 'evil-move-up)
  (define-key evil-normal-state-map (kbd "M-j") 'evil-move-down)
  (define-key evil-normal-state-map (kbd "M-h") 'evil-move-left)
  (define-key evil-normal-state-map (kbd "M-l") 'evil-move-right)
)
