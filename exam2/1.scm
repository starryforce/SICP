#lang simply-scheme

; 1.
(list (cons 2 3) 4)
'((2 . 3) 4)

; 2.
(append (cons '(a) '(b)) '(c))
'((a) b c)

; 3.
(cdadar '((e (f) g) h))

(cdadar '((e (f) g) h))
(cdadr '(e (f) g))
(cdar '((f) g))
(cdr '(f))
'()