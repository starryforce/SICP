#lang simply-scheme

; [Number -> Number] [Number -> Number] Number -> Number
; calc the finite continued fraction k-term finite continued fraction 
(define (cont-frac n d k)
  (cond ((= k 0) 0)
        (else (/ (n k)
                 (+ (d k)
                    (cont-frac n d (- k 1)))))))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           11)

; accurate to 4 decimal places? 0.6180
; 10 terms -> 0.6179775280898876
; 11 terms -> 0.6180555555555556

; [Number -> Number] [Number -> Number] Number -> Number
(define (cont-frac-i n d k0)
  ; [Number -> Number] [Number -> Number] Number Number -> Number
  ; calculate k-term finite continued fraction
  ; accumulator a is term build from k to k0
  (define (cont-frac-iter k a)
    (cond ((= k 0) a)
          (else (cont-frac-iter (- k 1)
                                (/ (n k)
                                   (+ (d k) a))))))
  (cont-frac-iter k0 0))

(cont-frac-i (lambda (i) 1.0)
             (lambda (i) 1.0)
             11)