
;; START PERSONAL SETTINGS
(server-start)

;; shut off splash screen
(setq inhibit-splash-screen t)

;; get rid of temporary files
(setq backup-directory-alist
			`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
			`((".*" ,temporary-file-directory t)))

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

(setq default-tab-width 2)

;;(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
;;(require 'coffee-mode)
;;(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
;;(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;;;; twitter
;;(add-to-list 'load-path "~/.emacs.d/vendor/twittering-mode")
;;(require 'twittering-mode)
;;(setq twittering-use-master-password t)

;; json
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))

;; see http://stackoverflow.com/questions/4006005/how-can-i-set-emacs-tab-settings-by-file-type
;; about a great explanation on this.
(setq js-indent-level 2)

;; Ruby
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake" . ruby-mode))

;; clojure
(require 'clojure-mode)

;; color-theme
(add-to-list 'load-path "~/.emacs.d/modes/color-theme-6.6.0")
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-dark-blue2)

;; Slime
(setq inferior-lisp-program "clisp") ; your Lisp system
;;(add-to-list 'load-path "~/Projects/slime") ; your SLIME directory
;;(require 'slime)
;;(slime-setup)

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/elpa/popup-0.5/")
(require 'popup)

(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)

;; ccrypt integration
(require 'ps-ccrypt "ps-ccrypt.el")

;; yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;;; yasnippet
;;(add-to-list 'load-path
;;              "~/.emacs.d/plugins")
;;(add-to-list 'load-path
;;						 "~/.emacs.d/elpa/yasnippet-bundle-0.6.1")
;;(require 'yasnippet-bundle)
;;(yas/initialize)
;;(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")

;;;; android-mode
;;(add-to-list 'load-path "~/emacs/android-mode")
;;(require 'android-mode)
;;(setq android-mode-sdk-dir "~/opt/android-sdk")
;;(add-hook 'gud-mode-hook
;;					(lambda ()
;;            (add-to-list 'gud-jdb-classpath "/home/gregj/work/android-sdk-linux_86/platforms/android-7/android.jar")
;;            ))

;; font size
(set-face-attribute 'default nil :height 120)

;; color-theme
(setq color-theme-is-global t)
(add-to-list 'load-path "~/.emacs.d/modes/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-blue2)

;; get tabs right
(setq-default c-basic-indent 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

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

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;; ack-and-a-half
(add-to-list 'load-path "~/emacs.d/elpa/ack-and-a-half-1.1.0")
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

;; scroll one line at a time
(setq scroll-step 1)

;; show matching parens
(show-paren-mode t)

;; no longer needed because ffip works
;;(require 'textmate)

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
 '(custom-safe-themes (quote ("71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; not sure if I want this
;;(require 'powerline)

;; emacs-nav
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-nav")
(require 'nav)
(nav-disable-overeager-window-splitting)
(global-set-key [f8] 'nav-toggle)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-v C-S-v") 'mc/edit-lines)
(global-set-key (kbd "C-c v") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c M-v") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c M-S-v") 'mc/mark-all-like-this)

;; evil for guests
(require 'evil)
;;(evil-mode 1)
(global-set-key (kbd "C-c e") 'evil-mode)
