## Description

This repository contains the **mvgp** (group file renaming) command and support files.

## Version

This is the distribution of **mvgp** and **cpgp**, version 1.2, February 2000. This README.md file was updated in June of 2019.

## Conventions

In this README file, a dollar sign (**$**) followed by a space is used to signify the **bash** (or other Bourne-like shell) prompt.

## Introduction

**mvgp** renames or copies groups of files. As a quick example, suppose you have the following files from your digital camera in a directory:

```
IMG-20180323-45261.JPG
IMG-20180323-45262.JPG
IMG-20180323-45263.JPG
IMG-20180323-45264.JPG
IMG-20180323-45265.JPG
```

and you want more descriptive file names. The following command

```
$ mvgp  IMG-20180323-452  BellRock-24March2018-  *.JPG
```

will rename the files to

```
BellRock-24March2018-61.JPG
BellRock-24March2018-62.JPG
BellRock-24March2018-63.JPG
BellRock-24March2018-64.JPG
BellRock-24March2018-65.JPG
```

and then the command

```
$ mvgp  JPG  jpg  *.JPG
```

Changes the uppercase **JPG** extension to lowercase.

The first argument is what to change, the second is what to change it to, and the rest of the arguments are the names of files to rename or copy.

The first argument may use Bash's pattern matching operators to match a pattern, rather than a literal string. And of course, the list of files to rename or copy may be specified by the shell's file globbing operators (__*__, **?**, and **[]**).

## More Examples

Append **.txt** to the names of all files in the directory:

```
$ ls
abc  def  ghi  jkl
$ mvgp '%' .txt *
$ ls
abc.txt  def.txt  ghi.txt  jkl.txt
```

Prepend **filename.** to the names of all files starting with **a** or **d**:

```
$ ls
abc  def  ghi  jkl
$ mvgp '#' filename. [ad]*
$ ls
filename.abc  filename.def  ghi  jkl
```

Change every occurence of **a** to **o** in files starting with a **d**:

```
$ ls
aaa  abc  abe  backup  bad  cab  cabe  dab  dala  fab
$ mvgp -m a o d*
$ ls
aaa  abc  abe  backup  bad  cab  cabe  dob  dolo  fab
```

Change the three-character string of composed of any character, followed by an **a**, followed by any character, to **aoe** in the names of all files in the current working directory:

```
$ ls
aaa  abc  abe  backup  bad  cab  cabe  dob  dolo  fab
$ mvgp '?a?' aoe *
$ ls
abc  abe  aoe  aoee  aoekup  dob  dolo
```

Notice that this renamed three files to **aoe**, and as a result, two files were lost. Be careful; **mvgp** is a powerful command. If in doubt, use the **-C** (noclobber), **-I** (interactive), **-n** ("nop", or no operation) options to keep **mvgp** from performing unwanted actions.

## Installation

To install **mvgp** and **cpgp**, edit the **Makefile** to set **BINDIR** to the directory where you want **mvgp** and **cpgp** to be located, then run the command

```
$ sudo make install
```

(**sudo** is necessary only if you are copying to a system directory, or any other that your regular account does not have permission to write to.)

### Manual Page Installation

To install the manual page for **mvgp**, edit **Makefile** to set **MANDIR** to the directory where you want **mvgp** manual page to be located, then run this command:

```
$ sudo make install-man
```

## Documentation

Run the command `man mvgp` to read the manual page, or `mvgp -h` to read a manpage-like help document.

## Manual Page

A copy of the manual page is included here for convenience. To display it better, install it on your system and use a `man mvgp` command to view it.

