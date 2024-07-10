# BASH - Random number from terminal

> "In the bash terminal, I'm looking for a quick way to grab a random number for either tossing into a variable or just using on the fly. Any cool hacks for that?"

## Use the variable `RANDOM`

The variable `RANDOM` is a built-in environment variable that generates a random integer between 0 and 32767 (2^15-1).
The number 32767 is the two's complement, max positive signed number on 16-bit.

```bash
# built-in environment variable
echo $RANDOM

# 1-digit random number between 0 and 9
echo ${RANDOM:0:1}
# 0 is less frequent than others, try and look:
# for i in {1..100000}; do echo "${RANDOM:0:1} "; done | grep '0'

# 2-digit random number between 0 and 99 
echo ${RANDOM:0:2} 
# (2-digit numbers are more frequent), try and look:
# for i in {1..1000}; do echo "${RANDOM:0:2} "; done | xargs -n50

# Range 1 to 100
echo $(( $RANDOM % 100 + 1 ))
```

- `$RANDOM` depends on its initialization, more entropy with `RANDOM=$(date +%N)`



## Use the `date` command

The `date` command is used to display the current date and time or to set the system date and time.
Using the option to display nanoseconds and/or seconds we hack the randomness.

```bash
# current time in nanoseconds (9 digits ranging from 000000000 to 999999999)
date +%N

# adding the 2-digits of the current seconds (range from 00 to 59)
date +%N%S

# adding digits of the number of seconds since the Unix epoch, which is January 1, 1970, at 00:00:00 UTC
# 19-digit number 
date +%N%s
date +%s%N
# 10-digit number 
date +%s%N | cut -b10-19

# capture and store the output in a variable
N=$(date +%N%s)
```

## Use the `shuf` command

The `shuf` command in Bash is used to generate random permutations of input lines or to select random lines from a file, but can be used also to generate random numbers.

```bash
# Generate 5 random numbers from 10-20 (extreme included)
shuf -i 10-20 -n 5

# Shuffle lines in a file:
# shuf filename.txt
head bash-random.md | shuf

# Select 2 random lines from a file
# shuf -n 2 filename.txt
head bash-random.md | shuf -n 2
```