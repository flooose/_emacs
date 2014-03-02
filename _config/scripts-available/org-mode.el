(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-directory "~/Spaces/org-mode")
(setq org-default-notes-file (concat org-directory "/index.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
     '(("t" "Todo" entry (file+headline (concat org-directory "/index.org") "Tasks")
        "* TODO %?\n  %i\n  %a")
       ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
      "* %?\nEntered on %U\n  %i\n  %a")
       ("w" "Wortschatz" entry (file (concat org-directory "/vokab.org"))
      "* %?\n")
       ("s" "Shopping" entry (file (concat org-directory "/shopping.org"))
      "* TODO %?\n  %i\n")))

(setq org-agenda-files (list org-directory))

;; mobileorg
(setq org-mobile-directory "/scpc:chris@192.168.1.200:public_html/org/")
(setq org-mobile-keywords (list "shopping" "todo"))
(setq org-mobile-inbox-for-pull (concat org-directory "/from-mobile.org"))
(setq org-mobile-files (list
                   (concat org-directory "/index.org")
                   (concat org-directory "/todo.org")
                   (concat org-directory "/shopping.org")
                   (concat org-directory "/vokab.org")))

;;; org-todo-keywords has sane default
;;; org-tag-alist still has to be set
;


;(setq org-agenda-files "/scpc:chris@192.168.1.200:public_html/org/") ;; when a directory, all org files are agenda files
;;; org-mobile-files defaults to all agenda files
;;; org-todo-keywords has sane default
;;; org-tag-alist still has to be set
;(setq org-mobile-directory "/scpc:chris@192.168.1.200:public_html/org/")
;(setq org-default-notes-file (concat org-directory "/scpc:chris@192.168.1.200:public_html/org/notes.org"))
;(define-key global-map "\C-cc" 'org-capture)
;
;(setq org-capture-templates
;      '(("j" "Journal" entry (file+datetree "/scpc:chris@192.168.1.200:public_html/org/journal.org")
;       "* %?\nEntered on %U\n  %i\n  %a")))
