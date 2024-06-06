# Linux - Informal guide to basic command informations

> "I'm using a Linux terminal and need to retrieve some system information or perform a quick task via the command line. Can you help?"

## Get information from a command

Suppose you have a command (e.g. `uname`).

First of all, anytime you have to understand a command, look at the help or man information.

```sh
uname -h
uname --help
man uname
info uname
apropos uname
```

## Locate a command (or script) with `which`

The `which` command is used to locate the executable file associated with a given command in the directories listed in the environment variable `PATH`.

```sh
which -a uname
```
Output
```
/usr/bin/uname
/bin/uname
```

## Examine the executables with `which` and `file`

Given the location of the executables, we can examine other information by running the `file` command.

```sh
file $(which -a uname) | tr ',' '\n'
```
Remind to check the privilegies.
```sh
ls -l $(which -a uname)
```



### More on `which`

Somtimes we need more manual work. Let's find information on `which` itself.

```sh
file $(which -a which) | tr ',' '\n'
```
Output
``` 
/usr/bin/which: symbolic link to /etc/alternatives/which
/bin/which:     symbolic link to /etc/alternatives/which
```

Let's find what are these alternatives
```sh
file /etc/alternatives/which | tr ',' '\n'
# /etc/alternatives/which: symbolic link to /usr/bin/which.debianutils
file /usr/bin/which.debianutils | tr ',' '\n'
# /usr/bin/which.debianutils: POSIX shell script
#  ASCII text executable
```

ASCII text, we can read easly the source with `cat /usr/bin/which.debianutils`

``` { .sh linenums="1"}
#! /bin/sh
set -ef

if test -n "$KSH_VERSION"; then
	puts() {
		print -r -- "$*"
	}
else
	puts() {
		printf '%s\n' "$*"
	}
fi

ALLMATCHES=0

while getopts a whichopts
do
        case "$whichopts" in
                a) ALLMATCHES=1 ;;
                ?) puts "Usage: $0 [-a] args"; exit 2 ;;
        esac
done
shift $(($OPTIND - 1))

if [ "$#" -eq 0 ]; then
 ALLRET=1
else
 ALLRET=0
fi
case $PATH in
	(*[!:]:) PATH="$PATH:" ;;
esac
for PROGRAM in "$@"; do
 RET=1
 IFS_SAVE="$IFS"
 IFS=:
 case $PROGRAM in
  */*)
   if [ -f "$PROGRAM" ] && [ -x "$PROGRAM" ]; then
    puts "$PROGRAM"
    RET=0
   fi
   ;;
  *)
   for ELEMENT in $PATH; do
    if [ -z "$ELEMENT" ]; then
     ELEMENT=.
    fi
    if [ -f "$ELEMENT/$PROGRAM" ] && [ -x "$ELEMENT/$PROGRAM" ]; then
     puts "$ELEMENT/$PROGRAM"
     RET=0
     [ "$ALLMATCHES" -eq 1 ] || break
    fi
   done
   ;;
 esac
 IFS="$IFS_SAVE"
 if [ "$RET" -ne 0 ]; then
  ALLRET=1
 fi
done

exit "$ALLRET"
```

The script just look if the `$PROGRAM` passed as argument is present in the `$PATH` variable splitted by `IFS=:`.

It checks if `$PROGRAM` exists as regular file (`-f`) and is executable (`-x`).

If yes it print the location of the file.



## Alternatives: `type` and `command`

If we run `which -a type` nothing happend, but if we run `type -a which` we got results.

```
which is /usr/bin/which
which is /bin/which
# ... and we know it
```

It seams `type` is *stronger* than `which`, in some sense.
So let's run `type -a type` to understand something.

```sh
type -a type
# type is a shell builtin
```

Similar is the `command -V type` output

```sh
command -V type
# type is a shell builtin
```



## List all shell builtin

```sh
$ compgen -b | tr '\n' ' '
# . : [ alias bg bind break builtin caller cd command compgen complete compopt continue declare dirs disown echo enable eval exec exit export false fc fg getopts hash help history jobs kill let local logout mapfile popd printf pushd pwd read readarray readonly return set shift shopt source suspend test times trap true type typeset ulimit umask unalias unset wait
```

## Summary

#### `which`

- **Purpose:** Locates the executable file associated with a command.
- **Usage:** `which -a command_name`
- **Example:** `which -a grep`
- **Output:** Path of the executable, e.g.
```
/usr/bin/grep
/bin/grep
```

#### `type`

- **Purpose:** Displays information about how a command name is interpreted.
- **Usage:** `type -a command_name`
- **Example:** `type -a grep`
- **Output:** Type of command (alias, function, builtin, or file) and its location if it's a file, e.g. 
```
grep is aliased to `grep --color=auto'
grep is /usr/bin/grep
grep is /bin/grep
```


#### `command`

- **Purpose:** Executes a command, bypassing shell functions and builtins or display information about commands.
- **Usage:** `command -V command_name`
- **Example:** `command -V grep`
- **Output:** Verbose description of the executable, e.g. 
```
grep is aliased to 'grep --color=auto'
```


### Other Useful Commands

- **`whereis`**
  - **Purpose:** Locates the binary, source, and manual page files for a command.
  - **Usage:** `whereis command_name`
  - **Example:** `whereis grep`
  - **Output:** Paths of the binary, source, and man page, e.g.
```
grep: /usr/bin/grep /usr/share/man/man1/grep.1.gz /usr/share/info/grep.info.gz
```

- **`locate`**
  - **Purpose:** Searches for files and directories by name.
  - **Usage:** `locate filename`
  - **Example:** `locate bashrc`
  - **Output:** All paths matching the filename, e.g., `/home/user/.bashrc`.

- **`find`**
  - **Purpose:** Searches for files and directories in a directory hierarchy.
  - **Usage:** `find path -name filename`
  - **Example:** `find / -name "myfile.txt"`
  - **Output:** Paths of all matching files and directories.

