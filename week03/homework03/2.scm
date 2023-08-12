#lang simply-scheme

(require rackunit)

; Number -> Number
; the sum of factors less than n 
(define (sum-of-factors n0)
  ; Number Number -> Number
  ; accumulator a represent all factors from (+ n 1) to n0
  (define (s-iter n a)
    (cond ((< n 1) a)
          ((= (remainder n0 n) 0) (s-iter (- n 1) (+ a n)))
          (else (s-iter (- n 1) a))))
  (s-iter (- n0 1) 0))

(check-equal? (sum-of-factors 1) 0)
(check-equal? (sum-of-factors 5) 1)
(check-equal? (sum-of-factors 6) 6)
(check-equal? (sum-of-factors 28) 28)

; Number -> Number
; find the perfect number equal to or larger than n
(define (next-perf n)
  (cond ((= (sum-of-factors n) n) n)
        (else (next-perf (+ n 1)))))


(check-equal? (next-perf 1) 6)
(check-equal? (next-perf 10) 28)
