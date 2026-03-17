#lang lazy

; Exercise 1.20.
; The process that a procedure generates is of course
; dependent on the rules used by the interpreter.
; As an example, consider the iterative gcd procedure
; given above. Suppose we were to interpret this procedure
; using normal-order evaluation, as discussed in section 1.1.5.
; (The normal-order-evaluation rule for if is
; described in exercise 1.5.) Using the substitution method
; (for normal order), illustrate the process generated in
; evaluating (gcd 206 40) and indicate the remainder operations
; that are actually performed. How many remainder operations are
; actually performed in the normal-order evaluation of
; (gcd 206 40)? In the applicative-order evaluation?

; Answer
; Normal order:
; we need to calculate b each time to check
; whether it is zero.
; (gcd 206 40)
; (gcd 40 (remainder 206 40)) => 1 times
; (gcd (remainder 206 40)
;      (remainder 40 (remainder 206 40))) => 2 times
; (gcd (remainder 40 (remainder 206 40))
;      (remainder
;         (remainder 206 40)
;         (remainder 40 (remainder 206 40)))) => 3 times
; (gcd (remainder
;         (remainder 206 40)
;         (remainder 40 (remainder 206 40)))
;      (remainder
;         (remainder 40 (remainder 206 40))
;         (remainder
;           (remainder 206 40)
;           (remainder 40 (remainder 206 40))))) => 11 times
; 
; Total: 1 + 2 + 3 + 11 = 18 times.
; However, in practical (lazy evaluation),
; the calculation times is 4,
; because the b is actually a pointer to a Thunk,
; b will not be evaluated twice in each recursion.
; We can test it:

(define rem-times 0)
(define (my-rem a b)
  (set! rem-times (add1 rem-times))
  (remainder a b))
(define (gcd a b)
  (if (zero? b) a
      (gcd b (my-rem a b))))
(gcd 206 40)
(printf "Calculate ~a times.~n" rem-times)

; And applicative-order is the default order for if
; we will calculate 4 times of remainder.
