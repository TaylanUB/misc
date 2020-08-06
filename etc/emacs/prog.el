(defvar prog-mode-fill-column 120
  "Value of `fill-column' for `prog-mode'.")

(add-hook 'prog-mode-hook 'taylan-prog-mode-setup)
(defun taylan-prog-mode-setup ()
  (setq fill-column prog-mode-fill-column)
  (set (make-local-variable 'truncate-partial-width-windows) fill-column)
  (unless (eq major-mode 'json-sexp-mode)
    (auto-fill-mode))
  (enable indicate-buffer-boundaries)
  (fci-mode))

(load-library "scheme")
(load (emacs-lib-file "scheme-indent-function"))
