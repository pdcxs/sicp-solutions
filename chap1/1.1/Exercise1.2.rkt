#lang racket

; Exercise 1.2
; Translate the following expression into prefix form
; $$
; \frac{5+4+(2-(3-(6+\frac13)))}{3(6-2)(2-7)}
; $$

; Answer:

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 1 3))))) (* 3 (- 6 2) (- 2 7)))
; the result should be $-\frac{43}{180}$