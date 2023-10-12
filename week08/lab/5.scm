#lang simply-scheme

(require rackunit)

(define (make-adder n)
  (lambda (x) (+ x n)))

(make-adder 3)
; procedure


(check-equal? ((make-adder 3) 5) 8)

(define (f x) (make-adder 3))

(f 5)
; procedure

(define g (make-adder 3))

(check-equal? (g 5) 8)

(define (make-funny-adder n)
  (lambda (x)
    (if (equal? x 'new)
        (set! n (+ n 1))
        (+ x n))))

(define h (make-funny-adder 3))

(define j (make-funny-adder 7))

(check-equal? (h 5) 8)
(check-equal? (h 5) 8)
(h 'new)
; no output
(check-equal? (h 5) 9)
(check-equal? (j 5) 12)

(check-equal? (let ((a 3))
                (+ 5 a))
              8)

(let ((a 3))
                (lambda (x) (+ x a)))
; #procedure

(check-equal? ((let ((a 3))
                 (lambda (x) (+ x a)))
               5)
              8)

(check-equal? ((lambda (x)
                 (let ((a 3))
                   (+ x a)))
               5) 8)

(define k
  (let ((a 3))
    (lambda (x) (+ x a))))

(check-equal? (k 5) 8)

(define m
  (lambda (x)
    (let ((a 3))
      (+ x a))))

(check-equal? (m 5) 8)

(define p
  (let ((a 3))
    (lambda (x)
      (if (equal? x 'new)
          (set! a (+ a 1))
          (+ x a)))))

(check-equal? (p 5) 8)
(check-equal? (p 5) 8)
(p 'new)
; no output
(check-equal? (p 5) 9)

(define r
  (lambda (x)
    (let ((a 3))
      (if (equal? x 'new)
          (set! a (+ a 1))
          (+ x a)))))

(check-equal? (r 5) 8)
(check-equal? (r 5) 8)
(r 'new)
; no output
(check-equal? (r 5) 8)

(define s
  (let ((a 3))
    (lambda (msg)
      (cond ((equal? msg 'new)
             (lambda ()
               (set! a (+ a 1))))
            ((equal? msg 'add)
             (lambda (x) (+ x a)))
            (else (error "huh?"))))))

(s 'add)
; procedure

; (s 'add 5)
; error

(check-equal? ((s 'add) 5) 8)

(s 'new)
; procedure

(check-equal? ((s 'add) 5) 8)

((s 'new))
; no output

(check-equal? ((s 'add) 5) 9)

(define (ask obj msg . args)
  (apply (obj msg) args))

(check-equal? (ask s 'add 5) 9)

(ask s 'new)
; no output

(check-equal? (ask s 'add 5) 10)

(define x 5)

(check-equal? (let ((x 10)
                    (f (lambda (y) (+ x y))))
                (f 7))
              12)

; (define x 5)
; error

              