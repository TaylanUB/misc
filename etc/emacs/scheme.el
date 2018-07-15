(cl-loop
 for (sym indent) in
 '((guard 1)
   (and-let* 1)
   (rec 1)
   (test-approximate 2))
 do (put sym 'scheme-indent-function indent))

(setq geiser-scheme-dir (emacs-lib-dir "geiser/scheme"))

(setq
 geiser-repl-history-filename (emacs-junk-file "geiser-history")
 geiser-active-implementations '(guile)
 geiser-guile-load-path (list (sysdir 'home-usr "share/geiser/guile")
                              (sysdir 'guile-load-path))
 geiser-guile-init-file (sysfile 'home-config "guile/rc")
 )

(add-hook 'geiser-repl-mode-hook 'paredit-mode)
