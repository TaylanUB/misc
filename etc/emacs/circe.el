(load (emacs-config-file "lui"))
(load "circe")

(load "lui-irc-colors")
(enable-lui-irc-colors)

(load "circe-color-nicks")
(enable-circe-color-nicks)
(setq
 circe-color-nicks-min-contrast-ratio 4
 circe-color-nicks-min-difference 10
 circe-color-nicks-min-my-message-difference 15
 )

(load "circe-lagmon")
(setq circe-lagmon-check-interval 10)
(setq circe-lagmon-reconnect-interval 120)
(circe-lagmon-mode)

(add-hook 'circe-channel-mode-hook 'taylan-circe-channel-mode-setup)
(defun taylan-circe-channel-mode-setup ()
  (setq circe-reduce-lurker-spam t))

(add-hook 'circe-chat-mode-hook 'taylan-circe-chat-mode-setup)
(defun taylan-circe-chat-mode-setup ()
  (set (make-local-variable 'lui-logging-file-format) "{target}@{network}"))

(setq
 circe-network-options
 `(("Freenode"
    :nickserv-password ,irc-freenode-password
    :channels ("#guile"
               "#guix"
               "#scheme"
               )
    )
   ("OFTC"
    :tls t
    :nickserv-password ,irc-oftc-password
    :channels ("##imawizard")
    )
   ("Lainchan"
    :host "irc.lainchan.org"
    :port 6697
    :tls t
    :nickserv-password ,irc-lainchan-password
    :channels ("#lainchan")
    :nickserv-mask ,(rx bol "NickServ!services@services.host" eol)
    :nickserv-identify-challenge
    ,(rx bol "This nickname is registered and protected.")
    :nickserv-identify-command "PRIVMSG NickServ :IDENTIFY {password}"
    :nickserv-identify-confirmation
    ,(rx bol "Password accepted - you are now recognized." eol)
    )
   ("Snoonet"
    :host "irc.snoonet.org"
    :port (6667 . 6697)
    :tls t
    :channels ("#gendercritical")
    )
   ("Rizon"
    :host "irc.rizon.net"
    :port (6667 . 6697)
    :tls t
    :nickserv-mask ,(rx bol "NickServ!service@rizon.net" eol)
    :nickserv-identify-challenge
    ,(rx bol "This nickname is registered and protected.")
    :nickserv-identify-command "PRIVMSG NickServ :IDENTIFY {password}"
    :nickserv-identify-confirmation
    ,(rx bol "Password accepted - you are now recognized." eol)
    :nickserv-ghost-command "PRIVMSG NickServ :GHOST {nick} {password}"
    :nickserv-ghost-confirmation
    ,(rx (or (: bol "Ghost with your nick has been killed." eol)
             (: bol "Nick " (+ nonl) " isn't currently in use." eol)))
    :nickserv-password ,irc-rizon-password
    )
   ("Mozilla"
    :host "irc.mozilla.org"
    :port (nil . 6697)
    :tls t
    :nickserv-mask ,(rx bol "NickServ!services@mozilla.org" eol)
    :nickserv-identify-challenge ,(rx bol "This nick is owned by someone else.")
    :nickserv-identify-command "PRIVMSG NickServ :IDENTIFY {password}"
    :nickserv-identify-confirmation
    ,(rx bol "Password accepted - you are now recognized." eol)
    :nickserv-ghost-command "PRIVMSG NickServ :GHOST {nick} {password}"
    :nickserv-ghost-confirmation
    ,(rx (or (: bol "Ghost with your nick has been killed." eol)
             (: bol "Nick " (+ nonl) " isn't currently in use." eol)))
    :nickserv-password ,irc-mozilla-password
    )
   ("Criten"
    :host "irc.criten.net"
    :port (6667 . 7500)
    :tls t
    )
   ("SynIRC"
    :host "irc.synirc.net"
    :port (6667 . 6697)
    :tls t
    )
   ("Bitlbee"
    :host "localhost"
    :port 6668
    :nickserv-mask "root!root@"
    :lagmon-disabled t
    :nickserv-password ,irc-bitlbee-password
    )
   ("I2P"
    :host "127.0.0.1"
    :port 6669
    )
   ))

(setq

 circe-default-nick "taylan"
 circe-default-user "someone"
 circe-default-realname "someone"

 circe-server-auto-join-default-type :after-nick

 circe-format-say "{nick} {body}"
 circe-format-self-say "{nick} {body}"
 circe-format-action "*{nick} {body}"
 circe-format-self-action "*{nick} {body}"
 circe-format-server-topic "*** Topic change by {origin}: {topic-diff}"

 circe-highlight-nick-type 'occurrence

 circe-use-cycle-completion t

 circe-new-buffer-behavior-ignore-auto-joins t

 circe-active-users-timeout (* 60 60)

 circe-split-line-length 400            ;friggin' long IPv6 hostnames

 )

(add-to-list
 'display-buffer-alist
 '((lambda (buffer action)
     (with-current-buffer buffer
       (eq major-mode 'circe-channel-mode)))
   .
   (display-buffer-same-window . nil)))

(defun circe-network-connected-p (network)
  "Return non-nil if there's any Circe server-buffer whose
`circe-server-netwok' is NETWORK."
  (catch 'return
    (dolist (buffer (circe-server-buffers))
      (with-current-buffer buffer
        (if (string= network circe-server-network)
            (throw 'return t))))))

(defun circe-maybe-connect (network)
  "Connect to NETWORK, but ask user for confirmation if it's
already been connected to."
  (interactive "sNetwork: ")
  (if (or (not (circe-network-connected-p network))
          (y-or-n-p (format "Already connected to %s; reconnect?" network)))
      (circe network)))

(defun irc ()
  "Connect to common IRC servers."
  (interactive)
  (unless (circe-network-connected-p "Freenode")
    (circe "Freenode"))
  (unless (circe-network-connected-p "OFTC")
    (circe "OFTC"))
  ;; (dolist (network '("Freenode"))
  ;;   (circe-maybe-connect network))
  )
