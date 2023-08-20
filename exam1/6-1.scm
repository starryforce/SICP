#lang simply-scheme

(require rackunit)

(define (shorter? a b)
  (<= (count a) (count b)) )

; [Word Word -> Boolean] Sentence -> Boolean
(define (in-order? pred sent)
  (cond ((empty? (bf sent)) #t)
        (else (and (pred (first sent) (first (bf sent)))
                   (in-order? pred (bf sent))))))

(check-equal?  (in-order? shorter? '(i saw them standing together)) #t)
(check-equal?  (in-order? shorter? '(i saw her standing there)) #f)
(check-equal?  (in-order? < '(2 3 5 5 8 13)) #f)
(check-equal?  (in-order? <= '(2 3 5 5 8 13)) #t)
(check-equal? (in-order? > '(23 14 7 5 2)) #t)