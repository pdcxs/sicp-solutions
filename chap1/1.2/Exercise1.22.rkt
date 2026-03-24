#lang racket

; Exercise 1.22.
; Most Lisp implementations include a primitive called runtime
; that returns an integer that specifies the amount of time the
; system has been running (measured, for example, in microseconds).
; The following timed-prime-test procedure, when called with
; an integer n, prints n and checks to see if n is prime.
; If n is prime, the procedure prints three asterisks followed
; by the amount of time used in performing the test.

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))
(define (start-prime-test n start-time)
  (when (prime? n)
    (report-prime (- (current-inexact-milliseconds)
                     start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; === functions in book start ===
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (square x) (* x x))
(define (prime? n)
  (= n (smallest-divisor n)))
; === functions in book end ===

; Using this procedure, write a procedure search-for-primes that
; checks the primality of consecutive odd integers in a specified range.
; Use your procedure to find the three smallest primes larger than 1000;
; larger than 10,000; larger than 100,000; larger than 1,000,000.
; Note the time needed to test each prime. Since the testing algorithm
; has order of growth of $\Theta(\sqrt{n})$, you should expect that testing for primes
; around 10,000 should take about $\sqrt{10}$ times as long as testing for primes
; around 1000. Do your timing data bear this out?
; How well do the data for 100,000 and 1,000,000 support the $\sqrt{n}$ prediction?
; Is your result compatible with the notion that programs on your machine
; run in time proportional to the number of steps required for the computation?

; Answer

(define (find-smallest-primes-from n)
  (timed-prime-test n)
  (find-smallest-primes-from (get-next-odd n)))
(define (get-next-odd n)
  (if (odd? (+ 1  n))
      (+ 1 n)
      (+ 2 n)))

; In my computer, I run (find-smallest-primes-from 1000) and get:
; 1000
; 1001
; 1003
; 1005
; 1007
; 1009 *** 0.0009765625
; 1011
; 1013 *** 0.000732421875
; 1015
; 1017
; 1019 *** 0.000732421875
; The average time is: 0.000813802
; Then the average time for 10000 is: 0.00252279
; The times is 3.1.
; The average time for 100000 is: 0.00667318
; The times is 2.6.
; The are all around $\sqrt{10}$, which is 3.16.
; The average time for 1000000 is: 0.0232747,
; the times is 3.49, still around 3.1.