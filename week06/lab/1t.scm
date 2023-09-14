#lang simply-scheme

; constant?
; - 3.1415  3.1415  3.1415
; - #t  #t  #t
; - "hello"  "hello"  "hello"
; - cannot type in procedure value

; symbol?
; - sqrt -> 'sqrt -> #procedure
; - a -> 'a -> error

; quote-exp?
; - (quote s) -> '(quote s) -> 's

; if-exp?
; - (if #t 1 2) -> '(if #t 1 2) -> 1

; lambda-exp?
; - (lambda (x y) (+ x y)) -> '(lambda (x y) (+ x y)) -> '(lambda (x y) (+ x y))

; define-exp?
; - (define ncy (lambda (x) (* x y))) -> '(define ncy (lambda (x) (* x y)))
;   (eval (list 'define ncy (maybe-quote (lambda (x) (* x y)))))
; - (define ncy 329) -> '(define ncy 329)
;   (eval (list 'define ncy (maybe-quote (eval-1 (caddr exp)))))
; - (define ncy +) -> '(define ncy +)
;   (eval (list 'define ncy (maybe-quote +)))
; - else??

; pair?
; - (+ 1 2) -> '(+ 1 2)
;   (apply-1 + '(1 2))

; - ((lambda (x y) (+ x y)) 2 4) -> '((lambda (x y) (+ x y)) 2 4)

;   (apply-1 (lambda (x y) (+ x y)) '(2 4))
;   (eval-1 (substitute '(+ x y) '(x y) '(2 4) '()))

; - (apply-1 (lambda (x y) 20) '(2 4))
;   (eval-1 (substitute 20 '(x y) '(2 4) '()))

; - (apply-1 (lambda (x y) x) '(2 4))
;   (eval-1 (substitute 'x '(x y) '(2 4) '()))

; - (apply-1 (lambda (x y)
;               ((lambda (x) (+ x y))
;                (* x y)))
;             '(5 8))
;   (list 'lambda
;         (x y)
;         (substitute ((lambda (x) (+ x y)) (* x y)) '(x y) '(5 8) '(x y)))
;   (substitute ((lambda (x) (+ x y)) (* x y)) '(x y) '(5 8) '(x y)))
;   (list 'lambda '(x) 