#lang simply-scheme

(require rackunit)

; [List-of Symbol] -> [List-of Symbol]
; returns the result of removing duplicate words from alos.
(define (dupls-removed alos)
  (cond ((empty? alos) '())
        (else  (if (member? (first alos) (bf alos))
                   (dupls-removed (bf alos))
                   (se (first alos) (dupls-removed (bf alos)))))))

(check-equal? (dupls-removed '(a b c a e d e b)) '(c a d e b))
(check-equal? (dupls-removed '(a b c)) '(a b c))
(check-equal? (dupls-removed '(a a a a b a a)) '(b a))