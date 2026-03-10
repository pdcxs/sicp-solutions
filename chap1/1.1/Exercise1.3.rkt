#lang racket

; Exercise 1.3.
; Define a procedure that takes three numbers as
; arguments and returns the sum of the
; squares of the two larger numbers.

; Answer:

(define (square-sum-of-largest-two-numbers a b c)
  (cond [(and (>= a c) (>= b c))
         (square-sum a b)]
        [(and (>= a b) (>= c b))
         (square-sum a c)]
        [else (square-sum b c)]))

(define (square-sum x y)
  (+ (* x x) (* y y)))

(require rackunit)
(check-eq? (square-sum-of-largest-two-numbers 1 2 3) 13)
(check-eq? (square-sum-of-largest-two-numbers 3 2 1) 13)
(check-eq? (square-sum-of-largest-two-numbers 3 1 2) 13)
(check-eq? (square-sum-of-largest-two-numbers 3 2 2) 13)
(check-eq? (square-sum-of-largest-two-numbers 3 3 3) 18)