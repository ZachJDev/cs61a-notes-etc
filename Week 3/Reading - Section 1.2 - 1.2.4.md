# Reading Three: 1.2- 1.2.4

"The Ability to visualize the consequences of the actions under consideration is crucial to becoming an expert programmer"

[[cs61a/Glossary | A Procedure]] is a pattern for the  *local evolution* of a computational process

This section will be about the "shapes" of processes and how they consume resources.

## 1.2.1: Linear Recursion and Iteration

consider the recursive and iterative processes for computing n!: they both need the same number of steps, but their shapes are quite different. (figs 1.3/4)

The recursuve process grows and shrinks, while the iterative process stays the same size constantly.

the recursive growth is an example of*deferred operations*, and the contraction occurs when they are actually performed. This means that the language interpreter needs to keep track of operations needed later.

"In general, an iterative process is one whose state can be summarized by a **fixed** number  of *state variables*, together with a fixed rulethat describes how the state variables should be updated as the process moves from state to state."

in the recusion example, the number deferred operations grows with `n` and in an iterative process, the number of steps requried to compute `n!` also grows with `n` These are known as *linear recursive/iterative processes*.

recursive processes and iterative processes are (slightly? a lot?) hardware dependent, but that's coming four chapters from now.

**A recursive process is NOT the same as a recursive procedure!!!!**
as the implementations make clear, both the iterative and recursive processes are implemented with recursion. These terms are useful for describing the shape of the process as it is run, not as it is defined.

I think the big take away is that iterative processes manage state.

apparently some langauges *can't* perform iterative processes with recursive procedures (like C or Ada), and must use looping constructs for iteration.

[[cs61a/Glossary | Tail Recursion]] is an implementation that does **not** have the above limitation -- all iterative processes will compute in constant space regardless of the procedure definition. [An Example in JS](https://stackoverflow.com/questions/33923/what-is-tail-recursion#37010).

## 1.2.2 Tree Recursion

surprise, surprise, Tree recursion looks like a tree!

consider a Fibonacci calculator `fib` that calls `(fib (- n 1))` and `(fib (- n 2))`. when mapped out, we can see that the two recursive calls result in a tree- like structure with the original call being the root with two branches.

In this Fib example, the number of required computations grows expotentially with `n`.

"In general, the number of steps required by a tree-recursive process will be proportional to the number of nodes in the tree, while the space required will be proportional to the maximum depth of the tree."

While  tree-recursion may not be worth it for numbers, it is very powerful for operations on heirarchial or tree-like structures. And the author makes a good point that the procedure resulting in the tree-recursive process is a very clear and straightforward translation of the Fib sequence into Lisp, while the iterative process is not nearly so. 

I'm trying to solve this `count-change`-but-better problem, and the first idea that I have is, like `fib` I'll want to start from the bottom and go up, just keeping in mind when I need to stop.

## 1.2.3 Orders of Growth

generalized big-O. (actually, a much more rigourous definition than I've been given in the past!) Because big-O (or Theta, in this case) notation will tell us that a procedure needing 10000n^2 resources is equivalent to one needing n^2 resources, it's more useful for predicting how a process will run with different inputs than for actual resource-usage computation.
