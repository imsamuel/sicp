# 1.2 Procedures and the Processes They Generate

**Recursion and Iteration**

Recursive processes reveal a shape of expansion followed by contraction. The expansion occurs as the process builds up a chain of *deferred operations*. The contractions occur as the operations are actually performed. This type of process, characterized by a chain of deferred operations, is called a *recursive process*. Carrying out this process requires that the interpreter keep track of the operations to be performed later on. In the computation of *n*! (*factorial of n*), the length of the chain of deferred multiplications, and hence the amount of information needed to keep track of it, grows linearly with *n* (is proportional to *n*), just like the number of steps. Such a process is called a *linear recursive process*.

By contrast, an iterative process does not grow and shrink. At each step (for factorial), all we need to keep track of, for any *n*, are the current values of the variables *product*, *counter*, and *max-count*. We call this an *iterative process*. In general, an iterative process is one whose state can be summarized by a fixed number of *state variables*, together with a fixed rule that describes how the state variables should be updated as the process moves from state to state and an (optional) end test that specifies conditions under which the process should terminate. In computing *n*!, the number of steps grows linearly with *n*. Such a process is called a *linear iterative process*.

**Procedure vs Process**

> Procedures in the sense of SICP is the code you write, even if you may call that code functions or classes, if the code defines operations on data and isn't the data itself.

> The contrast between a procedure and process is similar to programs in your computer's hard drive and in it's RAM. A program stored in a file is an executable. On the other hand a script, or a program that you launched is a process. How that process behaves depends on the procedure that defines it, the environment in which it runs, available resources, and the type of evaluation model (normal order and applicative order evaluation will generate different processes for the same procedure). For example, a small finite procedure could produce an infinite process or a process that fails to continue because of a lack of resources (regarding available resources). 
>
> &mdash; <cite>[Bunyk](https://stackoverflow.com/a/65519063)</cite> (on Stack Overflow)

In contrasting iteration and recursion, we must be careful not to confuse the notion of a recursive *process* with the notion of a recursive *procedure*. When we describe a procedure as recursive, we are referring to the syntactic fact that the procedure definition refers (either directly or indirectly) to the procedure itself. But when we describe a process as following a pattern that is, say, linearly recursive, we are speaking about how the process evolves, not about the syntax of how a procedure is written. It may seem disturbing that we refer to a recursive procedure such as `fact-iter` as generating an iterative process. However, the process really is iterative: Its state is captured completely by its three state variables, and an interpreter needs to keep track of only three variables in order to execute the process.

**Iteration via Tail Recursion**

A process is *iterative* if it can be expressed as a sequence of steps that is repeated until some stopping condition is reached.

*Tail recursion* is a special form of recursion where the **last** operation of a procedure is a recursive call (no pending operations after the call). The recursion may be optimized away by executing the call in the current stack frame and returning its result rather than creating a new stack frame. When all recursive calls of a procedure are tail calls, it is said to be *tail-recursive*. A tail-recursive procedure is one way to specify an iterative process. Iteration is so common that most programming languages provide special constructs for specifying it, known as *loops*.

From [SICP](https://sarabander.github.io/sicp/html/1_002e2.xhtml#g_t1_002e2_002e1):

> One reason that the distinction between process and procedure may be confusing is that most implementations of common languages (including Ada, Pascal, and C) are designed in such a way that the interpretation of any recursive procedure consumes an amount of memory that grows with the number of procedure calls, even when the process described is, in principle, iterative. As a consequence, these languages can describe iterative processes only by resorting to special-purpose “looping constructs” such as `do`, `repeat`, `until`, `for`, and `while`. The implementation of Scheme we shall consider in [Chapter 5](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-30.html#%_chap_5) does not share this defect. It will execute an iterative process in constant space, even if the iterative process is described by a recursive procedure. An implementation with this property is called *tail-recursive*. With a tail-recursive implementation, iteration can be expressed using the ordinary procedure call mechanism, so that special iteration constructs are useful only as syntactic sugar.

**Tail-recursive algorithms in C vs Scheme**

Why write tail-recursive algorithms in Scheme, and not in other languages such as C?

While you can write tail-recursive algorithms in C, there is no guarantee that the generated code will not allocate additional stack memory at each tail call. This is exactly what happened in virtually all historic C implementations, making tail recursion impractical.

In modern C this is a quality of implementation issue. For example, GCC has been able to optimize many instances of tail recursion into equivalent iteration for many years now. Still, the key difference in comparison to Scheme is that Scheme **guarantees** tail call elimination, while C doesn't and is unlikely to do so.


