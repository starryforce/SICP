#lang simply-scheme

(require rackunit)

(define (make-account1 balance)
  (define init balance)
  (define (withdraw amount)
    (set! balance (- balance amount)) balance)
  (define (deposit amount)
    (set! balance (+ balance amount)) balance)
  (define (dispatch msg)
    (cond
      ((eq? msg 'balance) balance)
      ((eq? msg 'init-balance) init)
      ((eq? msg 'withdraw) withdraw)
      ((eq? msg 'deposit) deposit) ) )
  dispatch)

(define (make-account2 init-amount)
  (let ((balance init-amount))
    (define (withdraw amount)
      (set! balance (- balance amount)) balance)
    (define (deposit amount)
      (set! balance (+ balance amount)) balance)
    (define (dispatch msg)
      (cond
        ((eq? msg 'balance) balance)
        ((eq? msg 'init-balance) init-amount)
        ((eq? msg 'withdraw) withdraw)
        ((eq? msg 'deposit) deposit) ) )
    dispatch) )

(define acc1 (make-account1 100))
(check-equal? (acc1 'balance) 100)
(check-equal? ((acc1 'deposit) 20) 120)
(check-equal? (acc1 'balance) 120)
(check-equal? (acc1 'init-balance) 100)

(define acc2 (make-account2 100))
(check-equal? (acc2 'balance) 100)
(check-equal? ((acc2 'deposit) 20) 120)
(check-equal? (acc2 'balance) 120)
(check-equal? (acc2 'init-balance) 100)