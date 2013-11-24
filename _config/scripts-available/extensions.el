(defun increment-next-number ()
  "increments the next integer in the current line"
  (interactive)
  (save-excursion
    (search-forward-regexp "[[:digit:]]" (point-at-eol))
    (let ((number (char-before)))
      (deactivate-mark)
      (delete-backward-char 1)
      (insert (char-to-string (+ 1 number)))))

    )

(defun decrement-next-number ()
  "decrements the next integer in the current line"
  (interactive)
  (save-excursion
    (search-forward-regexp "[[:digit:]]" (point-at-eol))
    (let ((number (char-before)))
      (deactivate-mark)
      (delete-backward-char 1)
      (insert-char (- number 1)))
    ))

(global-set-key (kbd "C-+") 'increment-next-number)
(global-set-key (kbd "C-M-+") 'decrement-next-number)
