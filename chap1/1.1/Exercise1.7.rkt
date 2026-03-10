#lang racket

; Exercise 1.7.
; The good-enough? test used in computing square roots
; will not be very effective for finding the square roots
; of very small numbers. Also, in real computers,
; arithmetic operations are almost always performed with
; limited precision. This makes our test inadequate for
; very large numbers. Explain these statements,
; with examples showing how the test fails for
; small and large numbers. An alternative strategy
; for implementing good-enough? is to watch how guess
; changes from one iteration to the next and to stop
; when the change is a very small fraction of the guess.
; Design a square-root procedure that uses this kind of
; end test. Does this work better for small and large numbers?

; Answer

; The square-iter process in the text book is:

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (square x) (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

; good-enough test the error between the square of guess and x is
; less than 0.001. If x is small, then the error threshold is too large.
; If x is huge, We can not make the error precision less then this
; threshold, because the precision is limited (IEEE Floating number).
; Let's test:

(sqrt-iter 0.1 0.0004) ; should be 0.02, but actually, it's 0.0298
; (sqrt-iter 1.0 1524157875019052112345.0) ; This will take long time

; Let's create a better good-enough?

(define (better-good-enough? prev next)
  (< (abs (/ (- next prev) prev))
     0.001))
(define (better-sqrt-iter prev-guess next-guess x)
  (if (better-good-enough? prev-guess next-guess)
      next-guess
      (better-sqrt-iter next-guess (improve next-guess x) x)))

; Then we can get better results:

(better-sqrt-iter 0.001 0.1 0.0004)
(better-sqrt-iter 0.01 1.0 1524157875019052112345.0)