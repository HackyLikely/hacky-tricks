# HackyTricks
Tips and tricks on coding, or something similar ...

## Random number from terminal

#### Issue
In the bash terminal, I'm looking for a quick way to grab a random number for either tossing into a variable or just using on the fly. Any cool hacks for that?

#### Solution(s)

The variable `RANDOM` is a built-in environment variable that generates a random integer between 0 and 32767 (2^15-1).
The number 32767 is the two's complement, max positive signed number on 16-bit.
```bash
# built-in environment variable
echo $RANDOM
```

The `date` command is used to display the current date and time or to set the system date and time.
Using the option to display nanoseconds and/or seconds we hack the randomness.
```bash
# current time in nanoseconds (9 digits ranging from 000000000 to 999999999)
date +%N
# adding the 2-digits of the current seconds (range from 00 to 59)
date +%N%S
# adding digits of the number of seconds since the Unix epoch, which is January 1, 1970, at 00:00:00 UTC
date +%N%s
# capture and store the output in a variable
N=$(date +%N%s)
```