#lang simply-scheme

(require rackunit)


; construct target, the largest element is max
; consist of two kinds:
; 1. all the way that do not use max, (cc target (- max 1))
; 2. all the way that use max, the same as
;    use a max, and the others construct by all elements

(define (cc target max)
  (cond ((= target 0) 1)
        ((or (< target 0) (= max 0)) 0)
        (else (+ (cc target (min (- max 1) target))
                 (cc (- target max) max)
                 ))))

; Number -> Number
; computes the number of partitions of its
; nonnegative integer argument n
(define (number-of-partitions n)
  (cc n n))

(check-equal? (number-of-partitions 0) 1)
(check-equal? (number-of-partitions 5) 7)
(check-equal? (number-of-partitions 20) 627)

