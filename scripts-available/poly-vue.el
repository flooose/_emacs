(require 'polymode)
(define-hostmode poly-vue-hostmode
  :mode 'html-mode)

(define-innermode poly-vue-ts-metadata-innermode
  :mode 'typescript-mode
  :head-matcher ".*<script[ \t]*lang=\"ts\".*"
  :tail-matcher "</script>"
  :head-mode 'host
  :tail-mode 'host)

(define-innermode poly-vue-scss-metadata-innermode
  :mode 'scss-mode
  :head-matcher ".*<style[ \t]*lang=\"scss\".*"
  :tail-matcher "</style>"
  :head-mode 'host
  :tail-mode 'host)

(define-polymode poly-vue-mode
  :hostmode 'poly-vue-hostmode
  :innermodes '(poly-vue-ts-metadata-innermode
		poly-vue-scss-metadata-innermode
                ))

;; "\\| is needed to match script OR style
;;(string-match-p "script\\|style" "style")
