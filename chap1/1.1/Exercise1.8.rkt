#lang racket

; Exercise 1.8.
; Newton's method for cube roots is based on the fact
; that if y is an approximation to the cube root of x,
; then a better approximation is given by the value
; $ \frac{x/y^2+2y}{3} $
; Use this formula to implement a cube-root procedure
; analogous to the square-root procedure.
; (In section 1.3.4 we will see how to implement Newton's
; method in general as an abstraction of these square-root
; and cube-root procedures.)

; Answer:

(define (iter-cube guess x)
  (if (good-enough? guess x)
      guess
      (iter-cube (improve guess x) x)))

; Use fraction of x to test the error.
; We don't consider negative x here.
(define (good-enough? guess x)
  (< (/ (abs (- (cube guess) x)) x) 0.001))

(define (cube x)
  (* x x x))

(define (improve y x)
  (/ (+ (/ x (* y y)) (* 2 y)) 3))

; tests:
(iter-cube 1.0 8.0)
(iter-cube 1.0 0.001)
(iter-cube 1.0 1234567891011.0)