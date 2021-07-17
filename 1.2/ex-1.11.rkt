#lang racket/base
; A function f is defined by the rule that
; f(n)= n if n < 3 and f(n) = f(n - 1) + 2f(n - 2)+ 3f(n - 3) if n ≥ 3.
; Write a procedure that computes f by means of a recursive process.
; Write a procedure that computes f by means of an iterative process.
;
; (Couldn't come up with the iterative implementation of f, referred to
; https://stackoverflow.com/questions/2365993/no-idea-how-to-solve-sicp-exercise-1-11)

(define (f-recursive n)
  (cond ((< n 3) n)
        (else (+ (f-recursive (- n 1))
                 (* 2 (f-recursive (- n 2)))
                 (* 3 (f-recursive (- n 3)))))))

(define (f-iterative n)
   (if (< n 3)
       n
       (f-iterative-iter 2 1 0 n)))

(define (f-iterative-iter a b c count)
   (if (< count 3)
       a
       (f-iterative-iter (+ a (* 2 b) (* 3 c))
               a
               b
               (- count 1))))
