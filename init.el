;; keep customizations in own file
(setq custom-file "~/.emacs.d/private/emacs-custom.el")
(load custom-file)

;; global font size
(set-face-attribute 'default (selected-frame) :height 140)

(disable-theme 'spacemacs-dark)
(load-theme 'gruvbox-light-medium)

;; what time is it?
(display-time-mode 1)

;; We always want to maximize the frame. Taken from core-spacemacs.el
(unless (frame-parameter nil 'fullscreen)
  (toggle-frame-maximized))

;; cursor to bar
(setq-default cursor-type 'bar)

;; get rid of temporary files
(setq temporary-file-directory "~/tmp")
(setq create-lockfiles nil)
(setq backup-directory-alist
			`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
			`((".*" ,temporary-file-directory t)))

;; See https://github.com/syl20bnr/spacemacs/issues/2667 for why this is necessary
(setq global-auto-revert-non-file-buffers nil)

;; delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; setup ess for R
(require 'poly-R)
(require 'poly-markdown)
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

;; ace-window
(global-set-key (kbd "C-x o") 'ace-window)


(global-set-key (kbd "C-x r e") 'er/expand-region)

;;
;; ccrypt integration
;;
(require 'ps-ccrypt "~/.emacs.d/private/modes/ps-ccrypt.el")

;; numbers and stuff
(global-display-line-numbers-mode)
(setq line-number-mode t)
(setq column-number-mode t)

;; predictable behaviour for guests
(delete-selection-mode 1)

;; load enabled scripts
(dolist (item (nthcdr 2 (directory-files "~/.emacs.d/private/scripts-enabled/" t)))
  (load-file item))

;; KEYBINDINGS

;; Yank keymap
(setq flooose-yank-keymap (make-sparse-keymap "yank**"))
(define-key flooose-yank-keymap "l" (lambda () (interactive)
                                      (save-excursion
                                        (back-to-indentation)
                                        (set-mark-command nil)
                                        (move-end-of-line nil)
                                        (kill-ring-save 'doesnt-matter-because 'of-next-argument t)
                                        )))
(global-set-key (kbd "C-c w") flooose-yank-keymap)

;; Navigation keymap
(setq flooose-navigation-keymap (make-sparse-keymap "navigate**"))
(global-set-key (kbd "C-c n") flooose-navigation-keymap)
(define-key flooose-navigation-keymap "a" 'back-to-indentation)

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

;; We always want to indent 2
(setq typescript-indent-level 2)
(setq js2-basic-offset 2)
(setq js-indent-level 2)
(setq js3-indent-level 2)

;; tide typescript ide
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; format options
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

;; web-mode
(require 'web-mode)
;; see http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html for help
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode)) ;; enables jsx for all js files, should hurt anything, but in case it does, simply remove the '?' :)
(setq flycheck-global-modes '(ruby-mode coffee-mode jsx-ide js2-jsx-mode js2-mode javascript Javascript-IDE))
(require 'flycheck) ;; This shouldn't need to be required, but somehow, without
                    ;; this flycheck doesn't work
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))
;; In addition to adding an entry here for adding flycheck support for a new
;; language, the above variable `flycheck-global-modes` has to have the
;; languages major mode added to its list.
(flycheck-add-mode 'javascript-eslint 'js2-mode)
(flycheck-add-mode 'javascript-eslint 'Javascript-IDE)
(flycheck-add-mode 'javascript-eslint 'js2-jsx-mode)
(flycheck-add-mode 'coffee-coffeelint 'coffee-mode)
(flycheck-add-mode 'ruby-rubocop 'ruby-mode)
(global-flycheck-mode)

;; This should be the job of the linter and flycheck
(setq js2-strict-missing-semi-warning nil)
(setq js2-global-externs '("__line"))

(add-hook 'web-mode-hook
          (lambda ()
            (tern-mode t)
            (if (string-equal "jsx" (file-name-extension buffer-file-name))
              (web-mode-set-content-type "jsx"))))

; tsx
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (progn
                (web-mode-set-content-type "tsx")
                (setup-tide-mode)))))

;;
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

(global-company-mode t)
(require 'eclim)
(setq eclimd-autostart t)

(add-hook 'java-mode-hook (lambda ()
                            (gradle-mode t)
                            (global-eclim-mode)
                            (custom-set-variables
                             '(eclim-eclipse-dirs '("~/.eclipse/"))
                             '(eclim-executable "/usr/lib/eclipse/eclim")
                             '(eclimd-executable "/usr/lib/eclipse/eclimd")
                             )
                            (company-emacs-eclim)
                            (setq help-at-pt-display-when-idle t)
                            (setq help-at-pt-timer-delay 0.1)
                            (help-at-pt-set-timer)
                            (company-emacs-eclim-setup)
                            (setq company-emacs-eclim-ignore-case t)
                            ))

(add-hook 'kotlin-mode-hook (lambda ()
                            (gradle-mode t)
                            (global-eclim-mode)
                            (custom-set-variables
                             '(eclim-eclipse-dirs '("~/.eclipse/"))
                             '(eclim-executable "~/.eclipse/org.eclipse.platform_4.6.3_155965261_linux_gtk_x86_64/eclim"))
                            (company-emacs-eclim)
                            (setq help-at-pt-display-when-idle t)
                            (setq help-at-pt-timer-delay 0.1)
                            (help-at-pt-set-timer)
                            (company-emacs-eclim-setup)
                            (setq company-emacs-eclim-ignore-case t)
                            ))


(setq projectile-globally-ignored-directories (add-to-list 'projectile-globally-ignored-directories "node_modules"))

(setenv "PATH" (concat (getenv "PATH") ":/usr/share/msbuild"))
(setq omnisharp-server-executable-path "/opt/omnisharp-roslyn/OmniSharp.exe")
(add-hook 'omnisharp-mode-hook (lambda ()
                                 (interactive)
                                 (setq omnisharp-server-executable-path "/opt/omnisharp-roslyn/OmniSharp.exe")
                                 (if (equal nil omnisharp--server-info)
                                     (omnisharp-start-omnisharp-server default-directory))
                                 (flycheck-mode)
                                 ))

(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-:") 'mc/mark-all-like-this)

(require 'rspec-mode)
(set-variable 'rspec-use-docker-when-possible t)
;;(set-variable 'rspec-docker-command "docker-compose -f docker-compose.dev.yml exec")
(set-variable 'rspec-docker-command "docker-compose -f docker-compose.dev.yml exec -e TEST_DEBUG=full")
(set-variable 'rspec-docker-container "rails")
(set-variable 'rspec-docker-cwd "")

;; (global-hl-line-mode 1) ; This is redundant, as it is a spacemacs default.
;; (set-face-background 'highlight "#222")
;; (set-face-foreground 'highlight nil)
;; (set-face-underline-p 'highlight t)

;; (add-hook 'term-mode-hook (lambda ()
;;                             (make-variable-buffer-local 'global-hl-line-mode)
;;                             (global-hl-line-mode)))
(yaml-imenu-enable)

;; disable adding`# coding: utf-8' to the tops of ruby files
(setq ruby-insert-encoding-magic-comment nil)
(setq ruby-deep-arglist nil)
(setq ruby-deep-indent-paren nil)

(setq require-final-newline t)

(setq set-mark-command-repeat-pop t)
(setq transient-mark-mode nil)
(global-subword-mode t)
