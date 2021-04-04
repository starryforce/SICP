#lang sicp

; 迭代实现必须在函数调用的过程中保留完整的信息
; 当 n < 3 时, 结果就是 n 本身
; 因此重点在于 n >= 3 时的场景
; 根据表达式，对于特定的 n，我们需要记录 f(n-1) f(n-2) f(n-3)，同时还需要记录当前已经计算到了哪个值
; 通过 a b c 三个值来跟踪 f(n-1) f(n-2) f(n-3),
; 第四个参数可以有不同的选择，可以通过 count 记录还需要进行的次数
; 可以通过 current 记录当前计算的值对应的 n

;; 这种方式对于所有的 n 都进入迭代过程，迭代内对于 n 的判断实际上与迭代本身没有关系，当 n < 3 时，直接返回 n 本身
;; f(3)需要迭代一次，对于 n 来说，需要从初始状态迭代 n - 2 次，
(define (f1 n) 
   (define (f-i a b c count) 
     (cond ((< n 3) n) 
           ((<= count 0) a) 
           (else (f-i (+ a (* 2 b) (* 3 c)) a b (- count 1))))) 
   (f-i 2 1 0 (- n 2))) 

(define (f2 n)
  (define (f-iter a b c count)
    (cond ((<= count 0) a)
        (else (f-iter (+ a (* 2 b) (* 3 c)) a b (- count 1)))))
  (cond ((< n 3) n)
        (else (f-iter 2 1 0 (- n 2)))))

;; 本次迭代计算的值为 3 的
(define (f3 n) 
   (define (f-i a b c current) 
     (cond ((> current n) a) 
           (else (f-i (+ a (* 2 b) (* 3 c)) a b (+ current 1)))))
  (cond ((< n 3) n)
        (else (f-i 2 1 0 3))))

;; 可以少计算一次
(define (f31 n) 
   (define (f-i a b c current) 
     (cond ((= current n) (+ a (* 2 b) (* 3 c))) 
           (else (f-i (+ a (* 2 b) (* 3 c)) a b (+ current 1)))))
  (cond ((< n 3) n)
        (else (f-i 2 1 0 3))))

(f31 5)

(define (f8 n)
  (define (f-i a b c n1)
    (if (< n1 3)
        a
        (f-i (+ a (* 2 b) (* 3 c)) a b (- n1 1))))
  (if (< n 3)
      n
      (f-i 2 1 0 n)))

;; 没有处理小于 0 的场景
(define (f4 n)
  (define (iter a b c count)
    (if (= count 0)
        a
        (iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))
  (iter 0 1 2 n))


(define (f5 n) 
  (define (iter a b c count) 
    (if (= count 0)
      a 
      (iter b c (+ c (* 2 b) (* 3 a)) (- count 1)))) 
  (iter 0 1 2 n))

;; 可以处理小于 0 的场景
(define (f6 n)
  (define (fi i a b c)
    (cond ((< i 0) i)
        ((= i 0) a)
        (else (fi (- i 1) b c (+ c (* 2 b) (* 3 a))))))
  (fi n 0 1 2))



;; 只比 f5 多处理了为负值的场景
(define (f7 n)
  (define (iter a b c count)
  (cond ((< count 0) count)
        ((= count 0) a)
        (else (iter b c (+ c (* 2 b) (* 3 a)) (- count 1)))))
  (iter 0 1 2 n))


