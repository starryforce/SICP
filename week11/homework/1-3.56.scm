#lang sicp

(#%require srfi/41)

(define (scale-stream stream factor)
  (stream-map
   (lambda (x) (* x factor))
   stream))

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< s1car s2car)
                  (stream-cons 
                   s1car 
                   (merge (stream-cdr s1) 
                          s2)))
                 ((> s1car s2car)
                  (stream-cons 
                   s2car 
                   (merge s1 
                          (stream-cdr s2))))
                 (else
                  (stream-cons 
                   s1car
                   (merge 
                    (stream-cdr s1)
                    (stream-cdr s2)))))))))

(define S (stream-cons 1 (merge  (scale-stream S 2) (merge (scale-stream S 3) (scale-stream S 5)))))

(stream-ref S 0)
(stream-ref S 1)
(stream-ref S 2)
(stream-ref S 3)
(stream-ref S 4)
(stream-ref S 5)
(stream-ref S 6)
(stream-ref S 7)
(stream-ref S 8)
(stream-ref S 9)
(stream-ref S 10)
(stream-ref S 11)
(stream-ref S 12)