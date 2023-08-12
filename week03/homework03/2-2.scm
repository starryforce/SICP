#lang simply-scheme

(require rackunit)

; Number -> Number
; the sum of factors less than n 
(define (sum-of-factors n0)
  ; Number Number -> Number
  ; accumulator a represent all factors from (+ n 1) to n0
  (define (s-iter n max a)
    (cond ((> n max) a)
          ((= (remainder n0 n) 0)
           (let ((quotient (/ n0 n)))
             (s-iter (+ n 1)
                     (- quotient 1)
                     (+ a n (if (and (> quotient n)
                                     (not (= quotient n0)))
                                quotient 0)))))
          (else (s-iter (+ n 1) max a))))
  (s-iter 1 (- n0 1) 0))

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
