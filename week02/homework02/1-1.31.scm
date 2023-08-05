#lang simply-scheme

(require rackunit)

; [Number -> Number] Number [Number -> Number] Number -> Number
; calc the product of the result of a to b with term
(define (product term a next b)
  (cond ((> a b) 1)
        (else (* (term a)
                 (product term (next a) next b)))))

(check-equal? (product (lambda (x) (* x x)) 3 (lambda (x) (+ x 1)) 6) 129600)

; Number Number -> Number
; calc the factorial from a to b
(define (factorial a b)
  (product (lambda (x) x) a (lambda (x) (+ x 1)) b))

(check-equal? (factorial 1 5) 120)

; Number -> Number
; calc the value of pi
(define (calc-pi n)
  (/ (product (lambda (x) (if (odd? x) (+ x 1) (+ x 2))) 1 (lambda (x) (+ x 1)) n)
     (product (lambda (x) (if (odd? x) (+ x 2) (+ x 1))) 1 (lambda (x) (+ x 1)) n)))

(check-equal? (calc-pi 1) (/ 2 3))
(check-equal? (calc-pi 2) (/ (* 2 4) (* 3 3)))
(check-equal? (calc-pi 3) (/ (* 2 4 4) (* 3 3 5)))


