(use-modules (guile-wm keymap))

(use-wm-modules
 fullscreen message minibuffer time window-cycle)

(define-keymap top
 ((s-a) (window-cycle))
 ((s-o) (window-cycle))
 ((s-n) )
 )
