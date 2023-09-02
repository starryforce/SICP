#lang simply-scheme

(require rackunit)

; only need to change the constructors & selectors

; A BinaryMobile is a pair:
; (cons Branch Branch)
(define (make-mobile left right)
  (cons left right))

; BinaryMobile -> Branch
(define (left-branch bm) (car bm))
(define (right-branch bm) (cdr bm))

; A Structure is one of:
; - Number
; - BinaryMobile

; A Branch is a pair:
; (list Number Structure)
(define (make-branch length structure)
  (cons length structure))

; Branch -> Number
(define (branch-length b) (car b))
; Branch -> Structure
(define (branch-structure b) (cdr b))

(define ex-branch-1 (make-branch 3 5))
(define ex-branch-2 (make-branch 4 8))
(define ex-mobile-1 (make-mobile ex-branch-1 ex-branch-2))
(define ex-branch-3 (make-branch 2 ex-mobile-1))
(define ex-mobile-2 (make-mobile ex-branch-1 ex-branch-3))

; BinaryMobile -> Number
; returns the total weight of a mobile
(define (total-weight bm)
  (+ (branch-weight (left-branch bm))
     (branch-weight (right-branch bm))))

; Branch -> Number
; returns the total weight of a branch
(define (branch-weight b)
  (if (number? (branch-structure b))
      (branch-structure b)
      (total-weight (branch-structure b))))

(check-equal? (total-weight ex-mobile-1) 13)
(check-equal? (total-weight ex-mobile-2) 18)

; BinaryMobile -> Boolean
; determine if a mobile is balanced
(define (mobile-balanced? bm)
  (let ((lb (left-branch bm))
        (rb (right-branch bm)))
    ; both mobile and two branch is balanced
    (and (= (* (branch-length lb) (branch-weight lb))
            (* (branch-length rb) (branch-weight rb)))
         (or (number? (branch-structure lb))
             (mobile-balanced? (branch-structure lb)))
         (or (number? (branch-structure rb))
             (mobile-balanced? (branch-structure rb))))))

(check-equal? (mobile-balanced? (make-mobile (make-branch 4 (make-mobile (make-branch 1 9)
                                                                         (make-branch 3 3)))
                                             (make-branch 2 24))) #t)
(check-equal? (mobile-balanced? (make-mobile (make-branch 4 (make-mobile (make-branch 2 9)
                                                                         (make-branch 3 3)))
                                             (make-branch 2 24))) #f)
(check-equal? (mobile-balanced? ex-mobile-2) #f)


