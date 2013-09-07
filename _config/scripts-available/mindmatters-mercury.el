(defun mercury-database-connect ()
  "Establish a connection to the mercury database"
  (interactive)
  (switch-to-buffer "*SQL SCRATCH*")
  (sql-mode)
  (sql-set-product 'postgres)
  (goto-char (point-min))
  (insert "-- C-c C-b to eval SQL\n")

  (sql-postgres "*postgres*")
  (switch-to-buffer "*SQL SCRATCH*")
  (rename-buffer "*SQL*"))
