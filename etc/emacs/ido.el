(load "ido")

(ido-mode 1)
(ido-everywhere 1)

(setq
 ido-decorations '("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]"
                   " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")
 ido-save-directory-list-file (emacs-junk-file "ido.last")
 ido-auto-merge-work-directories-length -1
 ido-enable-flex-matching t
 )

(add-to-list 'ido-ignore-buffers #'taylan-ignore-buffer-p)

(add-hook 'ido-minibuffer-setup-hook (disabler 'truncate-lines))
