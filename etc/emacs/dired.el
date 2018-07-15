(load "dired-x")
(load (emacs-config-file "file-dwim"))

(setq
 dired-isearch-filenames 'dwim
 dired-recursive-copies 'always
 )

(add-hook 'dired-mode-hook (enabler 'truncate-lines))

(defun dired-up-directory* ()
  "In Dired, visit the parent directory instead of the dired
buffer."
  (interactive)
  (let ((buffer (current-buffer)))
    (dired-up-directory)
    (unless (cl-find-if (lambda (w)
                          (eq buffer (window-buffer w)))
                        (window-list))
      (kill-buffer buffer))))

(defun file-dwim-dired-alternate-directory (file)
  (when (and (eq major-mode 'dired-mode)
             (file-directory-p file))
    (dired-find-alternate-file)
    t))

(add-to-list 'file-dwim-action-list 'file-dwim-dired-alternate-directory)

(define-keys dired-mode-map
  ("u" 'dired-up-directory*)
  ("^" 'dired-unmark)
  ("RET" 'file-dwim-dired)
  ("C-M-n" nil)
  ("C-M-p" nil)
  )
