#lang simply-scheme

(require sicp-pict)

(define (wave frame)
  ((segments->painter (list (make-segment (make-vect 0.165 0.945) (make-vect 0.465 0.665)) ; Left Leg
                            (make-segment (make-vect 0.465 0.665) (make-vect 0.465 0.285)) ; Body
                            (make-segment (make-vect 0.465 0.455) (make-vect 0.745 0.585)) ; Right arm
                            (make-segment (make-vect 0.465 0.665) (make-vect 0.755 0.925)) ;
                            (make-segment (make-vect 0.475 0.455) (make-vect 0.185 0.615)) ; ?
                            (make-segment (make-vect 0.245 0.265) (make-vect 0.685 0.295)) ; Head - Bot
                            (make-segment (make-vect 0.685 0.295) (make-vect 0.685 0.035)) ;
                            (make-segment (make-vect 0.685 0.035) (make-vect 0.245 0.065)) ;
                            (make-segment (make-vect 0.245 0.065) (make-vect 0.245 0.265))
                            (make-segment (make-vect 0.25 1) (make-vect 0.75 0.75))
                            (make-segment (make-vect 0.25 0.75) (make-vect 0.75 1)))) frame))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter
                               (- n 1))))
        (below painter
               (beside smaller smaller)))))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter 
                                  (- n 1))))
        (beside painter 
                (below smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter 
                                (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right 
                                   right))
              (corner (corner-split painter 
                                    (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right 
                         corner))))))


(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (below (flip-horiz quarter) 
                        quarter)))
      (beside (flip-vert half) half))))

(paint (square-limit wave 3))