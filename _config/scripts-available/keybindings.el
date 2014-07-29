(global-set-key (kbd "C-S-j") 'comment-indent-new-line)

;; window navigatioin
(global-set-key (kbd "C-x M-j") 'windmove-down)
(global-set-key (kbd "C-x M-k") 'windmove-up)
(global-set-key (kbd "C-x M-h") 'windmove-left)
(global-set-key (kbd "C-x M-l") 'windmove-right)

;; give speedbar forcus
;; (global-set-key (kbd "M-s") 'speedbar-get-focus)

;; taken from http://emacsredux.com/blog/2013/05/30/joining-lines/
(defun top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))
(global-set-key (kbd "C-^") 'top-join-line)

(global-set-key (kbd "C-M-g") 'vc-git-grep)
