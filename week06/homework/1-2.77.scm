#lang simply-scheme

(define z '(complex rectangular 3 . 4))

(magnitude z)
(apply-generic 'magnitude z)
; within the first apply to apply-generic
; search for related procedure
; (get 'magnitude '(complex))

; (apply proc (map contents args))
; remove the outer symbol
; the new application is (apply magnitude '((cons 'rectangular  (cons 3 4))))

(magnitude '(rectangular 3 . 4))
(apply-generic 'magnitude '(rectangular 3 . 4))
; (get 'magnitude '(rectangular))

; inner
(apply magnitude '((cons 3 4)))
(magnitude (cons 3 4))