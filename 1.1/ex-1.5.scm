#lang sicp

(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

(test 0 (p))

;; 完全展开然后计算被称作正常序 normal-order evaluatin

(if (= 0 0) 0 (p))
(if #t 0 (p))
0

;; 相对的，求值参数然后应用被称为应用序 applicative-order evaluation

(test 0 (p))