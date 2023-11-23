#lang simply-scheme
#|
(define x 10)
(parallel-execute 
 (lambda () (set! x (* x x)))
 (lambda () (set! x (* x x x))))

x1 -> x2 100 -> 1000000
x2 -> x1 1000 -> 1000000

before x11
x11:1000 x12:1000 1000000

before x12
x11:10 x12:1000 10000

after x12
x11:10 x12:10 100


before x21
x21:100 x22:100 x23:100 1000000

before x22
x21:10 x22:100 x23:100 100000

before x23
x21:10 x22:10 x23:100 10000

after x23
x21:10 x22:10 x23:10 1000
|#

#|
(define x 10)
(define s (make-serializer))
(parallel-execute 
 (s (lambda () (set! x (* x x))))
 (s (lambda () (set! x (* x x x)))))

x1 -> x2 100 -> 1000000
x2 -> x1 1000 -> 1000000
|#