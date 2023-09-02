#lang simply-scheme

; (every - (keep number? ’(the 1 after 909)))
; '(-1 -909)

; ((lambda (a b) ((if (< b a) + *) b a)) 4 6)
; ((if (< 6 4) + *) 6 4))
; ((if #f + *) 6 4))
; (* 6 4)
; 24

; (word (first ’(cat)) (butlast ’dog))
; (word 'cat 'do)
; 'catdo


; (cons (list 1 2) (cons 3 4))
; '((1 2) 3 4) -> (cons (list 1 2) (cons 3 (cons 4 '())))
; the correct answer is '((1 2) .

; (let ((p (list 4 5)))
;   (cons (cdr p) (cddr p)) )
; (cons (cdr (list 4 5)) (cddr (list 4 5)))
; (cons (list 5) '())
; '((5))


; (cadadr ’((a (b) c) (d (e) f) (g (h) i))
; ’(e)