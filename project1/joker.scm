#lang simply-scheme
(require rackunit)

(define (twenty-one strategy)
  (define (play-dealer customer-hand dealer-hand-so-far rest-of-deck)
    (cond ((> (best-total dealer-hand-so-far) 21) 1)
          ((< (best-total dealer-hand-so-far) 17)
           (play-dealer customer-hand
                        (se dealer-hand-so-far (first rest-of-deck))
                        (bf rest-of-deck)))
          ((< (best-total customer-hand) (best-total dealer-hand-so-far)) -1)
          ((= (best-total customer-hand) (best-total dealer-hand-so-far)) 0)
          (else 1)))

  (define (play-customer customer-hand-so-far dealer-up-card rest-of-deck)
    (cond ((> (best-total customer-hand-so-far) 21) -1)
          ((strategy customer-hand-so-far dealer-up-card)
           (play-customer (se customer-hand-so-far (first rest-of-deck))
                          dealer-up-card
                          (bf rest-of-deck)))
          (else
           (play-dealer customer-hand-so-far
                        (se dealer-up-card (first rest-of-deck))
                        (bf rest-of-deck)))))

  (let ((deck (make-deck)))
    (play-customer (se (first deck) (first (bf deck)))
                   (first (bf (bf deck)))
                   (bf (bf (bf deck))))) )

(define (make-ordered-deck)
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(a 2 3 4 5 6 7 8 9 10 j q k)) )
  (se (make-suit 'h) (make-suit 's) (make-suit 'd) (make-suit 'c) 'joker 'joker) )

(define (make-deck)
  (define (shuffle deck size)
    (define (move-card in out which)
      (if (= which 0)
          (se (first in) (shuffle (se (bf in) out) (- size 1)))
          (move-card (bf in) (se (first in) out) (- which 1)) ))
    (if (= size 0)
        deck
        (move-card deck '() (random size)) ))
  (shuffle (make-ordered-deck) 54) )

; Word -> Number
; get card's point
(define (point card)
  (let ((value (bl card)))
    (cond ((member? value '(j q k)) 10)
          ((equal? value 'a) 1)
          (else value))))

(check-equal? (point 'ad) 1)
(check-equal? (point '8s) 8)
(check-equal? (point '10h) 10)
(check-equal? (point 'jh) 10)


; Sentence -> Number
; turn the largest possible total that’s less than or equal to 21
(define (best-total s)
  (define (min-point s)
    (cond ((empty? s) 0)
          (else (+ (point (first s)) 
                   (min-point (bf s))))))
  ; Number Number -> Number
  ; count represent the a's quantity in s
  (define (get-best min count)
    (cond ((equal? count 0) min)
          ((> (+ min (- 11 1)) 21) min)
          (else (get-best (+ min (- 11 1)) (- count 1)))))
  (let ((a-count (length (filter (lambda (x) (equal? (first x) 'a)) s))))
    (get-best (min-point s) a-count)))

(check-equal? (best-total '(ad 8s)) 19) ; in this hand the ace counts as 11
(check-equal? (best-total '(ad 8s 5h)) 14)  ; here it must count as 1 to avoid busting
(check-equal? (best-total '(ad as 9h)) 21) ; here one counts as 11 and the other as 1

; Sentence Word -> Boolean
;  takes a card if and only if the total of s is less than 17.
(define (stop-at-17 s w)
  (< (best-total s) 17))

(check-equal? (stop-at-17 '(1h 2s 3d) 'a) #t)
(check-equal? (stop-at-17 '(8s 8d) 'a) #t)
(check-equal? (stop-at-17 '(8s 9d) 'a) #f)
(check-equal? (stop-at-17 '(as 5d) 'a) #t)
(check-equal? (stop-at-17 '(as 5d 5h) 'a) #f)
(check-equal? (stop-at-17 '(as 5d 6h) 'a) #t)

(define (play-n st n)
  (cond ((= n 0) 0)
        (else (+ (twenty-one st)
                 (play-n st (- n 1))))))
; 4.
; Sentence Word -> Boolean
; consider the dealer's card
(define (dealer-sensitive s w)
  (or (and (member? (point w) '(1 7 8 9 10)) (< (best-total s) 17))
      (and (member? (point w) '(2 3 4 5 6)) (< (best-total s) 12))))
; 5.
; Number -> [Sentence Word -> Boolean]
(define (stop-at n)
  (lambda (s w) (< (best-total s) n)))
; 6.
(define (valentine s w)
  (define (heart? s)
    (cond ((empty? s) #f)
          ((equal? (last (first s)) 'h) #t)
          (else (heart? (bf s)))))
  ((stop-at (if (heart? s) 19 17)) s w))

; Sentence [Sentence Word -> Boolean] [Sentence Word -> Boolean]
; -> [Sentence Word -> Boolean]
(define (suit-strategy suit stratege-n stratege-y)
  (lambda (s w)
    (if (include? s suit)
        (stratege-n s w)
        (stratege-y s w))))

(define (include? s1 s2)
  (define (exist? s w)
    (cond ((empty? s) #f)
          (else (or (equal? (first s) w)
                    (exist? (bf s) w)))))
  (cond ((empty? s2) #t)
        (else (and (exist? s1 (first s2))
                   (include? s1 (bf s2))))))

(check-equal? (include? '(a b c) '(a c)) #t)
(check-equal? (include? '(a c) '(a b c)) #f)

; 7.
(define valentine-new (suit-strategy '(h) (stop-at 17) (stop-at 19)))

(define (majority s1 s2 s3)
  (lambda (s w)
    (let ((r1 (s1 s w))
          (r2 (s2 s w))
          (r3 (s3 s 2)))
      (or (and r1 r2 r3)
          (and r1 r2)
          (and r1 r3)
          (and r2 r3)))))
; 8. (play-n (majority stop-at-17 dealer-sensitive valentine) 10000)


; 9. 
(define (reckless st)
  (lambda (s w)
    (st (bl s) w)))

;(play-n valentine 10000)
;(play-n (reckless valentine) 10000)