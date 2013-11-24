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
