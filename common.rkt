#lang racket/base

(provide square
         cube
         even?
         double
         halve
         fast-expt)

(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (even? n)
  (= (remainder n 2) 0))

(define (double x)
  (* 2 x))

(define (halve x)
  (/ x 2))

(define (fast-expt base expt)
  (cond ((= expt 0) 1)
        ((even? expt) (square (fast-expt base
                                         (/ expt 2))))
        (else (* base (fast-expt base
                                 (- expt 1))))))