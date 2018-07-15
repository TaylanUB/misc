(load "ibuf-ext")

(defun taylan-ignore-buffer-p (buffer)
  "Tells whether BUFFER should be ignored by Ibuffer, IDO, etc."
  (with-current-buffer buffer
    (or (memq major-mode '(
                           help-mode
                           apropos-mode
                           completion-list-mode
                           Custom-mode
                           grep-mode
                           calc-mode
                           calc-trail-mode
                           tags-table-mode
                           ibuffer-mode
                           Info-mode
                           browse-kill-ring-mode
                           geiser-messages-mode
                           geiser-debug-mode
                           magit-branch-manager-mode
                           magit-diff-mode
                           magit-log-mode
                           magit-process-mode
                           magit-refs-mode
                           magit-revision-mode
                           ))
        (string-match-p (rx
                         (or (: bos "*tramp/")
                             (: bos (or
                                     "*GNU Emacs*"
                                     "*Messages*"
                                     "*scratch*"
                                     "*Shell Command Output*"
                                     "*Compile-Log*"
                                     "*Backtrace*"
                                     "*fsm-debug*"
                                     "*Quail Completions*"
                                     )
                                eos)))
                        (buffer-name)))))

(byte-compile 'taylan-ignore-buffer-p)

(define-ibuffer-filter in-directory
  "Toggle current view to buffers whose default-directory is in QUALIFIER."
  (:description "in-directory"
   :reader (read-directory-name "Directory: "))
  (with-current-buffer buf (file-in-directory-p default-directory qualifier)))

(setq

 ibuffer-default-sorting-mode 'mode-name

 ibuffer-saved-filter-groups
 `(("default"
    ("TODO" (filename . ,(sysfile 'home "todo")))
    ("IRC Servers" (mode . circe-server-mode))
    ("IRC Channels" (mode . circe-channel-mode))
    ("IRC Queries" (mode . circe-query-mode))
    ("Gnus" (or
             (mode . message-mode)
             (mode . bbdb-mode)
             (mode . mail-mode)
             (mode . gnus-group-mode)
             (mode . gnus-summary-mode)
             (mode . gnus-article-mode)
             ))
    ("W3M" (mode . w3m-mode))
    ("Emacs Config" (in-directory . ,emacs-config-dir))
    ("Emacs" (in-directory . ,(sysdir 'home-src "emacs")))
    ("Conkeror" (in-directory . ,(sysdir 'home-src "conkeror")))
    ("Conkeror Config" (in-directory . ,(sysdir 'conkeror-config-dir)))
    ("Guile" (in-directory . ,(sysdir 'home-src "guile")))
    ("Guix" (in-directory . ,(sysdir 'home-src "guix")))
    ("Scheme" (in-directory . ,(sysdir 'home-src "scheme")))
    ("~/bin" (in-directory . ,(sysdir 'home-bin)))
    ("Other Projects" (in-directory . ,(sysdir 'home-src)))
    ))

 ibuffer-never-show-predicates '(taylan-ignore-buffer-p)

 )

(add-hook 'ibuffer-mode-hook 'ibuffer-switch-to-default-filter-group)
(defun ibuffer-switch-to-default-filter-group ()
  (ibuffer-switch-to-saved-filter-groups "default"))

(add-hook 'ibuffer-mode-hook 'ibuffer-auto-mode)
