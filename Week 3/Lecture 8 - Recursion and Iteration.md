Link: https://archive.org/details/ucberkeley_webcast_0G3tNuBBO5I

---

 Searching algoritms: 
 - obvious algorithm =  Θ(N)
 -  smarter = Θ(log N)
 -  some = Θ(1)

 Sorting Algorithms:
 - obvious = Θ(N^2)
 - smarter = Θ(N log N)

Matrix Multiplication = Θ(N3)

Huge jump to Θ(2^N) or even Θ(N!) for permuation problems, other very taxing problems. These are *Intractable problems*

It is theoretically impossible to have a better sorting algorithm than theta(n log n) in cases where you are comparing two values (e.g., I think radix sort is faster and doesn't depend on comparisons).

### Space Efficieny

- recursive processes by definition store their entire call-frame / environment each time the process is called again. this can lead to a lot of used space.
- iterative processes (including those implemented with tail-call recursion) do not need to store any extra information, though easily-implemeneted recusive procedures are not nescesarily easy to convert to iterative processes.

Moral of this entire lecture: think hard about what's making your algorithm ineffienct, and work to improve the order of growth, not just fine-tuning a bad algorithm.

**"An ounce of mathematics is worth a pound of computer science."**

