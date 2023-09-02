#lang simply-scheme

(require rackunit)

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(check-equal? (accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
              '(22 26 30))

(define ex-v1 '(1 3 5 7))
(define ex-v2 '(2 4 6 8))
(define ex-m '((1 2 3 4) (4 5 6 6) (6 7 8 9)))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(dot-product ex-v1 ex-v2)


(define (matrix-*-vector m v)
  (map (lambda (r) (dot-product v r)) m))

(check-equal? (matrix-*-vector ex-m ex-v1)
              '(50 91 130))
(check-equal? (matrix-*-vector '((1 2) (3 4) (5 6)) '(7 8))
              '(23 53 83))


(define (transpose mat)
  (accumulate-n cons '() mat))

(check-equal? (transpose ex-m)
              '((1 4 6) (2 5 7) (3 6 8) (4 6 9)))


(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m)))

(check-equal? (matrix-*-matrix '((1 2 3) (4 5 6)) '((7 8) (9 10) (11 12)))
              '((58 64) (139 154)))