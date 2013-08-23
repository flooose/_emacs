(setq eshell-prompt-function
  (lambda nil
    (concat
     (eshell/pwd)
     " $ ")))
