Link: https://archive.org/details/ucberkeley_webcast_nzMPF59Ackg

---

processing deep lists.

EVERYTHING IS DATA.

This calculator is the first step to our scheme interpreter.

There are three pieces to an interpreter:
1. read-eval-print loop (repl). It runs forever.
2. Evaluates expressions
	- Scheme has self-evaluating expressions (numbers, bools)
	- And variables (not in our calculator)
	- And function calls
	- And special forms (also not something we have.)
3. Apply a function to arguments.

map recursive calls are the secrect to dealing with deep lists -- making a recursive call for each element of the top level list.