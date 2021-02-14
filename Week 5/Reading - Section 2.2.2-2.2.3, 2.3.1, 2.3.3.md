# Reading Week 5
---

*Trees* as sequences of sequences

**`cons`**  vs  **`list`**  vs **`append`**:
- `cons` makes a pair out of two elements. if the second element is a list (which is already made of pairs), the first element becomes the first element in a new list containing it and the elements of the second argument.
- `list` makes a list out of two elements
- `append` takes two lists and makes them one list.

Though that description of `cons` above is a bit convoluted, it makes sense as all lists are built from pairs. Though the notation is slightly different from the interpreter, the idea of "take two elements and make them a pair" when we remember that a list, at any point by the end, is a pair between the first element and the rest.

just as `map` is a powerful tool for processing lists, `map` but with recursion is a powerful tool for processing trees.