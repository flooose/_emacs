; see http://www.emacswiki.org/emacs/GnusGmail about these settings

;(setq gnus-select-method '(nntp "news.somewhere.edu"))

; fetch mail
;(add-to-list 'gnus-secondary-select-methods '(nnimap "gmail"
;                                  (nnimap-address "imap.gmail.com")
;                                  (nnimap-server-port 993)
;                                  (nnimap-stream ssl)))
;
(setq gnus-select-method '(nnimap "gmail"
				  (nnimap-address "imap.gmail.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))

; so that gmail knows about my "sent" mail
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "skeptikos@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-local-domain "localhost")
