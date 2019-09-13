(dir-locals-set-class-variables 'mercury-project-dir
				'((nil . (
					  (mercury-merkur . "abc123")
					  ;; (elm-interactive-command . ("elm" "repl"))
					  ;; (elm-reactor-command . ("elm" "reactor"))
					  ;; (elm-reactor-arguments . ("--port" "8000"))
					  ;; (elm-compile-command . ("elm" "make"))
					  ;; (elm-compile-arguments . ("--output=elm.js" "--debug"))
					  ;; (elm-package-command . ("elm" "package"))
					  ;; (elm-package-json . "elm.json")
					  ))))

(dir-locals-set-directory-class
 "/home/chris/Projects/mercury/" 'mercury-project-dir)
(message "%s" "loading mercury")
;; advise rspec command
(defun set-docker-command ()
    (setq docker-command
	  (let ((current-branch (shell-command-to-string "git rev-parse --abbrev-ref HEAD")))
	    (message "%s" current-branch)
	    (concat
	     " docker-compose --project-name "
	     (replace-regexp-in-string "\n" "" (replace-regexp-in-string "/" "-" current-branch))
	     " -f docker-compose.dev.yml exec -e TEST_DEBUG=full")))
    (message "%s" docker-command)
    (set-variable 'rspec-docker-command docker-command))
(add-hook 'rspec-before-verification-hook #'set-docker-command)
(set-variable 'rspec-docker-container "rails")
(set-variable 'rspec-docker-cwd "")

;; elm
(setq elm-indent-offset 2)
;; (add-to-list 'company-backends 'company-elm)
