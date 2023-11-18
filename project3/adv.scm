#lang simply-scheme

(require "obj.rkt" "tables.scm")
(require racket/system)

;; ADV.SCM
;; This file contains the definitions for the objects in the adventure
;; game and some utility procedures.

; B4a modified start
(define-class (basic-object)
  (instance-vars (properties (make-table)))
  (method (type) 'basic-object)
  (method (put k v) (insert! k v properties))
  (default-method (lookup message properties)))
; B4a modified end

(define-class (place name)
  (parent (basic-object)) ; B4a modified
  (instance-vars
   (directions-and-neighbors '())
   (things '())
   (people '())
   (entry-procs '())
   (exit-procs '()))
  (method (type) 'place)
  (method (place?) #t) ; B4b modified
  (method (neighbors) (map cdr directions-and-neighbors))
  (method (exits) (map car directions-and-neighbors))
  (method (look-in direction)
    (let ((pair (assoc direction directions-and-neighbors)))
      (if (not pair)
	  '()                     ;; nothing in that direction
	  (cdr pair))))           ;; return the place object
  (method (appear new-thing)
    (cond ((memq new-thing things)
           (error "Thing already in this place" (list name new-thing))))
    (set! things (cons new-thing things))
    'appeared)
  (method (may-enter? p) #t) ; A4b modified
  (method (enter new-person)
    (cond ((memq new-person people)
	(error "Person already in this place" (list name new-person))))
    (for-each (lambda (p) (ask p 'notice new-person)) people) ; A4a modified
    (set! people (cons new-person people))
    (for-each (lambda (proc) (proc)) entry-procs)
    'appeared)
  (method (gone thing)
    (cond ((not (memq thing things))
	(error "Disappearing thing not here" (list name thing))))
    (set! things (delete thing things)) 
    'disappeared)
  (method (exit person)
    (for-each (lambda (proc) (proc)) exit-procs)
    (cond ((not (memq person people))
	(error "Disappearing person not here" (list name person))))
    (set! people (delete person people)) 
    'disappeared)

  (method (new-neighbor direction neighbor)
    (cond ((assoc direction directions-and-neighbors)
	(error "Direction already assigned a neighbor" (list name direction))))
    (set! directions-and-neighbors
	  (cons (cons direction neighbor) directions-and-neighbors))
    'connected)

  (method (add-entry-procedure proc)
    (set! entry-procs (cons proc entry-procs)))
  (method (add-exit-procedure proc)
    (set! exit-procs (cons proc exit-procs)))
  (method (remove-entry-procedure proc)
    (set! entry-procs (delete proc entry-procs)))
  (method (remove-exit-procedure proc)
    (set! exit-procs (delete proc exit-procs)))
  (method (clear-all-procs)
    (set! exit-procs '())
    (set! entry-procs '())
    'cleared) )

; A4b modified start
(define-class (locked-place name)
  (parent (place name))
  (method (type) 'locked-place)
  (instance-vars (locked #t))
  (method (may-enter? p) (equal? locked #f))
  (method (unlock) (set! locked #f)))
; A4b modified end

; B5 modified start
(define-class (hotspot name password)
  (parent (place name))
  (instance-vars (clist '()))
  (method (connect laptop pwd)
          (if (and (memq laptop (ask self 'things))
                   (eq? password pwd))
              (begin (set! clist (cons laptop clist))
                     (let ((clear-proc (lambda () (delete laptop clist))))
                       ; todo clear exit procedure
                       (usual 'add-exit-procedure clear-proc)))
              (error "Password is not correct!")))
  (method (surf laptop url)
          (if (memq laptop clist)
              (system (string-append "lynx " url))
              (error "not connected"))))
              

; A5 modified start
(define-class (garage name)
  (parent (place name))
  (instance-vars (record (make-table)))
  (class-vars (serial-no 0))
  (method (type) 'garage)
  (method (park car) (let ((th (ask self 'things))
                           (owner (ask car 'possessor)))
                       (if (memq car th)
                           (begin (insert! serial-no car record)
                                  (ask owner 'lose car)
                                  (let ((t (instantiate ticket 'TICKET serial-no)))
                                    (ask self 'appear t)
                                    (ask owner 'take t)))
                           (error "The car is not in the garage"))))
  (method (unpark ticket)
          (if (eq? (ask ticket 'name) 'TICKET)
              (let ((sn (ask ticket 'number))
                    (r (lookup (ask ticket 'number) record))
                    (owner (ask ticket 'possessor)))
                (cond (r (ask owner 'lose ticket)
                         (ask owner 'take r)
                         (insert! sn #f record))))
              (error "This is not a ticket") )))
; A5 modified end
  
(define-class (person name place)
  (parent (basic-object)) ; B4a modified
  (instance-vars
   (possessions '())
   (saying ""))
  (initialize
   (begin (ask self 'put 'strength 50) ; B4a modified
          (ask place 'enter self))) ; B4a modified
  (method (type) 'person)
  (method (person?) #t) ; B4b modified
  (method (look-around)
    (map (lambda (obj) (ask obj 'name))
	 (filter (lambda (thing) (not (eq? thing self)))
		 (append (ask place 'things) (ask place 'people)))))
  ; B6 modified start
  (method (eat)
          (let ((foods (filter (lambda (i) (edible? i)) possessions)))
            (for-each (lambda (food)
                        (let ((cal (ask food 'calories))
                              (strength (ask self 'strength)))
                          (ask self 'put 'strength (+ cal strength))
                          (ask self 'lose food)
                          (ask place 'gone food)))
                      foods)))
   ; B6 modified end
  (method (take thing)
    (cond ((not (thing? thing)) (error "Not a thing" thing))
	  ((not (memq thing (ask place 'things)))
	   (error "Thing taken not at this place"
		  (list (ask place 'name) thing)))
	  ((memq thing possessions) (error "You already have it!"))
	  (else
	   (announce-take name thing)
	   (set! possessions (cons thing possessions))
	       
	   ;; If somebody already has this object...
	   (for-each
	    (lambda (pers)
	      (cond ((and (not (eq? pers self)) ; ignore myself
		       (memq thing (ask pers 'possessions)))
		  (begin
		   (ask pers 'lose thing)
		   (have-fit pers)))))
	    (ask place 'people))
	       
	   (ask thing 'change-possessor self)
	   'taken)))
  ; B3 modified start
  (method (take-all)
          (for-each (lambda (t)
                      (cond ((eq? 'no-one (ask t 'possessor))
                             (ask self 'take t))))
                    (ask place 'things)))
  ; B3 modified end

  (method (lose thing)
    (set! possessions (delete thing possessions))
    (ask thing 'change-possessor 'no-one)
    'lost)
  (method (talk) (print saying))
  (method (set-talk string) (set! saying string))
  (method (exits) (ask place 'exits))
  (method (notice person) (ask self 'talk))
  (method (go direction)
    (let ((new-place (ask place 'look-in direction)))
      (cond ((null? new-place)
	     (error "Can't go" direction))
	    (else
             ; A4b modified start
             (cond ((not (ask new-place 'may-enter? self))
                    (error "this place if locked")))
             ; A4b modified end
	     (ask place 'exit self)
	     (announce-move name place new-place)
	     (for-each
	      (lambda (p)
		(ask place 'gone p)
		(ask new-place 'appear p))
	      possessions)
	     (set! place new-place)
	     (ask new-place 'enter self)))))
  ; A6a start
  (method (go-directly-to new-place)
          (cond ((not (ask new-place 'may-enter? self))
                 (error "this place if locked")))
          (ask place 'exit self)
          (announce-move name place new-place)
          (for-each
           (lambda (p)
             (ask place 'gone p)
             (ask new-place 'appear p))
           possessions)
          (set! place new-place)
          (ask new-place 'enter self))
  ; A6a end
  )
     
(define-class (thing name)
  (parent (basic-object)) ; B4a modified
  (instance-vars (possessor 'no-one))
  (method (type) 'thing)
  (method (thing?) #t) ; B4b modified
  (method (change-possessor new-possessor)
          (set! possessor new-possessor)))

; B6 modified start
(define-class (food name calo)
  (parent (thing name))
  (initialize (begin (ask self 'put 'edible? #t)
                     (ask self 'put 'calories calo))))

(define-class (bagel name calo)
  (class-vars (name 'bagel))
  (parent (food name calo)))
; B6 modified end

; A5 modified start
(define-class (ticket name number)
  (parent (thing name)))
; A5 modified end


(define-class (laptop name)
  (parent (thing name))
  (method (connect pwd)
          (let ((owner (ask self 'possessor)))
            (let ((w (ask owner 'place)))
              (ask w 'connect pwd))))
  (method (surf txt)
          (let ((owner (ask self 'possessor)))
            (let ((w (ask owner 'place)))
              (ask w 'surf txt)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Implementation of thieves for part two
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define *foods* '(pizza potstickers coffee))

; B6 modified start
(define (edible? thing)
  (ask thing 'edible?))
; B6 modified end

(define-class (thief name initial-place)
  (parent (person name initial-place))
  (instance-vars
   (behavior 'steal))
  (method (type) 'thief)

  (method (notice person)
    (if (eq? behavior 'run)
        ; A6b start
        (let ((exits (ask (usual 'place) 'exits)))
          (if (null? exits)
              'donothing
              (ask self 'go (pick-random exits))))
        ; A6b end
	(let ((food-things
	       (filter (lambda (thing)
			 (and (edible? thing)
			      (not (eq? (ask thing 'possessor) self))))
		       (ask (usual 'place) 'things))))
	  (cond ((not (null? food-things))
	      (begin
	       (ask self 'take (car food-things))
	       (set! behavior 'run)
	       (ask self 'notice person))) )))) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utility procedures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; this next procedure is useful for moving around

(define (move-loop who)
  (newline)
  (print (ask who 'exits))
  (display "?  > ")
  (let ((dir (read)))
    (if (equal? dir 'stop)
	(newline)
	(begin (print (ask who 'go dir))
	       (move-loop who)))))


;; One-way paths connect individual places.

(define (can-go from direction to)
  (ask from 'new-neighbor direction to))


(define (announce-take name thing)
  (newline)
  (display name)
  (display " took ")
  (display (ask thing 'name))
  (newline))

(define (announce-move name old-place new-place)
  (newline)
  (newline)
  (display name)
  (display " moved from ")
  (display (ask old-place 'name))
  (display " to ")
  (display (ask new-place 'name))
  (newline))

(define (have-fit p)
  (newline)
  (display "Yaaah! ")
  (display (ask p 'name))
  (display " is upset!")
  (newline))


(define (pick-random set)
  (list-ref (random (length set)) set))

(define (delete thing stuff)
  (cond ((null? stuff) '())
	((eq? thing (car stuff)) (cdr stuff))
	(else (cons (car stuff) (delete thing (cdr stuff)))) ))

; B4b modified start
(define (place? obj)
  (and (procedure? obj)
       (ask obj 'place?)))

(define (person? obj)
  (and (procedure? obj)
       (ask obj 'person?)))

(define (thing? obj)
  (and (procedure? obj)
       (ask obj 'thing?)))
; B4b modified end

(define (inventory person)
  (map (lambda (t) (ask t 'name))
       (ask person 'possessions)))

(define (name obj) (ask obj 'name))
(define (whereis obj) (name (ask obj 'place)))
(define (owner obj) (let ((o (ask obj 'possessor)))
                      (if (person? o)
                          (name o)
                          o)))


(provide thing place person locked-place garage food bagel)

(provide can-go pick-random thief move-loop)

(provide place? person? thing?)

(provide edible?)

(provide name whereis owner inventory)