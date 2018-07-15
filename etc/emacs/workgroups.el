(load "workgroups")

(workgroups-mode 1)

(setq wg-morph-on nil)

(wg-load (emacs-config-file "workgroups"))

(defun wg-associate-buffer-on-major-mode-change ()
  (let ((buffer (current-buffer)))
    (unless (string-match "^ " (buffer-name buffer))
      (wg-add-buffer-to-workgroup (wg-current-workgroup) buffer))))

(add-hook 'change-major-mode-hook 'wg-associate-buffer-on-major-mode-change)

(defun wg-limit-tracking-to-irc ()
  (tracking-mode (if (equal "irc" (wg-name (wg-current-workgroup))) 1 -1)))

(add-hook 'wg-switch-hook 'wg-limit-tracking-to-irc)

(define-keys ctl-x-map
  ("b" 'wg-switch-to-buffer)
  ("B" 'switch-to-buffer)
  ("k" 'wg-kill-buffer)
  ("K" 'kill-buffer)
  )

(define-keys wg-map
  ("C-z" 'wg-switch-to-previous-workgroup)
  )
