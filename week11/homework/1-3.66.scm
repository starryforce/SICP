#lang sicp

(#%require srfi/41)
(#%require "util.scm")

(define (add-streams s1 s2) 
  (stream-map + s1 s2))

(define ones (stream-cons 1 ones))

(define integers 
  (stream-cons 1 (add-streams ones integers)))

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (stream-cons 
       (stream-car s1)
       (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (stream-cons
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) 
                  (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

(define ex (pairs integers integers))

; (ss (stream-map car ex) 20)
; (ss (stream-map cadr ex) 20)

#|

1 1
1 2
2 2
1 3
2 3
1 4
3 3
1 5
2 4
1 6
3 4
1 7
2 5
1 8
4 4
1 9
2 6
1 10
3 5
1 11

|#