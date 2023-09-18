#lang simply-scheme

(define (equ? x y) (apply-generic 'equ? x y))

; ... install-scheme-number-package ...
(put 'equ? '(scheme-number scheme-number) =)


; ... install-rational-package ...
(put 'equ? '(rational rational)
     (lambda (x y)  (and (= (numer x) (numer y))
                         (= (denom x) (denom y)))))

; ... install-complex-package ...
(put 'equ? '(complex complex)
     (lambda (z1 z2) (and (= (real-part z1) (real-part z2))
                          (= (imag-part z1) (imag-part z2)))))
