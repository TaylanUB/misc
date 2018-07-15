(setq

 auth-sources (list (sysfile 'authinfo))

 message-directory (sysdir 'maildir)

 send-mail-function 'smtpmail-send-it
 smtpmail-default-smtp-server "smtp.gmail.com"
 smtpmail-smtp-server "smtp.gmail.com"
 smtpmail-smtp-service "587"
 smtpmail-queue-dir (concat message-directory "queued-mail")

 smime-certificate-directory (concat message-directory "certs")

 nnmbox-active-file (sysfile 'home-junk "mbox-active")

 mail-user-agent 'gnus-user-agent

 )

(load (emacs-config-file "gnus"))
