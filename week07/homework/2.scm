#lang simply-scheme

(require "obj.rkt")

(define-class (coke-machine size price)
  (instance-vars (count 0) (stash 0))
  (method (fill n)
          (if (> (+ count n) size)
              (error "no enough space")
              (set! count (+ count n))))
  (method (deposit v)
          (set! stash (+ stash v))
          stash)
  (method (coke)
          (cond ((zero? count) (error "Machine empty"))
                ((< stash price) (error "Not enough money"))
                (else (let ((change (- stash price)))
                        (set! count (- count 1))
                        (set! stash 0)
                        change)))))


(define my-machine (instantiate coke-machine 80 70))

(ask my-machine 'fill 60)
(ask my-machine 'deposit 25)
(ask my-machine 'coke)
; NOT ENOUGH MONEY
(ask my-machine 'deposit 25) ;; Now there's 50 cents in there.
(ask my-machine 'deposit 25) ;; Now there's 75 cents.
(ask my-machine 'coke)
