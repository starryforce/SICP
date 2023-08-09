#lang simply-scheme

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) 
             (= kinds-of-coins 0)) 
         0)
        (else 
         (+ (cc amount (- kinds-of-coins 1))
            (cc (- amount (first-denomination 
                           kinds-of-coins))
                kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

#| change order, start from 1 when use 5 kinds
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 50)
        ((= kinds-of-coins 2) 25)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 5)
        ((= kinds-of-coins 5) 1)))
|#

(cc 5 2)
;
(+ (cc 5 1)
   (cc 0 2))
;
(+ (+ (cc 5 0)
      (cc 4 1))
   1)
;
(+ (+ 0
      (+ (cc 4 0)
         (cc 3 1)))
   1)
;
(+ (+ 0
      (+ 0
         (+ (cc 3 0)
            (cc 2 1))))
   1)
;
(+ (+ 0
      (+ 0
         (+ 0
            (+ (cc 2 0)
               (cc 1 1)))))
   1)
;
(+ (+ 0
      (+ 0
         (+ 0
            (+ 0
               (+ (cc 1 0)
                  (cc 0 1))))))
   1)
;
(+ (+ 0
      (+ 0
         (+ 0
            (+ 0
               (+ 0
                  1)))))
   1)
; 13 times