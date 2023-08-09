#lang simply-scheme

(require rackunit)

(define (count-change amount)
  (cc amount '(50 25 10 5 1)))

; Number [Sentence Number] -> Number
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) 
             (= (length kinds-of-coins) 0)) 
         0)
        (else 
         (+ (cc amount (bf kinds-of-coins))
            (cc (- amount (first kinds-of-coins))
                kinds-of-coins)))))

(check-equal? (count-change 100) 292)
