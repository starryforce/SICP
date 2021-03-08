#lang sicp

(define (iff <p> <c> <a>) (if <p> <c> <a>))

(define (tryif a) (if (= a 0) 1 (/ 1 0)))

(define (tryiff a) (iff (= a 0) 1 (/ 1 0)))

(tryiff 0)
