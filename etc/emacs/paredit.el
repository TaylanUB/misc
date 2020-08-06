(load "paredit")

(add-hook 'prog-mode-hook 'paredit-mode)
(add-hook 'ielm-mode-hook 'paredit-mode)
(add-hook 'mmm-mode-hook 'paredit-mode)

(add-hook 'minibuffer-setup-hook 'paredit-minibuffer-setup)
(defun paredit-minibuffer-setup ()
  (when (memq this-command '(eval-expression ibuffer-do-eval))
    (paredit-mode)))

(add-to-list 'paredit-space-for-delimiter-predicates 'ignore)

(define-keys paredit-mode-map
  ("{" 'paredit-open-curly)
  ("}" 'paredit-close-curly)
  ("M-{" 'paredit-wrap-curly)
  ("M-[" 'paredit-wrap-square)
  )
