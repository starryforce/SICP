#lang simply-scheme

(require rackunit)

(define (make-account balance pwd)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch input-pwd m)
    (cond ((not (eq? input-pwd pwd)) (lambda args "Incorrect password"))
          ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: 
                 MAKE-ACCOUNT" m))))
  dispatch)

(define peter-acc 
  (make-account 100 'secret-password))
(check-equal? ((peter-acc 'secret-password 'withdraw) 40) 60)
(check-equal? ((peter-acc 'some-other-password 'deposit) 50) "Incorrect password")


(define (make-joint acc oldpwd newpwd)
  (lambda (pwd m)
    (if (eq? newpwd pwd)
        (acc oldpwd m)
        (lambda args "Incorrect password"))))

(define paul-acc
  (make-joint peter-acc 
              'secret-password 
              'rosebud))

((paul-acc 'rosebud 'withdraw) 40)