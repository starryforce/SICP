#lang simply-scheme

(require rackunit)

(define (shorter? a b)
  (<= (count a) (count b)) )

; [Word Word -> Boolean] -> [Sentence -> Boolean]
(define (order-checker pred)
  ; [Word Word -> Boolean] Sentence -> Boolean
  (define (in-order? sent)
    (cond ((empty? (bf sent)) #t)
          (else (and (pred (first sent) (first (bf sent)))
                     (in-order? (bf sent))))))
  in-order?)


(define length-ordered? (order-checker shorter?))

(check-equal? (length-ordered? '(i saw them standing together)) #t)
(check-equal? (length-ordered? '(i saw her standing there)) #f)
(check-equal? ((order-checker <) '(2 3 5 5 8 13)) #f)
(check-equal? ((order-checker <=) '(2 3 5 5 8 13)) #t)
(check-equal? ((order-checker >) '(23 14 7 5 2)) #t)