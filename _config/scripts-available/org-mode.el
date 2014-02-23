(setq org-directory "/scpc:chris@192.168.1.200:public_html/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
     '(("t" "Todo" entry (file+headline headline "/scpc:chris@192.168.1.200:public_html/org/notes.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
       ("j" "Journal" entry (file+datetree "/scpc:chris@192.168.1.200:public_html/org/journal.org")
      "* %?\nEntered on %U\n  %i\n  %a")))

;(setq org-agenda-files "/scpc:chris@192.168.1.200:public_html/org/") ;; when a directory, all org files are agenda files
;;; org-mobile-files defaults to all agenda files
;;; org-todo-keywords has sane default
;;; org-tag-alist still has to be set
;(setq org-mobile-directory "/scpc:chris@192.168.1.200:public_html/org/")
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
