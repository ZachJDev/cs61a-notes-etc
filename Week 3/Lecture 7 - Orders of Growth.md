Link: https://archive.org/details/ucberkeley_webcast_32L5j10rrK0

---

Yay, the midterm has a room assignment!

Efficiency. Today is time, next lecture is space.

How do we measure time efficiency? 

Not with a stopwatch -- not all computers are the same and an old computer or a computer running a lot of processes will not run any algorithm as quick as a new, lean computer.

We ask: **"how many constant-time operations take place?"**

Orders of Growth refers to how many more calculations will take palce when we increase the domain size of a function?

#### The Big Theta Equation:

   f(x) = Θ(g(x)) ⇔ ∃k, N | ∀x > N, |f(x)| ≤ k · |g(x)|
   
   Alas, I can't make much of this right now (I see some logical operations, but I don't know what the pipes are... 
   
I really like the *Programming Pearls* example about the Cray-1 vs the TRS-80.

Always keep the domain and range in mind when creating algorithms and procedures.

cosntant factors aren't interesting and we can safely ignore them when determining running time. -- Any factor will always be exactly the same size, no matter how big or small the input is.

oohhh, Brian Harvey is calling out how I learned big-O. The notation most of us use is incorrect and doesn't *really* explain what's happening. But the notation has some Set theory symbols I don't know how to type.