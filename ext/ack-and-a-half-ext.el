(autoload 'ack-and-a-half-run "ack-and-a-half" nil t)
(defun ack-and-a-half-ack-here (directory pattern)
  (interactive "Ddirectory: \nMpattern: ")
  (ack-and-a-half-run directory ack-and-a-half-regexp-search pattern))