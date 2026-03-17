#lang racket

; Exercise 1.18.
; Using the results of exercises 1.16 and 1.17,
; devise a procedure that generates an iterative
; process for multiplying two integers in terms
; of adding, doubling, and halving and uses a
; logarithmic number of steps.

; Answer

(define (double a)
  (+ a a))

(define (halve b)
  (/ b 2))

(define (fast-multiply a b)
  (define (iter a b c)
    (cond
      [(zero? b) c]
      [(even? b)
       (iter (double a)
             (halve b)
             c)]
      [else
       (iter (double a)
             (halve (sub1 b))
             (+ a c))]))
  (iter a b 0))

; Let's test

(require rackunit)
(for ([i (in-range 100)])
  (for ([j (in-range 100)])
    (check-eq? (fast-multiply i j) (* i j))))