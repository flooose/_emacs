;; necessary in order (for instance) for yaml-imenu to work
(require 'cl)

;; keep customizations in own file
(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

;; no graphical menus
(menu-bar-mode -1)
(tool-bar-mode -1)

;; no tabs
(setq-default indent-tabs-mode nil)

;; global font size
(set-face-attribute 'default nil :height 140)

;; what time is it?
(display-time-mode 1)

;; We always want to maximize the frame. Taken from core-spacemacs.el
(unless (frame-parameter nil 'fullscreen)
  (toggle-frame-maximized))

;; cursor to bar
(setq-default cursor-type 'bar)

(show-paren-mode 1)

(global-hl-line-mode 1)

;; get rid of temporary files
(setq temporary-file-directory "~/tmp")
(setq create-lockfiles nil)
(setq backup-directory-alist
			`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
			`((".*" ,temporary-file-directory t)))

;; delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; recursvie mini buffers are good.
(setq enable-recursive-mini-buffers t)

;; numbers and stuff
(global-display-line-numbers-mode)
(setq line-number-mode t)
(setq column-number-mode t)

;; predictable behaviour for guests
(delete-selection-mode 1)

(add-to-list 'exec-path "/home/chris/.rbenv/shims")
;;(add-to-list 'exec-path "/home/chris/.nvm/versions/node/v8.9.3/bin")

;; disable adding`# coding: utf-8' to the tops of ruby files
(setq ruby-insert-encoding-magic-comment nil)
(setq ruby-deep-arglist nil)
(setq ruby-deep-indent-paren nil)

(setq require-final-newline t)

(setq set-mark-command-repeat-pop t)
(setq transient-mark-mode nil)
(global-subword-mode t)

;; PACKAGES taken from https://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name
; list the packages you want
(setq package-list '(ace-window
		     coffee-mode
		     company
		     counsel
		     elm-mode
		     expand-region
		     flycheck
		     flycheck-elm
		     haml-mode
		     highlight-indentation
		     inf-ruby
		     ivy
		     js2-mode
		     json-mode
		     magit
		     ;;poly-markdown
		     ;; poly-R
		     projectile
		     rspec-mode
		     rubocop
		     web-mode
		     which-key
		     yaml-imenu
		     yaml-mode))

; list the repositories containing them
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa". "https://melpa.org/packages/")))


; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(defun flooose-install-packages ()
    (interactive)
    (dolist (package package-list)
      (unless (package-installed-p package)
	(package-refresh-contents)
	(package-install package))))
(flooose-install-packages)

;; CONFIGURE PACKAGES

;; swiper key binding C-s
(global-set-key (kbd "C-s") 'swiper)

;; ace-window
(global-set-key (kbd "C-x o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-scope 'frame)

;; color theme
(load-theme 'gruvbox-light-medium)

;; Company mode
(add-hook 'after-init-hook 'global-company-mode)

;; Ivy
(ivy-mode 1)
(counsel-mode)

;; projectile
(projectile-mode +1)
(setq projectile-completion-system 'ivy)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;;(setq projectile-globally-ignored-directories (add-to-list 'projectile-globally-ignored-directories "node_modules"))

;; rubocop
(setq flycheck-global-modes '(ruby-mode coffee-mode jsx-ide js2-jsx-mode js2-mode javascript Javascript-IDE))
;; yaml
(yaml-imenu-enable)

(require 'flycheck) ;; This shouldn't need to be required, but somehow, without
                    ;; this flycheck doesn't work
;; In addition to adding an entry here for adding flycheck support for a new
;; language, the above variable `flycheck-global-modes` has to have the
;; languages major mode added to its list.
(add-hook 'ruby-mode-hook #'rubocop-mode)

;; flycheck
(flycheck-add-mode 'javascript-eslint 'js2-mode)
(flycheck-add-mode 'javascript-eslint 'Javascript-IDE)
(flycheck-add-mode 'javascript-eslint 'js2-jsx-mode)
(flycheck-add-mode 'coffee-coffeelint 'coffee-mode)
(flycheck-add-mode 'ruby-rubocop 'ruby-mode)
(global-flycheck-mode)

(require 'rspec-mode)
(set-variable 'rspec-use-docker-when-possible t)
;;(set-variable 'rspec-docker-command "docker-compose -f docker-compose.dev.yml exec")
(set-variable 'rspec-docker-command "docker-compose -f docker-compose.dev.yml exec -e TEST_DEBUG=full")
(set-variable 'rspec-docker-container "rails")
(set-variable 'rspec-docker-cwd "")

;; which key
(which-key-mode)

(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-:") 'mc/mark-all-like-this)

;;;;;;;;;
;;;;;;;;;

;; KEYBINDINGS

;; Yank keymap
(global-set-key (kbd "C-x r e") 'er/expand-region)
(global-set-key (kbd "C-x r c") 'er/contract-region)

(defvar flooose-yank-keymap (make-sparse-keymap "yank**") "yank**")
(define-key flooose-yank-keymap "l" (lambda () (interactive)
                                      (save-excursion
                                        (back-to-indentation)
                                        (set-mark-command nil)
                                        (move-end-of-line nil)
                                        (kill-ring-save 'doesnt-matter-because 'of-next-argument t)
                                        )
				      (message "yanked to end of line")))
(global-set-key (kbd "C-c w") flooose-yank-keymap)

(defvar flooose-git-map (make-sparse-keymap "git**") "git**")
(define-key flooose-git-map "s" 'magit-status)
(define-key flooose-git-map "b" 'magit-branch)
(define-key flooose-git-map "l" 'magit-log)
(global-set-key (kbd "C-c g") flooose-git-map)

(defvar flooose-search-map (make-sparse-keymap "search**") "git**")
(define-key flooose-search-map "G" 'rgrep)
(define-key flooose-search-map "g" 'counsel-git-grep)
(define-key flooose-search-map "f" 'find-grep-dired)
(global-set-key (kbd "C-c s") flooose-search-map)

(global-set-key (kbd "C-c x") ctl-x-map)
;; Navigation keymap
(setq flooose-navigation-keymap (make-sparse-keymap "navigate**"))
(global-set-key (kbd "C-c n") flooose-navigation-keymap)
(define-key flooose-navigation-keymap "a" 'back-to-indentation)
(define-key flooose-navigation-keymap "m" 'counsel-mark-ring)
(define-key flooose-navigation-keymap "i" 'imenu)

;; make working with strings easier
(global-set-key (kbd "C-=") 'er/expand-region)

;; taken from http://emacsredux.com/blog/2013/05/30/joining-lines/
(defun top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))
(global-set-key (kbd "C-^") 'top-join-line)

;; rgrep
(global-set-key (kbd "C-, g") 'rgrep)

(defun flooose-open-line ()
  "Open line below current line and go to it"
  (interactive)
  (end-of-line)
  (newline-and-indent))
(global-set-key (kbd "C-<return>") 'flooose-open-line)
(global-set-key (kbd "C-o") 'flooose-open-line)

(defun flooose-open-line-above ()
  "Open line above and got to it"
  (interactive)
  (beginning-of-line)
  (newline)
  (previous-line))
(global-set-key (kbd "C-S-<return>") 'flooose-open-line-above)
(global-set-key (kbd "C-S-o") 'flooose-open-line-above)

(setq flooose-duplicates-map (make-sparse-keymap "duplicate**"))
(define-key flooose-duplicates-map "d" 'repeatably-duplicate-line)
(defun repeatably-duplicate-line ()
  (interactive)
  (duplicate-line)
  (message "press d to duplicate again!")
  (set-transient-map flooose-duplicates-map))

(defun duplicate-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )
(global-set-key (kbd "C-c d") 'repeatably-duplicate-line)

;; /KEYBINDINGS

;; (disable-theme 'spacemacs-dark)

;; ;; See https://github.com/syl20bnr/spacemacs/issues/2667 for why this is necessary
;; (setq global-auto-revert-non-file-buffers nil)

;; ;; setup ess for R
;; (require 'poly-R)
;; (require 'poly-markdown)
;; (add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

;; ;; ace-window

;; ;;
;; ;; ccrypt integration
;; ;;
;; (require 'ps-ccrypt "~/.emacs.d/private/modes/ps-ccrypt.el")

;; ;; We always want to indent 2
(setq typescript-indent-level 2)
(setq js2-basic-offset 2)
(setq js-indent-level 2)
(setq js3-indent-level 2)

;; ;; tide typescript ide
;; (defun setup-tide-mode ()
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   ;; company is an optional dependency. You have to
;;   ;; install it separately via package-install
;;   ;; `M-x package-install [ret] company`
;;   (company-mode +1))

;; ;; aligns annotation to the right hand side
;; (setq company-tooltip-align-annotations t)

;; ;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

;; (add-hook 'typescript-mode-hook #'setup-tide-mode)

;; ;; format options
;; (setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

;; ;; web-mode
;; (require 'web-mode)
;; ;; see http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html for help
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode)) ;; enables jsx for all js files, should hurt anything, but in case it does, simply remove the '?' :)

;; ;; This should be the job of the linter and flycheck
;; (setq js2-strict-missing-semi-warning nil)
;; (setq js2-global-externs '("__line"))

;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (tern-mode t)
;;             (if (string-equal "jsx" (file-name-extension buffer-file-name))
;;               (web-mode-set-content-type "jsx"))))

;; ; tsx
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "tsx" (file-name-extension buffer-file-name))
;;               (progn
;;                 (web-mode-set-content-type "tsx")
;;                 (setup-tide-mode)))))

;; ;;

;; (global-company-mode t)
;; (require 'eclim)
;; (setq eclimd-autostart t)

;; (add-hook 'java-mode-hook (lambda ()
;;                             (gradle-mode t)
;;                             (global-eclim-mode)
;;                             (custom-set-variables
;;                              '(eclim-eclipse-dirs '("~/.eclipse/"))
;;                              '(eclim-executable "/usr/lib/eclipse/eclim")
;;                              '(eclimd-executable "/usr/lib/eclipse/eclimd")
;;                              )
;;                             (company-emacs-eclim)
;;                             (setq help-at-pt-display-when-idle t)
;;                             (setq help-at-pt-timer-delay 0.1)
;;                             (help-at-pt-set-timer)
;;                             (company-emacs-eclim-setup)
;;                             (setq company-emacs-eclim-ignore-case t)
;;                             ))

;; (add-hook 'kotlin-mode-hook (lambda ()
;;                             (gradle-mode t)
;;                             (global-eclim-mode)
;;                             (custom-set-variables
;;                              '(eclim-eclipse-dirs '("~/.eclipse/"))
;;                              '(eclim-executable "~/.eclipse/org.eclipse.platform_4.6.3_155965261_linux_gtk_x86_64/eclim"))
;;                             (company-emacs-eclim)
;;                             (setq help-at-pt-display-when-idle t)
;;                             (setq help-at-pt-timer-delay 0.1)
;;                             (help-at-pt-set-timer)
;;                             (company-emacs-eclim-setup)
;;                             (setq company-emacs-eclim-ignore-case t)
;;                             ))



;; (setenv "PATH" (concat (getenv "PATH") ":/usr/share/msbuild"))
;; (setq omnisharp-server-executable-path "/opt/omnisharp-roslyn/OmniSharp.exe")
;; (add-hook 'omnisharp-mode-hook (lambda ()
;;                                  (interactive)
;;                                  (setq omnisharp-server-executable-path "/opt/omnisharp-roslyn/OmniSharp.exe")
;;                                  (if (equal nil omnisharp--server-info)
;;                                      (omnisharp-start-omnisharp-server default-directory))
;;                                  (flycheck-mode)
;;                                  ))

;; ;; (set-face-background 'highlight "#222")
;; ;; (set-face-foreground 'highlight nil)
;; ;; (set-face-underline-p 'highlight t)

;; ;; (add-hook 'term-mode-hook (lambda ()
;; ;;                             (make-variable-buffer-local 'global-hl-line-mode)
;; ;;                             (global-hl-line-mode)))

;; automatically generated by dired to disable unexpected behavior warning
(put 'dired-find-alternate-file 'disabled nil)

(dolist (item (nthcdr 2 (directory-files "~/.emacs.d/scripts-enabled/" t)))
  (load-file item))
