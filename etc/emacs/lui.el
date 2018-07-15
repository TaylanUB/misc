(load "circe")
(load "lui-logging")

(add-hook 'lui-mode-hook 'enable-lui-logging)

(setq

 tracking-frame-behavior nil

 lui-time-stamp-format "%H:%M:%S.%3N"
 lui-time-stamp-position 'left-margin
 lui-fill-column 80

 lui-logging-directory (sysdir 'home-log "lui")
 lui-logging-file-format "{buffer}"
 lui-logging-format "%Y-%m-%d %H:%M:%S.%N %z {text}"

 lui-max-buffer-size 30000

 lui-scroll-behavior nil

 lui-time-stamp-only-when-changed-p nil

 )

(add-hook 'lui-mode-hook 'taylan-lui-mode-setup)
(defun taylan-lui-mode-setup ()
  "Main function for `lui-mode-hook'."
  (setq
   fringes-outside-margins t
   word-wrap t
   wrap-prefix "    "
   )
  (set (make-local-variable 'truncate-partial-width-windows) lui-fill-column))

(defun lui-visit-log (&optional buffer)
  "Open the lui log file for the given buffer."
  (interactive)
  (let ((file (with-current-buffer (or buffer (current-buffer))
                (lui-logging-file-name))))
    (find-file file)
    (auto-revert-tail-mode)))

(defun lui-toggle-timestamp-margin ()
  "Toggle the visibility of the margin for time-stamps in the
current buffer.  Don't use this if you don't use the margin for
time-stamps.

This function assumes that the result of `lui-time-stamp-format'
is always a string of the same length."
  (interactive)
  (let ((margin-width-var
         (case lui-time-stamp-position
           (left-margin 'left-margin-width)
           (right-margin 'right-margin-width)
           (otherwise
            (error "Your time-stamps don't seem to be in the margin.")))))
    (set margin-width-var
         (if (zerop (symbol-value margin-width-var))
             (+ (length (format-time-string lui-time-stamp-format))
                (if fringes-outside-margins 1 0))
           0)))
  (let ((old (current-buffer)))
   (switch-to-buffer (other-buffer))
   (switch-to-buffer old)))

;; (add-hook
;;  'window-configuration-change-hook
;;  (defun lui-recenter-after-window-configuration-change ()
;;    (when (eq major-mode f))))

(define-keys lui-mode-map
  ("C-c C-l" 'lui-visit-log)
  ("C-c C-m" 'lui-toggle-timestamp-margin)
  )
