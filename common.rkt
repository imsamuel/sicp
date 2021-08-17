#lang racket/base

(provide square cube even?)

(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (even? n)
  (= (remainder n 2) 0))