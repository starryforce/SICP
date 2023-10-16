#lang simply-scheme

(require rackunit)

(define (make-account balance pwd)
  (let ((errs 0))
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance 
                       (- balance amount))
                 balance)
          "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (call-the-cops) 0)
    (define (dispatch input-pwd m)
      (if (eq? input-pwd pwd)
          (begin (set! errs 0)
                 (cond ((eq? m 'withdraw) withdraw)
                       ((eq? m 'deposit) deposit)
                       (else (error "Unknown request: 
                 MAKE-ACCOUNT" m))))
                 
          (if (> errs 7)
              (call-the-cops)
              (begin (set! errs (+ errs 1))
                     (lambda args "Incorrect password"))))
      )
    dispatch))

(define acc 
  (make-account 100 'secret-password))
(check-equal? ((acc 'secret-password 'withdraw) 40) 60)
(check-equal? ((acc 'some-other-password 'deposit) 50) "Incorrect password")