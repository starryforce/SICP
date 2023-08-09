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
  (cond ((= kinds-of-coins 1) 5)
        ((= kinds-of-coins 2) 1)))

(cc 5 2)
;
(+ (cc 5 1)
   (cc 4 2))
;
(+ (+ (cc 5 0)
      (cc 0 1))
   (+ (cc 4 1)
      (cc 3 2)))
;
(+ (+ 0
      1)
   (+ (+ (cc 4 0)
         (cc -1 1))
      (+ (cc 3 1)
         (cc 2 2))))
;
(+ 1
   (+ (+ 0
         0)
      (+ (+ (cc 3 0)
            (cc -2 1))
         (+ (cc 2 1)
            (cc 1 2)))))
;
(+ 1
   (+ 0
      (+ (+ 0
            0)
         (+ (+ (cc 2 0)
               (cc -3 1))
            (+ (cc 1 1)
               (cc 0 2))))))
;
(+ 1
   (+ 0
      (+ 0
         (+ (+ 0
               0)
            (+ (+ (cc 1 0)
                  (cc -4 1))
               1)))))
;
(+ 1
   (+ 0
      (+ 0
         (+ 0
            (+ (+ 0
                  0)
               1)))))
; 21