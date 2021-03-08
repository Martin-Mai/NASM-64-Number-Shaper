# NASM-64-Skeleton-Shaper

## Program Explanation:
1. It defines an integer **array** of length 8, its name is up to you, but here I will call it **array**, and the skeleton program **fproj_skel.asm** also uses the name array.
2. The array **array** is randomly initialized to the values from 1 to 8 by the call to **rperm**, see the skeleton program **fproj_skel.asm**.
3. Then in an infinite loop, **array** is displayed on the screen by a subroutine **display**.
4. At the bottom of the screen the user is prompted to either enter a pair of values **i** and **j** from the range 1 to 8 or 0.
If 0 is enter, the loop is terminated, and then the program terminates.
If a pair of values **i** and **j** is entered, then in **array** the item containing the value **i** is swapped with the item containing the value **j**, and the loop is repeated.
5. The subroutine **display** has two parameters passed on the stack, one is the address of the array **array**, and the other is the size of the array, in this case 8.
6. The subroutine **display** traverses the array and displays the value in each item of the array in a form of a box, for better understanding see the execution of **fproj.py**. It also must display the numberic value of the box underneath.
7. The box of size 1 looks like this
8. The box of size 2 looks like this
9. The box of size 3 looks like this
10. The box of size 4 looks like this
11. The box of size 5 looks like this
12. The box of size 6 looks like this
13. The box of size 7 looks like this
14. The box of size 8 looks like this
15. The boxes are displayed adjusted to the same level at the bottom, side by side. Thus, the subroutine **display** must display it from top to bottom, one line at a time. So, **display** must loop **n** times, where **n** is the length of the input array. In this loop, it must prepare a line, and then displays it -- i.e **n** lines from top to bottom. For each line, it must figure out what to put in the line for each item of the array, i.e. must loop **n** times for each item of the array. For instance:
