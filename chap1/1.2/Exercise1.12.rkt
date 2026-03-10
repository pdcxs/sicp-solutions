#lang racket

; Exercise 1.12.
; The following pattern of numbers is called
; Pascal's triangle.
;         1
;       1   1
;     1   2   1
;   1   3   3   1
; 1   4   6   4   1

; The numbers at the edge of the triangle are all 1,
; and each number inside the triangle is the sum
; of the two numbers above it.
; Write a procedure that computes elements of
; Pascal's triangle by means of a recursive process.

; Answer
(define (pascal n m)
  (if (or (= m n) (= m 1))
      1
      (+ (pascal (sub1 n) (sub1 m))
         (pascal (sub1 n) m))))

(require rackunit)

(for ([i (in-range 1 6)])
  (for ([j (in-range 1 (add1 i))])
    (display (pascal i j))
    (display "\t"))
  (newline))