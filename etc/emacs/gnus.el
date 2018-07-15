(setq

 gnus-home-directory (emacs-junk-dir "gnus")
 gnus-startup-file (emacs-junk-file "gnus/newsrc")

 gnus-read-newsrc-file nil
 gnus-save-newsrc-file nil
 gnus-use-dribble-file nil
 gnus-message-archive-group nil

 gnus-select-method '(nnmbox "")

 gnus-secondary-select-methods
 '((nnimap "imap.gmail.com"
           (nnimap-server-port "imaps")
           (nnimap-stream ssl))
   (nntp "news.eternal-september.org"))

 gnus-use-full-window nil
 gnus-summary-goto-unread 'never

 )

(load "find-func")
(eval-after-load (find-library-name "gnus")
  '(progn
     (define-keys gnus-summary-mode-map
       ("n" 'gnus-summary-next-article)
       ("N" 'gnus-summary-next-unread-article)
       ("DEL" 'gnus-summary-prev-page-or-article)
       )
     (define-keys gnus-article-mode-map
       ("n" 'gnus-summary-next-article)
       ("N" 'gnus-summary-next-unread-article)
       )))
