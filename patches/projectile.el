(defun projectile-find-file-other-window (arg)
  "Jump to a project's file in other window.

With a prefix ARG invalidates the cache first."
  (interactive "P")
  (when arg
    (projectile-invalidate-cache nil))
  (let ((file (projectile-completing-read "Find other window file: "
                                          (projectile-current-project-files))))
    (find-file-other-window (expand-file-name file (projectile-project-root)))
    (run-hooks 'projectile-find-file-hook)))

(defun projectile-find-file-other-frame (arg)
  "Jump to a project's file in other frame.

With a prefix ARG invalidates the cache first."
  (interactive "P")
  (when arg
    (projectile-invalidate-cache nil))
  (let ((file (projectile-completing-read "Find other frame file: "
                                          (projectile-current-project-files))))
    (find-file-other-frame (expand-file-name file (projectile-project-root)))
    (run-hooks 'projectile-find-file-hook)))
