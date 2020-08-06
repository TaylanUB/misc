(defun start-graphical-browser ()
  (interactive)
  (start-process "www" nil (getenv "WWW")))

(defun start-graphical-terminal ()
  (interactive)
  (start-process "term" nil "gnome-terminal"))

(define-keys global-map
  ("C-x C-b" 'ibuffer)
  ("C-h a" 'apropos)
  ("M-o" 'other-window)
  ("<C-M-backspace>" 'backward-kill-sexp)
  ("<C-M-delete>" 'backward-kill-sexp)
  ("<C-backspace>" 'delete-indentation)
  ("<C-delete>" 'delete-indentation)
  ("<C-return>" (lambda () (interactive) (delete-indentation t)))
  ("C-c R" 'revert-buffer)
  ("C-c S" 'shell-new)
  ("C-c X" 'term-with-shell)
  ("C-c B" 'browse-url-at-point)
  ("C-c G" 'magit-status)
  ("C-c T" 'create-temporary-buffer)
  ("C-c P" 'shellplayer-edit-playlist)
  ("C-c Y" 'pastebin-yank)
  ("C-c !" 'shell-command-on-region-to-kill-ring)
  ("C-c V" 'view-mode)
  ("C-c J" 'webjump-ido)
  ("C-c D" 'compile-defun)
  ("C-c L" 'toggle-truncate-lines)
  ("C-c DEL" 'bury-buffer)
  ("M-h" 'mark-defun)
  ("M-k" 'kill-sexp)
  ("s-b" 'start-graphical-browser)
  ("s-x" 'start-graphical-terminal))

(eval-after-load "help-mode"
  '(define-keys help-mode-map
     ("l" 'help-go-back)
     ("r" 'help-go-forward)
     ))

(eval-after-load "diff-mode"
  '(define-keys diff-mode-map
     ("M-o" nil)
     ))

(eval-after-load "ibuffer"
  '(define-keys ibuffer-mode-map
     ("M-o" nil)
     ))

(eval-after-load "workgroups"
  '(define-keys global-map
     ("C-x k" 'kill-this-buffer)))
