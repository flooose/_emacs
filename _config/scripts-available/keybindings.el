(global-set-key (kbd "C-S-j") 'comment-indent-new-line)

;; window navigatioin
(global-set-key (kbd "C-x M-j") 'windmove-down)
(global-set-key (kbd "C-x M-k") 'windmove-up)
(global-set-key (kbd "C-x M-h") 'windmove-left)
(global-set-key (kbd "C-x M-l") 'windmove-right)

;; make brackets easier
(global-set-key (kbd "M-[") 'insert-pair)
(global-set-key (kbd "M-{") 'insert-pair)
(global-set-key (kbd "M-\"") 'insert-pair)

;; taken from http://emacsredux.com/blog/2013/05/30/joining-lines/
(defun top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))
(global-set-key (kbd "C-^") 'top-join-line)

(global-set-key (kbd "C-M-g") 'vc-git-grep)

;; String manipulation
(global-set-key (kbd "C-'") 'toggle-quotes)

;; Zap-to-char backwards
(global-set-key (kbd "M-Z") (lambda ()
                                (interactive (zap-to-char -1 (read-char "Zap back to char: " t)))))

;; Dot-mode
(autoload 'dot-mode "dot-mode" nil t) ; vi `.' command emulation
(global-set-key [(control ?.)] (lambda () (interactive) (dot-mode 1)
                                 (message "Dot mode activated.")))
(require 'dot-mode)
(add-hook 'find-file-hooks 'dot-mode-on)

;; rgrep
(global-set-key (kbd "C-, g") 'rgrep)
(global-set-key (kbd "C-, w") (lambda () (interactive)
                                  (save-excursion
                                    (back-to-indentation)
                                    (set-mark-command nil)
                                    (move-end-of-line nil)
                                    (kill-ring-save 'doesnt-matter-because 'of-next-argument t)
                                    )))
(global-set-key (kbd "C-<tab>") 'auto-complete)

;; Don't accidentally close emacs
(global-set-key (kbd "C-x C-c") (lambda () (interactive)
                                  (message "Not quitting emacs. Use C-x C-q instead.")))
(global-set-key (kbd "C-x C-q") 'save-buffers-kill-terminal)
