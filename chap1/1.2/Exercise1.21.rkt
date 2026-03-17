#lang racket

; Exercise 1.21.
; Use the smallest-divisor procedure to find the
; smallest divisor of each of the following numbers:
; 199, 1999, 19999.

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (square a) (* a a))

(for ([i '(199 1999 19999)])
  (printf "The smallest divisor of ~a is ~a.~n"
          i (smallest-divisor i)))
