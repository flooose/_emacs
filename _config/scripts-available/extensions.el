(defun flooose-scan-line-for-string-forward ()
  (save-excursion
    (if (in-string-p)
        (while (in-string-p)
          (forward-char)))
    (while (not (or (in-string-p) (eolp)))
      (forward-char))
    (if (eolp)
        nil
      (point))))

(defun flooose-scan-line-for-string-backward ()
  (save-excursion
    (if (in-string-p)
        (while (in-string-p)
          (backward-char)))
    (while (not (or (in-string-p) (bolp)))
      (backward-char))
    (if (eolp)
        nil
      (point))))

(defun flooose-next-string-in-line (arg)
  (interactive "p")
  (if (> arg 1)
      (flooose-next-string-in-line (- arg 1)))
  (let ((point-in-next-string (flooose-scan-line-for-string-forward)))
    (if point-in-next-string
        (goto-char point-in-next-string))))

(defun flooose-previous-string-in-line (arg)
  (interactive "p")
  (if (> arg 1)
      (flooose-previous-string-in-line (- arg 1)))
  (let ((point-in-previous-string (flooose-scan-line-for-string-backward)))
    (if point-in-previous-string
        (goto-char point-in-previous-string))))

(global-set-key (kbd "C-, j") 'flooose-next-string-in-line)
(global-set-key (kbd "C-, J") 'flooose-previous-string-in-line)

(defun flooose-backward-up-list (arg)
  (interactive "p")
  (if (in-string-p)
      (progn
        (while (in-string-p)
          (backward-char))
        (if (> arg 1)
            (backward-up-list (- arg 1))))
    (backward-up-list arg)))
(global-set-key (kbd "C-M-u") 'flooose-backward-up-list)


(defun search-and-calculate-for (fun)
  "searches for occurence of next integer and performs given action on it"
  (save-excursion
    (search-forward-regexp "[[:digit:]]" (point-at-eol))
    (let ((number (char-before)))
      (deactivate-mark)
      (delete-backward-char 1)
      (funcall fun number))
    ))

(defun increment-next-number ()
  "increments the next integer in the current line"
  (interactive)
  (search-and-calculate-for
   (lambda (number)
     (insert-char (+ number 1)))
   ))

(defun decrement-next-number ()
  "decrements the next integer in the current line"
  (interactive)
  (search-and-calculate-for
   (lambda (number)
     (insert-char (- number 1)))
   ))

(global-set-key (kbd "C-+") 'increment-next-number)
(global-set-key (kbd "C-M-+") 'decrement-next-number)


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
  (previous-line)
  (flooose-open-line))
(global-set-key (kbd "C-S-<return>") 'flooose-open-line-above)
(global-set-key (kbd "C-S-o") 'flooose-open-line-above)

(define-key global-map
  [menu-bar file flupp]
  '("Fuzzy-find File" . projectile-find-file))
