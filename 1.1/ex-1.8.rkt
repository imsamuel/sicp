#lang racket/base
; Newton's method for cube roots is based on the fact that if y is an 
; approximation to the cube root of x, then a better approximation is given by 
; the value (x/y^2 + 2y) / 3. Use this formula to implement a cube-root procedure 
; analogous to the square-root procedure.
(require "../common.rkt")

(define (improve guess x)
  (/ (+ (/ x
           (square guess))
        (* 2 guess))
     3))

(define (good-enough guess x)
  (< (abs (- x (cube guess))) 0.001))

(define (cbrt-iter guess x)
  (cond ((good-enough guess x) guess)
  (else (cbrt-iter (improve guess x) x))))

(define (cbrt x)
  (cbrt-iter 1 x))

