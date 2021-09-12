#lang racket/base
; Modify the timed-prime-test procedure of Exercise 1.22 to use fast-prime?
; (the Fermat method), and test each of the 12 primes you found in that
; exercise. Since the Fermat test has Θ(logn) growth, how would you expect the
; time to test primes near 1,000,000 to compare with the time needed to test
; primes near 1000? Do your data bear this out? Can you explain any discrepancy
; you find?
(require "../common.rkt")

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (cond ((fast-prime? n 1)(report-prime (- (current-inexact-milliseconds)
                                    start-time)))))

(define (fast-prime? x times)
  (cond ((= times 0) #t)
        ((fermat-test x) (fast-prime? x
                                      (- times 1)))
        (else #f)))

(define (fermat-test x)
  (define y (random 2 x))
  (= (remainder (fast-expt y x) x) y))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))