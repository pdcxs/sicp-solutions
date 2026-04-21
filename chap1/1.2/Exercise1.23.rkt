#lang racket

; Exercise 1.23.
; The smallest-divisor procedure shown at the start of
; this section does lots of needless testing:
; After it checks to see if the number is divisible by 2
; there is no point in checking to see if it is divisible
; by any larger even numbers. This suggests that the values
; used for test-divisor should not be 2, 3, 4, 5, 6, ...,
; but rather 2, 3, 5, 7, 9, .... To implement this change,
; define a procedure next that returns 3 if its input is
; equal to 2 and otherwise returns its input plus 2.
; Modify the smallest-divisor procedure to use
; (next test-divisor) instead of (+ test-divisor 1).
; With timed-prime-test incorporating this modified
; version of smallest-divisor, run the test for each of
; the 12 primes found in exercise 1.22. Since this
; modification halves the number of test steps, you should
; expect it to run about twice as fast. Is this expectation
; confirmed? If not, what is the observed ratio of the
; speeds of the two algorithms, and how do you explain
; the fact that it is different from 2?

; Answer

; Let's first define the procedure

(define (smallest-divisor n next-func)
  (find-divisor n 2 next-func))
(define (find-divisor n test-divisor next-func)
  (cond [(> (* test-divisor test-divisor) n) n]
        [(zero? (remainder n test-divisor)) test-divisor]
        [else (find-divisor
               n
               (next-func test-divisor)
               next-func)]))
(define (smart-next n)
  (if (= n 2) 3 (+ 2 n)))
(define normal-next add1)

(define (prime? n next-func)
  (= n (smallest-divisor n next-func)))

(define (get-primes-from n num next-func)
  (if (zero? num) '()
      (let ([next-prime (get-prime n next-func)])
        (cons next-prime
              (get-primes-from
               (add1 n)
               (sub1 num)
               next-func)))))

(define (get-prime n next-func)
  (if (prime? n next-func) n
      (get-prime (add1 n) next-func)))

(define (get-time n num next-func)
  (define start-time (current-inexact-milliseconds))
  (get-primes-from n num next-func)
  (- (current-inexact-milliseconds) start-time))

; Modern CPU is very fast, we need large number
; to make the result stable.
(define from 10000000)
(define num 10000)
(define time1 (get-time from num smart-next))
(define time2 (get-time from num normal-next))
(/ time1 time2)
; In my computer, the result is about 0.6
; We need extra `if` to test whether n is 2.
; This will also need some time.
; Compared to calculate `test-divisor` mod `n`
; The extra calculation time cannot be ignored.