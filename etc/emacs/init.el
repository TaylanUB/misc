(package-initialize)

(defun reload-environment ()
  "Set environment variables according to ~/etc/environment.
Note that this cannot prune variables which were removed
entirely."
  (interactive)
  (with-temp-buffer
    (call-process "sh" nil nil nil "-c" ". ~/etc/profile")
    (insert-file-contents "~/etc/environment")
    (while (not (eobp))
      (let ((line (buffer-substring (line-beginning-position)
                                    (line-end-position))))
        (string-match (rx (group (+ (in "a-zA-Z0-9_"))) "="
                          (group (* any)))
                      line)
        (setenv (match-string 1 line) (match-string 2 line))
        (forward-line)))))

(reload-environment)

(let ((libdir (concat (getenv "EMACS_LIBRARY_DIR"))))
  (add-to-list 'load-path libdir)
  (dolist (subdir (directory-files libdir t "^[^.]"))
    (when (file-directory-p subdir)
      (add-to-list 'load-path subdir))))

;;; Use .el here, otherwise it tries to load a directory.
(load "taylan-lib.el")

(make-dir-abstractions
 (emacs-lib (sysdir 'emacs-library-dir))
 (emacs-config (sysdir 'emacs-config-dir))
 (emacs-junk (sysdir 'emacs-junk-dir)))

(add-to-list 'load-path (sysdir 'home-usr "share/emacs/site-lisp"))
(add-to-list 'load-path (sysdir 'guix-profile "share/emacs/site-lisp"))

(setq-default

 cursor-type 'bar
 cursor-in-non-selected-windows nil

 indent-tabs-mode nil

 )

(setq

 scroll-preserve-screen-position 'keep

 backup-inhibited t
 auto-save-file-name-transforms `((".*" ,(emacs-junk-file "autosave/_") t))
 auto-save-list-file-prefix (emacs-junk-file "autosave/.saves-")

 async-shell-command-buffer 'new-buffer

 dired-listing-switches "-lha"
 dired-auto-revert-buffer t

 browse-url-browser-function 'browse-url-generic-or-w3m
 browse-url-generic-program (getenv "WWW")
 browse-url-new-window-flag t

 yow-file (emacs-junk-file "yow.lines")

 enable-recursive-minibuffers t

 echo-keystrokes 0.1

 ring-bell-function #'ignore

 ns-antialias-text nil
 ns-right-option-modifier 'none
 ns-right-command-modifier 'none

 erc-track-enable-keybindings nil

 global-auto-revert-non-file-buffers t

 gnutls-min-prime-bits 1024

 ediff-window-setup-function 'ediff-setup-windows-plain

 Man-width 125

 find-function-C-source-directory (sysdir 'home-src "emacs/emacs-24.5/src")

 fci-rule-color "#333333"

 magit-delete-by-moving-to-trash nil

 split-height-threshold 120

 epa-pinentry-mode 'loopback

 )

;;; Need to set that after first creating an X frame.
(add-hook
 'after-make-frame-functions
 (defun taylan-after-make-frame (frame)
   (setq x-selection-timeout 300)))

(cl-loop
 for (key val) in
 `((font "Terminus 10")
   (scroll-bar nil)
   (fullscreen fullboth))
 do (aput 'default-frame-alist key val))

(cl-loop
 for (regex mode) in
 `(("\\.sld\\'" scheme-mode)
   ("\\.package\\'" scheme-mode)
   ("/etc/guile/" scheme-mode)
   ("/etc/profile\\'" sh-mode)
   ("/etc/shenv\\'" sh-mode)
   ("/etc/bash/" sh-mode)
   ("/etc/shellplayer/config\\'" sh-mode)
   ("/etc/tor/rc\\'" conf-mode)
   ("\\.html\\'" nxml-mode)
   ("\\.json\\'" json-sexp-mode)
   (,(sysdir 'home-log) fundamental-mode)
   ("\\.md\\'" text-mode)
   ("/README\\'" text-mode)
   ("\\.strings\\'" c-mode)
   )
 do (add-to-list 'auto-mode-alist (cons regex mode)))

(cl-loop
 for extension in
 '(".go")
 do (add-to-list 'completion-ignored-extensions extension))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(mouse-wheel-mode -1)
(show-paren-mode 1)
(winner-mode 1)
(global-auto-revert-mode 1)

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

(load "saveplace")
(save-place-mode)
(setq save-place-file (emacs-junk-file "places"))

(load "ls-lisp")
(setq
 ls-lisp-use-insert-directory-program nil
 ls-lisp-emulation nil
 )
(ls-lisp-set-options)

(load "flyspell")
(setq flyspell-default-dictionary "american")

;(load "guix-init")

;;; In $ENV we do the same if TERM=dumb, for M-x shell.
(defadvice shell-command (around set-pager-to-cat activate)
  (let ((process-environment (cons "PAGER=cat" process-environment)))
    ad-do-it))

(defun delete-failed-processes ()
  "Delete all processes with status `failed'."
  (interactive)
  (dolist (p (process-list))
    (if (eq 'failed (process-status p))
        (delete-process p))))

(defun insert-sig ()
  (interactive)
  (insert (format "%s <%s>" user-full-name user-mail-address)))

(defun insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M")))

(load "idle-cursor-morph")

(load "json-sexp-mode")

(load "shell-quasiquote")

(browse-kill-ring-default-keybindings)

(load "fill-column-indicator")

(dolist (file
         `(secrets                                     ;This always first.
           keymap                                      ;This always second.
           undo-tree ibuffer dired ido tramp webjump term mail
           text nxml prog scheme clojure paredit
           workgroups circe lterm w3m
           ))
  (load (emacs-config-file (symbol-name file))))

;; Do this towards the end so errors in the init are noticed immediately.
(load-theme 'wombat)
(set-face-attributes
 (default :foreground "#cccccc" :background "black")
 (cursor :background "white")
 (mouse :background "white"))

(setq custom-file (emacs-junk-file "custom"))
(load custom-file)

(mapatoms
 (lambda (a)
   (when (and (commandp a) (get a 'disabled))
     (put a 'disabled nil))))

(if (getenv "DISPLAY")
    (start-process "xinitrc" nil (concat (getenv "HOME") "/bin/xinitrc")))
