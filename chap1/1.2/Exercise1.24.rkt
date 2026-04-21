#lang racket

; Exercise 1.24.
; Modify the timed-prime-test procedure of
; exercise 1.22 to use fast-prime?
; (the Fermat method), and test each of the
; 12 primes you found in that exercise.
; Since the Fermat test has $\Theta(\log n)$ growth,
; how would you expect the time to test primes
; near 1,000,000 to compare with the time needed
; to test primes near 1000? Do your data bear this out?
; Can you explain any discrepancy you find? 

(define (fast-prime? n times)
  (cond [(= times 0) #t]
        [(fermat-test n) (fast-prime? n (sub1 times))]
        [else #f]))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (big-random (sub1 n)))))

; we need random number in huge range
(define (big-random n)
  (define max-chunk 1000000000)
  (let loop [(result 0) (remaining (integer-length n))]
    (if (zero? remaining)
        (modulo result n)
        (loop (+ (* result max-chunk) (random max-chunk))
              (max 0 (- remaining (integer-length max-chunk)))))))

(define (expmod base exp m)
  (cond [(zero? exp) 1]
        [(even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m)]
        [else
         (remainder (* base (expmod base (sub1 exp) m)) m)]))

(define (square x) (* x x))

(define (get-time n test-times)
  (define start-time (current-inexact-milliseconds))
  (fast-prime? n test-times)
  (- (current-inexact-milliseconds) start-time))

(define time1 (get-time 100000007 1000))
(define time2 (get-time 100000000000000013 1000))
(/ time2 time1)
; Should be 2, but it acturall very unstable on my computer.
; But most of time it is greater than 2.
; Because large number multiplication will also need more time.