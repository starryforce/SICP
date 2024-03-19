#lang simply-scheme

(require "tables.scm")

; in this sample ,it's right, but if use his memoize twice.
; it will probably get the wrong answer.

; every function using his memoize will share a single table.

(define memoize ;; this line changed (no parens or f)
  (let ((table (make-table)))
    (lambda (f) ;; this line added
      (lambda (x)
        (let ((previous-result (lookup x table)))
          (or previous-result
              (let ((result (f x)))
                (insert! x result table)
                result)))))))

(define (fib x)
  (if (< x 2)
      x
      (+ (fib (- x 1))
         (fib (- x 2)))))
; (fib 10) -> 55

(define memo-fib
  (memoize (lambda (x)
             (if (< x 2)
                 x
                 (+ (memo-fib (- x 1))
                    (memo-fib (- x 2)))))))

(define memo-x2
  (memoize (lambda (x) (* 2 x))))

; (memo-x2 5) -> 10
; (memo-fib 10) -> 95