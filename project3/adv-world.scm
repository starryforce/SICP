#lang simply-scheme

(require "obj.rkt" "adv.scm")

;;;  Data for adventure game.  This file is adv-world.scm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setting up the world
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define Soda (instantiate place 'Soda))
(define BH-Office (instantiate place 'BH-Office))
(define MJC-Office (instantiate place 'MJC-Office))
(define art-gallery (instantiate place 'art-gallery))
(define Pimentel (instantiate place 'Pimentel))
(define 61A-Lab (instantiate place '61A-Lab))
(define Sproul-Plaza (instantiate place 'Sproul-Plaza))
(define Telegraph-Ave (instantiate place 'Telegraph-Ave))
(define Noahs (instantiate place 'Noahs))
(define Intermezzo (instantiate place 'Intermezzo))
(define s-h (instantiate place 'sproul-hall))


(can-go Soda 'up art-gallery)
(can-go art-gallery 'down Soda)
(can-go art-gallery 'west BH-Office)
(can-go BH-Office 'east art-gallery)
(can-go art-gallery 'east MJC-Office)
(can-go MJC-Office 'west art-gallery)
(can-go Soda 'south Pimentel)
(can-go Pimentel 'north Soda)
(can-go Pimentel 'south 61A-Lab)
(can-go 61A-Lab 'north Pimentel)
(can-go 61A-Lab 'west s-h)
(can-go s-h 'east 61A-Lab)
(can-go Sproul-Plaza 'east s-h)
(can-go s-h 'west Sproul-Plaza)
(can-go Sproul-Plaza 'north Pimentel)
(can-go Sproul-Plaza 'south Telegraph-Ave)
(can-go Telegraph-Ave 'north Sproul-Plaza)
(can-go Telegraph-Ave 'south Noahs)
(can-go Noahs 'north Telegraph-Ave)
(can-go Noahs 'south Intermezzo)
(can-go Intermezzo 'north Noahs)


;; Some people.
; MOVED above the add-entry-procedure stuff, to avoid the "The computers
; seem to be down" message that would occur when hacker enters 61a-lab
; -- Ryan Stejskal

(define Brian (instantiate person 'Brian BH-Office))
(define hacker (instantiate person 'hacker MJC-Office))
(define nasty (instantiate thief 'nasty MJC-Office))
(define Ni (instantiate person 'Ni 61A-Lab))

; A3 modify start
(define (sproul-hall-exit)
  (let ((count 0))
    (lambda ()
      (if (>= count 3)
          (set! count 0)
          (begin (set! count (+ count 1))
                 (error "You can check out any time you'd like, but you can never leave"))))))
; A3 modify end

(define (bh-office-exit)
  (print "What's your favorite programming language?")
  (let ((answer (read)))
    (if (eq? answer 'scheme)
	(print "Good answer, but my favorite is Logo!")
	(begin (newline) (bh-office-exit)))))
    

(ask s-h 'add-entry-procedure
 (lambda () (print "Miles and miles of students are waiting in line...")))
(ask s-h 'add-exit-procedure (sproul-hall-exit)) ; A3 modify
(ask BH-Office 'add-exit-procedure bh-office-exit)
(ask Noahs 'add-entry-procedure
 (lambda () (print "Would you like lox with it?")))
(ask Noahs 'add-exit-procedure
 (lambda () (print "How about a cinnamon raisin bagel for dessert?")))
(ask Telegraph-Ave 'add-entry-procedure
 (lambda () (print "There are tie-dyed shirts as far as you can see...")))
(ask 61A-Lab 'add-entry-procedure
 (lambda () (print "The computers seem to be down")))
(ask 61A-Lab 'add-exit-procedure
 (lambda () (print "The workstations come back to life just in time.")))

;; Some things.

; B6 modified start
(define Food1 (instantiate bagel 'Food1 200))
(ask Noahs 'appear Food1)
; B6 modified end

(define coffee (instantiate thing 'coffee))
(ask Intermezzo 'appear coffee)

; A4a modified start
(define singer (instantiate person 'rick Sproul-Plaza))
(ask singer 'set-talk "My funny valentine, sweet comic valentine")
(define preacher (instantiate person 'preacher Sproul-Plaza))
(ask preacher 'set-talk "Praise the Lord")
(define street-person (instantiate person 'harry Telegraph-Ave))
(ask street-person 'set-talk "Brother, can you spare a buck")

(ask preacher 'go 'south)
(ask preacher 'go 'north)
(ask street-person 'go 'north)
(ask singer 'go 'south)
(ask street-person 'go 'south)
(ask street-person 'go 'north)
; A4a modified end


#|
; A4b modified start
(define Secret-Room (instantiate locked-place 'Secret-Room))
(can-go 61A-Lab 'east Secret-Room)
(can-go Secret-Room 'west 61A-Lab)
(define Breaker (instantiate person 'Breaker 61A-Lab))
(ask Breaker 'go 'east)
(ask Secret-Room 'unlock)
(ask Breaker 'go 'east)
; A4b modified end
|#

; A5 modified start
(define B1 (instantiate garage 'B1))
(can-go 61A-Lab 'down B1)
(can-go B1 'up 61A-Lab)

(define GTR (instantiate thing 'GTR))
(ask 61A-Lab 'appear GTR)
(ask Ni 'take GTR)
(ask Ni 'go 'down)
(ask B1 'park GTR)
(ask Ni 'go 'up)
(ask Ni 'go 'down)
(ask (car (ask Ni 'possessions)) 'name)
(ask B1 'unpark (car (ask Ni 'possessions)))
(ask (car (ask Ni 'possessions)) 'name)
; A5 modified end

; B3 modified start
(define Pig (instantiate thing 'Pig))
(ask B1 'appear Pig)
(define Cat (instantiate thing 'Cat))
(ask B1 'appear Cat)
(define Dog (instantiate thing 'Dog))
(ask B1 'appear Dog)
(define Fang (instantiate person 'Fang B1))
(ask Ni 'take Pig)
(ask Fang 'take-all)
; B3 modified end

; B4a modifed start
(ask Ni 'strength)
(ask Ni 'put 'strength 100)
(ask Ni 'strength)
(ask Ni 'stre)
; B4a modifed end

; A6a start
(define Jail (instantiate place 'Jail))
(ask Ni 'go-directly-to Jail) 
; A6a end

; B6 modified start
(define Food2 (instantiate food 'Food2 500))
(define Food3 (instantiate bagel 'Food3 110))
(ask Jail 'appear Food2)
(ask Jail 'appear Food3)
(ask Ni 'take Food2)
(ask Ni 'take Food3)
(ask Ni 'eat)
; B6 modified end