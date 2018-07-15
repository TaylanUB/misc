(load "w3m-load")

(setq
 w3m-key-binding 'info
 w3m-use-tab t
 w3m-make-new-session t
 w3m-default-display-inline-images t
 )

(defun browse-url-generic-or-w3m (&rest args)
  "Browse URL with emacs-w3m if SSH_CONNECTION is set in the
current frame's environment, otherwise generic browser."
  (apply (if (getenv "SSH_CONNECTION" (selected-frame))
             'w3m-browse-url
           'browse-url-generic)
         args))

(defun w3m-kill-this-buffer ()
  "Kill the current w3m buffer."
  (interactive)
  (let ((other-buffer (other-buffer)))
    (w3m-delete-buffer)
    (switch-to-buffer other-buffer)))

(load "find-func")
(eval-after-load (find-library-name "w3m")
  '(define-keys w3m-mode-map
     ("q" 'w3m-kill-this-buffer)))
