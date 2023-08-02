#lang simply-scheme

(define 1+ add1)

(define (t f)
  (lambda (x) (f (f (f x)))))

; ((t 1+) 0)
; ((lambda (x) (f (f (f x)))) 0)
; ((lambda (x) (1+ (1+ (1+ x)))) 0)
; (1+ (1+ (1+ 0)))
; 3

; ((t (t 1+)) 0)
; ((t (lambda (x) (1+ (1+ (1+ x))))) 0)
; ((t 3+) 0)
; (9+ 0)
; 9 


; (((t t) 1+) 0)
; (((lambda (x) (t (t (t x)))) 1+) 0)
; (t (t (t 1+)))
; (t (t 3+))
; (t 9+)
; (27+)
; (27+ 0)
; 27