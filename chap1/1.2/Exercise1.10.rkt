#lang racket

; Exercise 1.10.
; The following procedure computes a mathematical function
; called Ackermann's function.

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

; What are the values of the following expressions?

(A 1 10)

(A 2 4)

(A 3 3)

; Consider the following procedures,
; where A is the procedure defined above:

(define (f n) (A 0 n))

(define (g n) (A 1 n))

(define (h n) (A 2 n))

(define (k n) (* 5 n n))

; Give concise mathematical definitions
; for the functions computed by the procedures
; f, g, and h for positive integer values of n.
; For example, (k n) computes $5n^2$.

; Answer:

; (A 1 10)
; (A 0 (A 1 9))
; (A 0 (A 0 (A 1 8)))
; (A 0 (A 0 (... A 1 2))) ; 10 times
; (* 2 ... (* 2 y)) ; 10 times
; finally get 1024

; (A 2 4)
; (A 1 (A 2 3))
; (A 1 (A 1 (A 2 2)))
; (A 1 (A 1 (A 1 (A 2 1))))
; (A 1 (A 1 (A 1 2)))
; (A 1 (A 1 (A 0 (A 1 1))))
; (A 1 (A 1 (A 0 2)))
; (A 1 (A 1 4))
; (A 1 16)
; 2^16 = 65536

; (A 3 3)
; (A 2 (A 3 2))
; (A 2 (A 2 (A 3 1))
; (A 2 (A 2 2)) ; we have calculated (A 2 2) before
; (A 2 4) ; we have calculated (A 2 4) before
; 65536

; for f: (A 0 n)
; we get $2n$
; for g: (A 1 n)
; we get $2^n$
; for h: (A 2 n)
; we get $2^{2^(2^...) (n - 1) times}$

; Let's check
(require rackunit)
(for ([n (in-range 1 101)])
  (check-equal? (f n) (* 2 n)
                (format "f(~a) should be 2×~a" n n)))
(for ([n (in-range 1 10)])
  (check-equal? (g n) (expt 2 n)
                (format "g(~a) should be 2^~a" n n)))

(define (helper n)
  (if (= 0 n) 1
      (expt 2 (helper (sub1 n)))))

(for ([n (in-range 1 6)])
  (check-equal? (h n) (helper n)))
