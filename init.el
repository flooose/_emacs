;; No splash screen please... jeez
(setq inhibit-startup-screen t)

;; disable scroll bar
(set-scroll-bar-mode nil)

;; package.el
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; outsource customization
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

;; get rid of temporary files
(setq backup-directory-alist
			`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
			`((".*" ,temporary-file-directory t)))

;; font size
(set-face-attribute 'default nil :height 120 :font "Meslo LG S")


;; trailing white space goes away
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; numbers and stuff
(global-linum-mode t)
(setq line-number-mode t)
(setq column-number-mode t)

;; colors
(load-theme 'misterioso)

;; make kill-line at beginning of line kill-whole-line
(setq kill-whole-line t)

;; get tabs right
(setq-default c-basic-indent 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq tab-stop-list (number-sequence 2 120 2))

;; better scrolling with mouse and keyboard
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq scroll-step 1)

;; show matching parens
(show-paren-mode t)

;; predictable behaviour for guests
(delete-selection-mode 1)

;; projectile
(projectile-global-mode)
(global-set-key (kbd "C-c f")  'projectile-find-file)

;; ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;; speedbar
(add-hook 'speedbar-load-hook
             (lambda () (speedbar-add-supported-extension ".rb")))
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images nil)

;; keep buffer names unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;
;; ccrypt integration
;;
(require 'ps-ccrypt "~/.emacs.d/modes/ps-ccrypt.el")

;; Set up mac
(if (eq system-type 'darwin)
    (load-file "~/.emacs.d/config/mac-de.el"))

;; enable auto-complete
(require 'auto-complete)
(add-to-list 'ac-modes 'ruby-mode)
(global-auto-complete-mode t)

;; Slime
(eval-after-load 'slime
  '(progn
     (slime-setup '(slime-repl))))
(setq inferior-lisp-program "clisp")

;;
;; Everything from here forward should be in separate files
;;
;;(global-set-key (kbd "C-<")  'speedbar-get-focus)

;;;; figure out how to implement this.
;;(add-hook 'javascript-mode-hook
;;          '(lambda()
;;            (load-file "~/.emacs.d/config/javascript-mode-config.el")))
(load-file "~/.emacs.d/config/javascript-mode-config.el")

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
