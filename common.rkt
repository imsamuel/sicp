#lang racket/base

(provide square cube even? double halve)

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