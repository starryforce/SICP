#lang simply-scheme

; [Number -> Number] [Number -> Number] Number -> Number
(define (cont-frac-i n d k0)
  ; [Number -> Number] [Number -> Number] Number Number -> Number
  ; calculate k-term finite continued fraction
  ; accumulator a is term build from k to k0
  (define (cont-frac-iter n d k a)
    (cond ((= k 0) a)
          (else (cont-frac-iter n
                                d
                                (- k 1)
                                (/ (n k)
                                   (+ (d k) a))))))
  (cont-frac-iter n d k0 0))

; number sequense representation
; 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ....
(define (series i)
  (let ((r (remainder i 3)))
    (cond ((= r 1) 1)
          ((= r 0) 1)
          (else (* (+ (floor (/ i 3.0)) 1) 2)))))

(cont-frac-i (lambda (i) 1.0)
             series
             20)
; result is 0.7182818284590452

; e = 2.718281828459