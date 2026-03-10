#lang lazy
; #lang racket

; Ben Bitdiddle has invented a test to determine whether
; the interpreter he is faced with is using
; applicative-order evaluation or normal-order evaluation.
; He defines the following two procedures:

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

; Then he evaluates the expression

(test 0 (p))

; What behavior will Ben observe with an interpreter
; that uses applicative-order evaluation?
; What behavior will he observe with an interpreter
; that uses normal-order evaluation?
; Explain your answer.
; (Assume that the evaluation rule for the special
; form if is the same whether the interpreter is
; using normal or applicative order:
; The predicate expression is evaluated first,
; and the result determines whether to evaluate
; the consequent or the alternative expression.)

; Answer:

; If the evaluation of the interpreter is applicative-order,
; then (test 0 (p)) will first evaluates 0 and (p), where
; (p) where recursively call (p) again and again with no ending.
; As a result, it will never ends.

; If the evaluation of the interpreter is normal-order,
; then (test 0 (p)) will first expand to:
; (if (= 0 0) 0 (p))
; and because of the special evaluation order of if
; this expression will be evaluated to:
; (if #t 0 (p))
; and then:
; 0
; the result should be 0.

; We can change the first line of this file from
; #lang racket
; to
; #lang lazy
; to see the difference.