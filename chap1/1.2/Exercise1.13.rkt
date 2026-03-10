#lang racket

; Exercise 1.13.
; Prove that $Fib(n)$ is the closest integer to $\phi^n/\sqrt 5$,
; where $\phi=(1+\sqrt 5)/2$.
; Hint: Let $\varphi=(1-\sqrt 5)/2$.
; Use induction and the definition of the
; Fibonacci numbers (see section 1.2.2) to
; prove that $Fib(n)=(\phi^n-\varphi^n)/\sqrt 5$.

; Answer
; When $n = 0$, we get
; $Fib(0) = (\phi^0 - \varphi^0)/\sqrt5 = 0$
; When $n = 1$, we get
; $Fib(1) = (\phi - \varphi)/\sqrt5 = 1$
; Then assume $Fib(n) = (\phi^n-\varphi^n)/\sqrt 5$
; and $Fib(n-1) = (\phi^{n-1}-\varphi^{n-1})/\sqrt 5$
; Then:
; $$
; \begin{array}{rcl}
; Fib(n+1) & = & Fib(n)+Fib(n-1) \\
;  & = & (\phi^n - \varphi^n + \phi^{n-1} - \varphi^{n-1})/\sqrt 5\\
;  & = & (\phi^{n-1}(1+\phi)-\varphi^{n-1}(1+\varphi))/\sqrt 5\\
;  & = & (\phi^{n-1}(3+\sqrt 5)/2-\varphi^{n-1}(3-\sqrt 5)/2)/\sqrt 5\\
;  & = & (\phi^{n-1}\phi^2-\varphi^{n-1}\varphi^2)/\sqrt5\\
;  & = & (\phi^{n+1}-\varphi^{n+1})/\sqrt5
; \end{array}
; $$
; Because $\phi^2=(3+\sqrt 5)/2$ and $\varphi^2=(3-\sqrt5)/2$

; $abs(\varphi^n/\sqrt 5)$ gets to 0.
; So (\phi^n/\sqrt 5) has to closer to $Fib(n)$ to make this
; equation correct. When $n < 10$, the assumption is right,
; the assumption should keep right when $n$ becomes larger
; As $\phi^n/\sqrt5 - Fib(n) = \varphi^n/\sqrt5$

; Let's test:

(define (fib n)
  (define (helper n a b)
    (cond [(= n 0) a]
          [(= n 1) b]
          [else (helper (sub1 n)
                        b (+ a b))]))
  (helper n 0 1))

(define phi (/ (+ 1 (sqrt 5.0)) 2))
(for ([i (in-range 30)])
  (displayln (abs (- (fib i)
                     (/ (expt phi i) (sqrt 5.0))))))

; The error should become less in each iteration.