```
MVGP(1)                          User Commands                         MVGP(1)



NAME
       mvgp - mvgp, cpgp

NAME
       mvgp - rename a group of files

       cpgp - make copies of a group of files

SYNOPSIS
       mvgp [-opts] pattern replacement files

       cpgp [-opts] pattern replacement files

DESCRIPTION
       mvgp(1)  and  cpgp(1) operate on a group of files, changing their names
       using a search-and-replace method specified by the first two non-option
       arguments (called pattern and replacement above).

       mvgp  renames  files, identically to the mv(1) command, and cpgp copies
       files in a manner identical to the cp(1) command.

       pattern is the substring that exists in the files´ names, that is to be
       replaced  with  replacement.  pattern and replacement may contain slash
       characters that will be interpreted as directory path specifiers.

SPECIFYING PATTERNS
       pattern is treated as a pattern that can match parts of file  names  in
       the  argument  list using the *, ? and [] metacharacters. This matching
       happens after the shell has created a list of filenames, which may also
       involve expanding metacharacters.

       If  the  pattern begins with a #, it must match at the beginning of the
       file name. If the pattern begins with a %, it must match at the end  of
       the  file name. See the section on "Parameter Expansion" in the bash(1)
       manual page for details.

OPTIONS
       -b, -f, -i, -S suffix, -u, -V word  (mvgp or cpgp)
       -a, -d, -l, -p, -P, -r, -R, -s, -x  (cpgp only)
           These are passed directly through to the mv or cp command,
           which does the actual renaming or copying of files. See
           mv(1) and cp(1) for documentation on these.

       -C  Noclobber. Don´t replace files that already exist.

       -h  Show this help message.

       -I  Interactive - ask for permission before renaming or copying.
           The the operation that is about to be performed is printed,
           followed by a ´?´. Valid responses are:

               y, Y, Yes, yes, YES: Go ahead and rename or copy
                   the file.
               n, N, No, no, NO: Skip the file.
               a, A, All, all, ALL: Perform this renaming or copying,
                   and all others that follow (exit -I mode).
               q, Q, Quit, quit, QUIT: Don´t rename or copy this file
                   or any others that follow. (Exit the program.)

           All other responses are treated as a ´no´. The response
           must be followed by a press of the Enter (Return) key.

       -L  (Loud) Report what mv or cp operations are performed, using
           the exact syntax of the mv or cp command that was executed.

       -m  Perform multiple substitutions. If pattern exists more
           than once in the original file name, it will be replaced
           for each occurrence. Without the -m option, only the first
           occurrence will be replaced.

       -n  Don´t rename or copy files; just tell what would be done.
           (Show the exact mv or cp commands that would execute.)

       -v  Report release version of mvgp/cpgp and the mv or cp command.
           Don´t do anything else.

EXAMPLES
       Example 1: Inserting

           $ cpgp txt bak.txt book*

       Make backup files of all files whose names start with "book". The  sub‐
       string  "txt" in the files´ names is replaced with "bak.txt". For exam‐
       ple, if there were files called

           book-chapter-1.txt
           book-chapter-2.txt
           book-chapter-3.txt

       copies of those files would be made with the names

           book-chapter-1.bak.txt
           book-chapter-2.bak.txt
           book-chapter-3.bak.txt

       Example 2: Replacing

           $ mvgp new old *new*

       For each file in the current directory that has the string  "new"  any‐
       where  in  its  name, replace the first occurrence of "new" with "old".
       Files called ...

           the-new-version.c
           new-version-header.h
           my-new-version.readme
           a_new_newt
           newspaper.doc

       ... would be renamed as ...

           the-old-version.c
           old-version-header.h
           my-old-version.readme
           a_old_newt
           oldspaper.doc

       Example 3: De-spacing file names

           $ mvgp -m -L ´ ´ - *

       Replace all of the spaces in filenames of files in the  current  direc‐
       tory  with  dash  (minus) characters. Report each rename operation that
       happens.

       Example 4: Deleting

           $ mvgp ´-´ ´´ -*

       For files in the current directory whose names start with a ´-´ charac‐
       ter,  remove that leading ´-´ from the name (i.e., replace the ´-´ with
       nothing). Note that in this case, it is not necessary to  give  mvgp  a
       ´--´  option to keep it from treating ´-´ as an option. However, if the
       pattern were ´-m´ or something else that looks  like  a  valid  option,
       then the command would be

           $ mvgp -- ´-m´ ´m´ -*

       (which would do the same thing as the first command).

       Example 5: Changing the extensions, or end of files´ names

           $ mvgp ´%.old´ .bak *.old

       For  all  files in the current directory that end in ".old", the exten‐
       sion will be changed to ".bak".

       Example 6: Changing the beginning of the names

           $ mvgp ´#re´ un re*

       All files in the current directory whose names  start  with  "re"  will
       have  "re"  changed to "un" in their names. (I.e., files named "redo.1"
       and "redo.2" will be renamed "undo.1" and "undo.2", respectively.)

       Example 7: Pattern matching in the pattern

       Suppose we have files named

           written-by-Stan
           painted-by-Jane
           sculpted-by-Bob
           built-by-Andrew

       and we want to change them to all start out with "created-by". One  way
       to do that would be

           $ mvgp ´*-by´ created-by *-by-*

       If we only wanted to operate on the first three, we could say

           $ mvgp ´*e?-by´ created-by *-by-*

       or

           $ mvgp ´*-by´ created-by *e?-by-*

       Example 8: Directories in search-and-replace strings

           $ mvgp ´projects/´ ´backburner/source-´ projects/code/*

       move   all   of   the   files   and  directories  in  the  subdirectory
       "projects/code" to the directory "backburner/source-code".

IMPLEMENTATION
       mvgp and cpgp are implemented as a single bash shell script. Both  com‐
       mands  are actually the same program; the function is determined by the
       name of the executable file. cpgp is simply a symbolic link to the mvgp
       script.

BUGS
       None known. If you find a bug, please report it to the author.

SEE ALSO
       cp(1), mv(1), bash(1)

COPYRIGHT
       Copyright  2000  Jay  Ts. mvgp and cpgp are released under the GPL (GNU
       Public License). You may find a copy of the GPL at http://www.fsf.org.

AUTHOR
       Jay Ts (http://jayts.com)



Jay Ts                             June 2019                           MVGP(1)
```
