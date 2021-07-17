# 1.2 Procedures and the Processes They Generate

**Procedure vs Process**

> Procedures in the sense of SICP is the code you write, even if you may call that code functions or classes, if the code defines operations on data and isn't the data itself.

> The contrast between a procedure and process is similar to programs in your computer's hard drive and in it's RAM. A program stored in a file is an executable. On the other hand a script, or a program that you launched is a process. How that process behaves depends on the procedure that defines it, the environment in which it runs, available resources, and the type of evaluation model (normal order and applicative order evaluation will generate different processes for the same procedure). For example, a small finite procedure could produce an infinite process or a process that fails to continue because of a lack of resources (regarding available resources). 
> &mdash; <cite>[Bunyk](https://stackoverflow.com/a/65519063)</cite> (on Stack Overflow)

**Recursion and Iteration**

Recursive processes reveal a shape of expansion followed by contraction. The expansion occurs as the process builds up a chain of *deferred operations*. The contractions occur as the operations are actually performed. This type of process, characterized by a chain of deferred operations, is called a *recursive process*. Carrying out this process requires that the interpreter keep track of the operations to be performed later on. In the computation of *n*! (*factorial of n*), the length of the chain of deferred multiplications, and hence the amount of information needed to keep track of it, grows linearly with *n* (is proportional to *n*), just like the number of steps. Such a process is called a *linear recursive process*.

By contrast, an iterative process does not grow and shrink. At each step (for factorial), all we need to keep track of, for any *n*, are the current values of the variables *product*, *counter*, and *max-count*. We call this an *iterative process*. In general, an iterative process is one whose state can be summarized by a fixed number of *state variables*, together with a fixed rule that describes how the state variables should be updated as the process moves from state to state and an (optional) end test that specifies conditions under which the process should terminate. In computing *n*!, the number of steps grows linearly with *n*. Such a process is called a *linear iterative process*.

**Process vs Procedure**

In contrasting iteration and recursion, we must be careful not to confuse the notion of a recursive *process* with the notion of a recursive *procedure*. When we describe a procedure as recursive, we are referring to the syntactic fact that the procedure definition refers (either directly or indirectly) to the procedure itself. But when we describe a process as following a pattern that is, say, linearly recursive, we are speaking about how the process evolves, not about the syntax of how a procedure is written. It may seem disturbing that we refer to a recursive procedure such as `fact-iter` as generating an iterative process. However, the process really is iterative: Its state is captured completely by its three state variables, and an interpreter needs to keep track of only three variables in order to execute the process.

