#lang racket
; #lang lazy

; Exercise 1.6.
; Alyssa P. Hacker doesn't see why if needs to be provided as a special form.
; ``Why can't I just define it as an ordinary
; procedure in terms of cond?'' she asks.
; Alyssa's friend Eva Lu Ator claims this can indeed be done,
; and she defines a new version of if:

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

; Eva demonstrates the program for Alyssa:

(new-if (= 2 3) 0 5)
; 5

(new-if (= 1 1) 0 5)
; 0

; Delighted, Alyssa uses new-if to rewrite the square-root program:

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

; What happens when Alyssa attempts to use this to compute square roots? Explain.

; Additional helper functions:

(define (square x) (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

; Answer:

; The new process will never ends.
; In if, we will not calculate the parameters first,
; but calculate the prediction first.
; If the prediction is true, then calculate the first branch,
; otherwise we calculate the second branch.
; However, in the new-if, the three parameters
; will be evaluated first, then the second branch
; will go into the next iteration.
; And the iterations will also calculate the second branch,
; which is another iteration.
; Consequently, it will never ends.
; We can change #lang racket to #lang lazy to
; make the new process work.

(sqrt-iter 1.0 2.0)