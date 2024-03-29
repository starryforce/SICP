#lang simply-scheme

(require rackunit)

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) 
                (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch 
                (car bits) 
                current-branch)))
          (if (leaf? next-branch)
              (cons 
               (symbol-leaf next-branch)
               (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) 
                        next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: 
               CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) 
         (cons x set))
        (else 
         (cons (car set)
               (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set 
         (make-leaf (car pair)    ; symbol
                    (cadr pair))  ; frequency
         (make-leaf-set (cdr pairs))))))

(define sample-tree
  (make-code-tree 
   (make-leaf 'A 4)
   (make-code-tree
    (make-leaf 'B 2)
    (make-code-tree 
     (make-leaf 'D 1)
     (make-leaf 'C 1)))))

(define sample-message 
  '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(define sample-code '(A D A B B C A))

; [List-of Symbol] -> [List-of Bit]
(define (encode message tree)
  (if (null? message)
      '()
      (append 
       (encode-symbol (car message) 
                      tree)
       (encode (cdr message) tree))))

; Symbol -> [List-of Bit]
(define (encode-symbol s tree)
  (if (leaf? tree)
      '()
      (if (member? s (symbols tree))
          (if (member? s (symbols (left-branch tree)))
              (cons 0 (encode-symbol s (left-branch tree)))
              (cons 1 (encode-symbol s (right-branch tree))))
          (error "the symbol is not in the tree"))))

(check-equal? (encode sample-code sample-tree) sample-message)

(define (generate-huffman-tree pairs)
  (successive-merge 
   (make-leaf-set pairs)))

; [List-of Leaf] -> Tree
(define (successive-merge alol)
  (if (null? (cdr alol))
      (car alol)
      (successive-merge (adjoin-set (make-code-tree (car alol) (cadr alol)) (cddr alol)))))

(define song-samples '((a 2) (boom 1) (Get 2) (job 2) (na 16) (Sha 3) (yip 9) (Wah 1)))

(define song-tree (generate-huffman-tree song-samples))

(define song-code (encode  '(Get a job Sha na na na na na na na na Get a job Sha na na na na na na na na Wah yip yip yip yip  yip yip yip yip yip Sha boom)
                           song-tree))

; How many bits are required for the encoding? 
; 84 bits

; What is the smallest number of bits that would be needed to encode this song if we used a fixed-length code for the eight-symbol alphabet?
; one symbol, 3 bits, totally 36 , so 36 x 3 = 108 bits