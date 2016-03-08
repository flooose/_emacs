;; No splash screen please... jeez
(setq inhibit-startup-screen t)

;; disable scroll bar
(set-scroll-bar-mode nil)

;; what time is it?
(display-time-mode 1)

;; we don't always want to do this manually
(toggle-frame-maximized)

;; recursive minibuffers
(setq enable-recursive-minibuffers t)

(require 'cl-lib)

;; package.el
(require 'package)

(add-hook 'after-init-hook 'global-company-mode)

(package-initialize)

(setq packages '(ace-window
                 cider
                 clojure-mode
                 coffee-mode
                 company
                 dash
                 dockerfile-mode
                 dot-mode
                 epl
                 ess
                 eww
                 expand-region
                 flycheck
                 flymake-coffee
                 flymake-haml
                 flymake-jslint
                 flymake-ruby
                 free-keys
                 haml-mode
                 inf-ruby
                 jade-mode
                 js2-mode
                 magit
                 markdown-mode
                 monokai-theme
                 multiple-cursors
                 nyan-mode
                 polymode
                 projectile
                 puppet-mode
                 robe
                 rspec-mode
                 ;ruby-electric
                 ruby-end
                 ruby-tools
                 sass-mode
                 slime
                 toggle-quotes
                 twittering-mode
                 undo-tree
                 web-mode
                 wrap-region
                 yaml-mode
                 yasnippet))

(setq missing-packages (cl-remove-if 'package-installed-p packages))

(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; This breaks if there is no network
;; see https://github.com/bodil/emacs.d/blob/master/init.el#L52 for a possible fix
(defun flooose-install-packages ()
    (if (> (length missing-packages) 0)
        (progn (message "Installing missing packages")
               (package-refresh-contents)
               (dolist (package missing-packages)
                 (package-install package)))))
(flooose-install-packages)

(yas-global-mode 1)
(add-hook 'term-mode-hook (lambda()
        (setq yas-dont-activate t)))

;; outsource auto-generated emacs customization
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

;; cursor to bar
(setq-default cursor-type 'bar)

;; get rid of temporary files
(setq create-lockfiles nil)
(setq backup-directory-alist
			`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
			`((".*" ,temporary-file-directory t)))

;; font size
(setq default-frame-alist '((font . "Meslo LG S")))

;; trailing white space goes away
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; numbers and stuff
(global-linum-mode t)
(setq line-number-mode t)
(setq column-number-mode t)

;; colors
(load-theme 'monokai)

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
(global-set-key (kbd "C-, f") 'projectile-find-file)
(global-set-key (kbd "C-, 4 f") 'projectile-find-file-other-window)
(global-set-key (kbd "C-, 5 f") 'projectile-find-file-other-frame)
(global-set-key (kbd "C-c C-f")  'projectile-find-file)
(add-hook 'projectile-mode-hook
          (lambda () (load-file "~/.emacs.d/patches/projectile.el")))
(global-set-key (kbd "C-c 4 f")  'projectile-find-file-other-window)
(global-set-key (kbd "C-c 5 f")  'projectile-find-file-other-frame)

;; twittering-mode-hook
(add-hook 'twittering-mode-hook
          (lambda () (setq twittering-use-master-password t)))

;; load enabled scripts
(dolist (item (nthcdr 2 (directory-files "~/.emacs.d/_config/scripts-enabled/" t)))
  (load-file item))

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

;; See https://github.com/pezra/rspec-mode about why this is here
(add-hook 'after-init-hook 'inf-ruby-switch-setup)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
(eval-after-load 'company
  '(push 'company-robe company-backends))

(setenv "PATH" (concat (getenv "PATH") ":~/.rbenv/shims"))
(setq rspec-use-rake-when-possible nil)

(add-hook 'ruby-mode-hook
          (lambda ()
            ;; Needed for ruby-electric-mode see
            ;; http://stackoverflow.com/questions/10326255/emacs-ruby-electric-does-not-insert-end
            ;; for context, although it is not properly solved there
            (defun ruby-insert-end ()
              (interactive)
              (insert "end")
              (ruby-indent-line t)
              (end-of-line))
            ;(ruby-electric-mode)
            (ruby-tools-mode)
            (robe-mode)
            (flymake-ruby-load)
            (setq ruby-insert-encoding-magic-comment nil)
            (setq ruby-deep-arglist nil)
            (setq ruby-deep-indent-paren nil)
            (local-set-key (kbd "C-, r") 'rspec-verify-single)
            (local-set-key (kbd "C-, R") 'rspec-verify)))

(add-hook 'coffee-mode-hook 'flymake-coffee-load)
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(setq flymake-jslint-command "eslint")
(add-hook 'js2-mode-hook 'flymake-jslint-load)
(add-hook 'web-mode-hook
          (lambda ()
            (if (or (equal web-mode-content-type "jsx") (equal web-mode-content-type "javascript"))
                (flymake-jslint-load))))



;; Slime
(eval-after-load 'slime
  '(progn
     (slime-setup '(slime-repl))))
(setq inferior-lisp-program "clisp")

;; do what people expect when regions are active
(wrap-region-global-mode t)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))                 ;; personal snippets
(require 'yasnippet)
(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.

;;
;; Everything from here forward should be in separate files
;;

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; fix stupid gui functionality
(global-set-key (kbd "C-z")  'undo)

;; make working with strings easier
(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "C-x o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-scope 'frame)

(electric-indent-mode nil)

(require 'poly-R)
(require 'poly-markdown)
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)

(cd (or
     (getenv "CURRENT_PROJECT")
     (getenv "HOME")))

(ansi-term "/usr/bin/bash")

(global-set-key (kbd "C-, f") 'projectile-find-file)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(add-hook 'web-mode-hook
          (lambda ()
            ;; short circuit js mode and just do everything in jsx-mode
            (if (equal web-mode-content-type "javascript")
                (web-mode-set-content-type "jsx")
              (message "now set to: %s" web-mode-content-type))

            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-css-indent-offset 2)
            (setq web-mode-code-indent-offset 2)))

;; global npm dependencies: eslint, babel-eslint, eslint-plugin-react
;; run `sudo npm install eslint babel-eslint, eslint-plugin-react -g`
(require 'flycheck)
(flycheck-add-mode 'javascript-eslint 'web-mode)
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))
(setq-default flycheck-disabled-checkers
            (append flycheck-disabled-checkers
                    '(json-jsonlist)))

(add-to-list 'grep-find-ignored-directories "node_modules")
