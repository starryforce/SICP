#lang simply-scheme

(require rackunit)

; [Number -> Boolean] [Number -> Number] -> [Number -> Number]
(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        ((iterative-improve good-enough? improve) (improve guess)))))

(define (sqrt-common x)
  (define (square x) (* x x))

  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))

  (define (improve guess x)
    (average guess (/ x guess)))

  (define (average x y) 
    (/ (+ x y) 2))

  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

  (define (sqrt x)
    (sqrt-iter 1.0 x))
  ((iterative-improve
    (lambda (guess) (good-enough? guess x))
    (lambda (guess) (improve guess x)))
   1.0))
 
(check-within (sqrt-common 9) 3 0.01)

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (fixed-point-common f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  ((iterative-improve
    (lambda (guess) (close-enough? guess (f guess)))
    f)
   first-guess))

(check-within (fixed-point-common cos 1.0) .7390822985224023 0.01)
    