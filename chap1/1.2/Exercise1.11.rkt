#lang racket

; Exercise 1.11.
; A function f is defined by the rule that f(n) = n if n<3
; and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n>3.
; Write a procedure that computes f by means of
; a recursive process. Write a procedure that computes
; f by means of an iterative process.

; Answer

(define (rec-f n)
  (if (< n 3) n
      (+ (rec-f (- n 1))
         (* 2 (rec-f (- n 2)))
         (* 3 (rec-f (- n 3))))))

(define (iter-f n)
  (define (helper n a b c)
    (cond [(= n 0) a]
          [(= n 1) b]
          [(= n 2) c]
          [else
           (helper (sub1 n)
                   b
                   c
                   (+ c (* 2 b) (* 3 a)))]))
  (helper n 0 1 2))

; Let's test:
(require rackunit)
(for ([i (in-range 20)])
  (check-eq? (rec-f i) (iter-f i)))