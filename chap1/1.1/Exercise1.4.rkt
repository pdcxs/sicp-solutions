#lang racket

; Exercise 1.4.
; Observe that our model of evaluation allows for combinations
; whose operators are compound expressions.
; Use this observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; Answer:

; If parameter b is positive, then calculate a + b.
; Otherwise, calculate a - b.
; Let's test it:

(require rackunit)
(check-eq? (a-plus-abs-b 1 2) 3)
(check-eq? (a-plus-abs-b 2 -2) 4)