(defvar text-mode-fill-column 120
  "Value of `fill-column' for `text-mode'.")

(add-hook 'text-mode-hook 'taylan-text-mode-setup)
(defun taylan-text-mode-setup ()
  (setq fill-column text-mode-fill-column)
  (set (make-local-variable 'truncate-partial-width-windows) fill-column)
  (enable indicate-buffer-boundaries show-trailing-whitespace)
  (auto-fill-mode)
  (fci-mode)
  ;; (flyspell-mode)
  )
