# HackyTricks
Tips and tricks on coding, or something similar ...

## Random number from terminal
#### Issue
In the bash terminal, I'm looking for a quick way to grab a random number for either tossing into a variable or just using on the fly. Any cool hacks for that?
#### Solution(s)
The variable `$RANDOM` is a built-in environment variable that generates a random integer between 0 and 32767 (2^15-1).
The number 32767 is the two's complement, max positive signed number on 16-bit.
```bash
echo $RANDOM
```
