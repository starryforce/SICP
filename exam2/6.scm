#lang simply-scheme

(require rackunit)

; A Transition is [List State Letter State]
; A FSM is [List-of Transition]
(define fsm0 '((1 A 2) (1 B 3) (1 C 4) (2 A 1) (3 B 1) (4 C 1)))

(define (make-transition start sign end) (list start sign end))
(define (transition-start t) (car t))
(define (transition-sign t) (cadr t))
(define (transition-end t) (caddr t))

; FSM State Letter -> State
(define (transition fsm st letter)
  (cond ((null? fsm) 0)
        ((and (eq? letter (transition-sign (car fsm)))
              (eq? st (transition-start (car fsm))))
         (transition-end (car fsm)))
        (else (transition (cdr fsm) st letter))))

(check-equal? (transition fsm0 1 'C) 4)
(check-equal? (transition fsm0 2 'C) 0)

; FSM State Word -> State
(define (process fsm st seq)
  (cond ((equal? seq "") st)
        (else (process fsm (transition fsm st (string->symbol (first seq))) (bf seq)))))


(check-equal? (process fsm0 1 'AACCAAB) 3)
(check-equal? (process fsm0 1 'AAAC)  0)