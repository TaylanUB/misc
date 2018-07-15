(eval-after-load "nxml-mode"
  '(progn
     (setq
      nxml-sexp-element-flag t
      nxml-slash-auto-complete-flag t
      )

     (add-hook 'nxml-mode-hook 'taylan-nxml-mode-setup)
     (defun taylan-nxml-mode-setup ()
       (syntax-table-add-quote-char ?'))

     (define-keys nxml-mode-map
       ("RET" 'newline-and-indent)
       ("C-M-n" nil)
       ("C-M-p" nil)
       )))
