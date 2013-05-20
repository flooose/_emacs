;; No splash screen please... jeez
(setq inhibit-startup-screen t)

;;;; package.el
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
