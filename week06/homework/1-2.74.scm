#lang simply-scheme

; all the division files have been implemented as data structures in Scheme

; each division’s personnel records consist of a single file
; which contains a set of records keyed on employees’ names
; The structure of the set varies from division to division

; each employee’s record is itself a set
; structured differently from division to division

#|  division1    division2    division3    ....
        |            |            |
       file#1       file#2       file#3
        |
    [record 1]#name1
    [record 2]#name2
    [record 3]#name3 --> [info 1]
       ...               [info 2]
                         [info 3]
                         ... |#

; personnel file -> File
; division's name & [List-of Record]
; employee’s record -> Record
; employees's name & [List-of Info]
; employee's information  -> Info
; info's key & value

; Q1
; Implement for headquarters a get-record procedure that
; retrieves a specified employee’s record from a specified personnel file.
; The procedure should be applicable to any division’s file.
; Explain how the individual divisions’ files should be structured.
; In particular, what type information must be supplied?

; A1
; contains a tag and the actual division file.
; information about which division this file belongs to


(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: 
              TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: 
              CONTENTS" datum)))

(define (make-division1 file)
  (attach-tag 'division1 file))
(define (make-division2 file)
  (attach-tag 'division2 file))

; Symbol File1 -> Record1
(define (query-record-file1 record-key file)
  (define (key ob) ob)
  (cond ((null? file) #f)
        ((eq? record-key (key (car file))) (car file))
        (else (query-record-file1 record-key (cdr file)))))

; Symbol Record1 -> Info
(define (query-info-record1 info-key record)
  (define (key ob) ob)
  (cond ((null? record) #f)
        ((eq? info-key (key (car record))) (car record))
        (else (query-info-record1 info-key (cdr record)))))

(put 'query-record 'division1 query-record-file1)
(put 'query-record 'division2 query-record-file2)
(put 'query-info 'division1 query-info-record1)
(put 'query-info 'division2 query-info-record2)

(define (generic-apply name op data)
  (let ((type (type-tag data))
        (proc (get op type)))
    (if proc
        (proc (contents data))
        (error "can't find associated operation"))))

; Symbol <File> -> <Record>
(define (get-record name data)
  (generic-apply name 'query-record data))

; Q2
; Implement for headquarters a get-salary procedure that returns
; the salary information from a given employee’s record from any division’s personnel file.
; How should the record be structured in order to make this operation work?

; A2
; combines the employee's name with his info sets

(define (get-salary name data)
  (let ((record (generic-apply name 'query-record data)))
    (if record
        ((get 'query-info (type-tag data)) record)
        (error "not found record associate with" name))))

; Q3
; Implement for headquarters a find-employee-record procedure.
; This should search all the divisions’ files for the record of a given employee and return the record.
; Assume that this procedure takes as arguments an employee’s name and a list of all the divisions’ files.

; 'Symbol [List-of <File>] -> [Maybe <Record>]
(define (find-employee-record name alof)
  (cond ((null? alof) #f)
        (else (let ((result (get-record name (car alof))))
                (if result
                    result
                    (find-employee-record name (cdr alof)))))))


; Q4
; When Insatiable takes over a new company,
; what changes must be made in order to incorporate the new personnel information into the central system?