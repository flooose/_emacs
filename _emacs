
;; shut off splash screen
(setq inhibit-splash-screen t)

;; get rid of temporary files
(setq backup-directory-alist
			`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
			`((".*" ,temporary-file-directory t)))

;; load configs for other programs
(load-file "~/.emacs.d/config/gnus.el")

;; browser
(setq browse-url-generic-program (executable-find "opera")
			browse-url-browser-function 'browse-url-generic)

;; generic load-path customization
(add-to-list 'load-path "~/.emacs.d")

;; trailing white space goes away
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; force vertical split with bigger fonts
;;(setq split-height-threshold nil)
;;(setq split-width-threshold 0)

;; modes
(add-to-list 'load-path "~/.emacs.d/modes")

;;
;; twittering mode
;;
(require 'twittering-mode)

;; Maramalade
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; line numbers
(global-linum-mode t)
(setq line-number-mode t)
(setq column-number-mode t)

;; sass
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))

;;(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
;;(require 'coffee-mode)
;;(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
;;(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; json
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))

;; see http://stackoverflow.com/questions/4006005/how-can-i-set-emacs-tab-settings-by-file-type
;; about a great explanation on this.
(setq js-indent-level 2)

;;
;; Ruby
;;
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake" . ruby-mode))
;; saner indentation in parens
(setq ruby-deep-indent-paren nil)
(defun ruby-mode-for-losers ()
  (local-set-key (kbd "<enter>") 'newline-and-indent)
  (local-set-key (kbd "C-j") 'newline-and-indent)
  (local-set-key (kbd "<tab>") 'tab-to-tab-stop)
  (local-set-key (kbd "C-<tab>") 'ruby-indent-command)
  (local-set-key (kbd "{") 'self-insert-command)
  (local-set-key (kbd "}") 'self-insert-command))

(add-hook 'ruby-mode-hook 'ruby-mode-for-losers)

;; clojure
(require 'clojure-mode)

;;
;; color theme
;;

(setq flooose-color-light 'dichromacy)
(setq flooose-color-dark 'misterioso)

;; old color theme

(defun code-review ()
  (interactive)
  (load-theme flooose-color-light))

(defun not-code-review ()
  (interactive)
  (load-theme flooose-color-dark))

;; custom themes

;; solarized
(add-to-list 'custom-theme-load-path "~/.emacs.d/custom-themes/emacs-color-theme-solarized")

(load-theme flooose-color-light)

;; Slime
(setq inferior-lisp-program "clisp") ; your Lisp system
;;(add-to-list 'load-path "~/Projects/slime") ; your SLIME directory
;;(require 'slime)
;;(slime-setup)

;;
;; auto-complete
;;

;; dependency
(add-to-list 'load-path "~/.emacs.d/elpa/popup-0.5/")
(require 'popup)

(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)

;;
;; ccrypt integration
;;
(require 'ps-ccrypt "ps-ccrypt.el")

;; yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;;;
;;;; yasnippet
;;;;
;;(add-to-list 'load-path
;;						 "~/.emacs.d/elpa/yasnippet-bundle-0.6.1")
;;(require 'yasnippet-bundle)
;;(setq yas/root-directory "~/.emacs.d/snippets")
;;(yas/load-directory yas/root-directory)

;;;; android-mode
;;(add-to-list 'load-path "~/emacs/android-mode")
;;(require 'android-mode)
;;(setq android-mode-sdk-dir "~/opt/android-sdk")
;;(add-hook 'gud-mode-hook
;;					(lambda ()
;;            (add-to-list 'gud-jdb-classpath "/home/gregj/work/android-sdk-linux_86/platforms/android-7/android.jar")
;;            ))

;; font size
(set-face-attribute 'default nil :height 140)

;; get tabs right
(setq-default c-basic-indent 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq tab-stop-list (number-sequence 2 120 2))

;; ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(global-set-key (kbd "C-c C-b") 'find-file-in-project)

;; better buffer names make ido even better with fuzzy searching
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; windmove
(windmove-default-keybindings) ;; default prefix is Meta
(global-set-key (kbd "C-<")  'windmove-left)
(global-set-key (kbd "C-c <")  'windmove-left)
(global-set-key (kbd "C->") 'windmove-right)
(global-set-key (kbd "C-c >") 'windmove-right)
(global-set-key (kbd "C-S-p")    'windmove-up)
(global-set-key (kbd "C-c p")    'windmove-up)
(global-set-key (kbd "C-S-n")  'windmove-down)
(global-set-key (kbd "C-c n")  'windmove-down)

;; for the console
(global-set-key (kbd "C-c DEL") 'kill-whole-line)

;; find file name and find grep
(global-set-key (kbd "C-c F") 'find-name-dired)
(global-set-key (kbd "C-c s") 'find-grep-dired)

;; finding files
(require 'find-file-in-project)
(setq ffip-find-options' "-not -regex \".*vendor.*\" -not -regex \".*rsync_cache.*\"")
(setq ffip-full-paths' t)
(setq ffip-limit 1000)
(setq ffip-patterns (concatenate 'list '("*.haml" "*.erb" "*.sass" "*.scss" "*.xml" "*.yml" "*.json" "*.rake") ffip-patterns))
(global-set-key (kbd "C-c f") 'find-file-in-project)
(global-set-key (kbd "C-c C-p") 'find-file-in-project)

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;; ack-and-a-half
(add-to-list 'load-path "~/emacs.d/elpa/ack-and-a-half-1.1.1")
(autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)
;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
(global-set-key (kbd "C-c a") 'ack-and-a-half)

;; better scrolling with mouse and keyboard
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq scroll-step 1)

;; show matching parens
(show-paren-mode t)

;; no way!
;;(setq mac-option-key-is-meta nil)
;;(setq mac-command-key-is-meta t)
;;(setq mac-command-modifier 'meta)
;;(setq mac-option-modifier nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(ecb-layout-window-sizes (quote (("left13" (ecb-directories-buffer-name 0.25 . 0.95)))))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-source-path (quote (("~/Projects/epic-relations" "epic-relations"))))
 '(tool-bar-mode nil)
 '(menu-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; not sure if I want this
;;(require 'powerline)

;;;; multiple cursors
;;(require 'multiple-cursors)
;;(global-set-key (kbd "C-S-v C-S-v") 'mc/edit-lines)
;;(global-set-key (kbd "C-c v") 'mc/mark-next-like-this)
;;(global-set-key (kbd "C-c M-v") 'mc/mark-previous-like-this)
;;(global-set-key (kbd "C-c M-S-v") 'mc/mark-all-like-this)

;;;; evil for guests
;;(require 'evil)
;;;;(evil-mode 1)
;;;;(global-set-key (kbd "C-c e") 'evil-mode)

(add-to-list 'load-path "~/.emacs.d/elpa/ecb-snapshot-20120830")
(setq stack-trace-on-error t)
(require 'ecb)
(setq ecb-show-sources-in-directories-buffer 'always)
(setq ecb-tree-buffer-style 'ascii-guides)
(setq ecb-layout-name "left13")

;;magit
(add-hook 'after-init-hook (lambda () (require 'magit)))
;; change magit diff colors
(eval-after-load 'magit
'(progn
   (set-face-foreground 'magit-diff-add "green3")
   (set-face-foreground 'magit-diff-del "red3")
   (when (not window-system)
     (set-face-background 'magit-item-highlight "black"))))

;; Access german keys with right alt
(setq ns-right-alternate-modifier 'none)

;; rspec navigation
(add-to-list 'load-path "~/.emacs.d/elpa/rspec-mode-1.3")
(require 'rspec-mode)

;; predictable behaviour for guests
(delete-selection-mode 1)

(add-to-list 'load-path "~/.emacs.d/elpa/ruby-end-0.2.0")
(require 'ruby-end)

(load-file "~/.emacs.d/ext/ack-and-a-half-ext.el")
(autoload 'ack-and-a-half-ack-here "ack-and-a-half" nil t)

;; speedbar
(speedbar-add-supported-extension ".rb")
(setq speedbar-show-unknown-files t)
(setq speedbar-use-images nil)
