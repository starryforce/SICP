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
; Q1-01
(define Dormitory (instantiate place 'Dormitory))
; Q1-04
(define Kirin (instantiate place 'Kirin))


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
; Q1-03
(can-go Intermezzo 'east Dormitory)
(can-go Dormitory 'west Intermezzo)
; Q1-05
(can-go Soda 'north Kirin)
(can-go Kirin 'south Soda)


;; Some people.
; MOVED above the add-entry-procedure stuff, to avoid the "The computers
; seem to be down" message that would occur when hacker enters 61a-lab
; -- Ryan Stejskal

(define Brian (instantiate person 'Brian Telegraph-Ave))
(define hacker (instantiate person 'hacker MJC-Office))
(define nasty (instantiate thief 'nasty MJC-Office))
; Q1-02
(define Ni (instantiate person 'Ni Dormitory))

(define (sproul-hall-exit)
   (error "You can check out any time you'd like, but you can never leave"))

(define (bh-office-exit)
  (print "What's your favorite programming language?")
  (let ((answer (read)))
    (if (eq? answer 'scheme)
	(print "Good answer, but my favorite is Logo!")
	(begin (newline) (bh-office-exit)))))
    

(ask s-h 'add-entry-procedure
 (lambda () (print "Miles and miles of students are waiting in line...")))
(ask s-h 'add-exit-procedure sproul-hall-exit)
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

(define bagel (instantiate thing 'bagel))
(ask Noahs 'appear bagel)

(define coffee (instantiate thing 'coffee))
(ask Intermezzo 'appear coffee)

; Q1-06
(define potstickers (instantiate thing 'potstickers))
(ask Kirin 'appear potstickers)

(can-go Telegraph-Ave 'east (instantiate place 'Peoples-Park))
(ask Brian 'go 'east)

(define computer (instantiate thing 'Durer))

#|
2A.  What kind of thing is the value of variable BRIAN?
A: a dispatch procedure

2B.   List all the messages that a PLACE understands.
A:
  - 'appear
  - methods in place

2C. What is returned by the following expressions and WHY?

> (ask Brian 'place)
#<procedure:dispatch>

> (let ((where (ask Brian 'place)))
       (ask where 'name))
'Peoples-Park

>  (ask Peoples-park 'appear bagel)
error because we did not define variable Peoples-park

2D.
 > (eq? (ask Telegraph-Ave 'look-in 'east) (ask Brian 'place))
   #t
 > (eq? (ask Brian 'place) 'Peoples-Park)
   #f
 > (eq? (ask (ask Brian 'place) 'name) 'Peoples-Park)
   #t

Which of the following is correct?  Why?
(ask 61a-lab 'appear computer) is correct
because it's the reference of that project

What is returned by (computer 'name)?  Why?
a procedure that will return 'Durer

2F. 
|#

(define (name obj) (ask obj 'name))
(define (whereis obj) (name (ask obj 'place)))
(define (owner obj) (let ((o (ask obj 'possessor)))
                      (if (person? o)
                          (name o)
                          o)))