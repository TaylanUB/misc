(add-hook 'text-mode-hook 'taylan-text-mode-setup)
(defun taylan-text-mode-setup ()
  (enable indicate-buffer-boundaries show-trailing-whitespace)
  (auto-fill-mode)
  (fci-mode)
  (flyspell-mode))
