# 1.1 The Elements of Programming 

**Applicative order versus normal order**

According to the description of evaluation given in [1.1.3](https://sarabander.github.io/sicp/html/1_002e1.xhtml#g_t1_002e1_002e3), the interpreter first evaluates the operator and operands and then applies the resulting procedure to the resulting arguments. This is not the only way to perform evaluation. An alternative evaluation model would not evaluate the operands until their values were needed. Instead it would first substitute operand expressions for parameters until it obtained an expression involving only primitive operators, and would then perform the evaluation. If we used this method, the evaluation of `(f 5)` would proceed according to the sequence of expansions

```scheme
(sum-of-squares (+ 5 1) (* 5 2))

(+ (square (+ 5 1)) 
   (square (* 5 2)))

(+ (* (+ 5 1) (+ 5 1)) 
   (* (* 5 2) (* 5 2)))
```

followed by the reductions

```scheme
(+ (* 6 6) 
   (* 10 10))

(+ 36 100)

136
```

This gives us the same answer as our previous evaluation model, but the process is different. In particular, the evaluations of `(+ 5 1)` and `(* 5 2)` are each performed twice here, corresponding to the reduction of the expression `(* x x)` with `x` replaced respectively by `(+ 5 1)` and `(* 5 2)`.

This alternative "fully expand and then reduce" evaluation method is known as *normal-order evaluation*, in contrast to the "evaluate the arguments and then apply" method that the interpreter actually uses, which is called *applicative-order evaluation*. It can be shown that, for procedure applications that can be modeled using substitution and that yield legitimate values, normal-order and applicative-order evaluation produce the same value.

Lisp uses applicative-order evaluation, partly because of the additional efficiency obtained from avoiding multiple evaluations of expressions such as those illustrated with `(+ 5 1)` and `(* 5 2)` above and, more significantly, because normal-order evaluation becomes much more complicated to deal with when we leave the realm of procedures that can be modeled by substitution. On the other hand, normal-order evaluation can be an extremely valuable tool and we will investigate some of its implications in [Chapter 3](https://sarabander.github.io/sicp/html/Chapter-3.xhtml#Chapter-3) and [Chapter 4](https://sarabander.github.io/sicp/html/Chapter-4.xhtml#Chapter-4).

**Normal-order evaluation in-depth**

()

Normal-order evaluation goes "fully expand and then reduce", meaning that function calls are expanded before reducing the arguments. and the reduction only happens when the value is needed. Let's take one of the examples in the book: start from `(sum-of-squares (+ 5 1) (* 5 2))`. First, we fully expand the definition of `sum-of-squares`:

```scheme
(sum-of-squares (+ 5 1) (* 5 2)) → (+ (square (+ 5 1)) (square (* 5 2)))
```

Since `+` is a primitive, we can't expand it. It requires integers as arguments, so here we have no choice: we must reduce the arguments. To reduce `(square (+ 5 1))` in normal order, we start by expanding:

```scheme
(square (+ 5 1)) → (* (+ 5 1) (+ 5 1))
```

Then we have the primitive `*` also requiring integers as arguments, so we must reduce the arguments.

```scheme
(+ 5 1) → 6
(+ 5 1) → 6
```

and so

```scheme
(* (+ 5 1) (+ 5 1)) →→ (* 6 6) → 36
```

and likewise for `(square (* 5 2))`, so the original expression finally evaluates thus

```scheme
(+ (square (+ 5 1)) (square (* 5 2))) →→ (+ 36 100) → 136
```

In contrast, applicative-order evaluates the arguments when the function is applied, before expanding the function call. So to evaluate `(sum-of-squares (+ 5 1) (* 5 2))`, we first need to evaluate the arguments:

```scheme
(+ 5 1) → 6
(* 5 2) → 10
```

and then we can expand the function call:

```scheme
(sum-of-squares (+ 5 1) (* 5 2)) →→ (sum-of-squares 6 10)
                                 → (+ (square 6 6) (square 10 10))
```

The next step is to evaluate the arguments of `+`; they're function calls, and in each case the arguments are already fully evaluated so we can perform the function call right away:

```scheme
(square 6 6) → (* 6 6) → 36
(square 10 10) → (* 10 10) → 100
```

and finally

```scheme
(+ (square 6 6) (square 10 10)) →→ (+ 36 100) → 136
```

**An example with side effects**

The order of evaluation doesn't make any difference when the expressions have no side effect. Side effects change the deal. Let's define a function with a

```scheme
(define (tracing x)
  (write x)
  x)
```

If we evaluate `(square (tracing 2))` in applicative order then the argument is evaluated only once:

```scheme
(tracing 2) → 2 [write 2]
(square (tracing 2)) → (square 2) [write 2]
                     → (* 2 2)
                     → 4
```

In normal order, the argument is evaluated twice, so the trace is shown twice.

```scheme
(square (tracing 2)) → (* (tracing 2) (tracing 2))
(tracing 2) → 2 [write 2]
(tracing 2) → 2 [write 2]
(* (tracing 2) (tracing 2)) →→ (* 2 2) [write 2, write 2]
```

