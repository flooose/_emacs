(defun mercury-database-connect ()
  "Establish a connection to the mercury database"
  (interactive)
  (sql-postgres)
  (rename-buffer "*postgres*")
  (switch-to-buffer-other-window "*SQL*"))
