#lang simply-scheme

(require rackunit)

; Number Number -> #f
(define (same-parity? a b)
  (= (remainder a 2) (remainder b 2)))

(check-equal? (same-parity? 1 3) #t)
(check-equal? (same-parity? 2 4) #t)
(check-equal? (same-parity? 1 2) #f)

; [List . Number] -> [List-of Number]
(define (same-parity first . rest)
  (define (fn l)
    (cond ((null? l) '())
          ((same-parity? first (car l)) (cons (car l) (fn (cdr l))))
          (else (fn (cdr l)))))
  (cons first (fn rest)))

(check-equal? (same-parity 1 2 3 4 5 6 7) '(1 3 5 7))
(check-equal? (same-parity 2 3 4 5 6 7) '(2 4 6))

