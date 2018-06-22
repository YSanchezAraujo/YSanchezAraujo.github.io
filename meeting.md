
<h2>What is Git?</h2>
It's a version control system (VCS) - tells you who did what when, keeps track of almost everything, allows you to feel safe about editing / removing lines of code. Great for collaborations of all sorts - slighly less amazing for lone-human use. 

<h2>Git vs. Github</h2>
These are two different things, you can use and have git software on your machine without ever having to go onto Github.com, Github makes things far more convienent for collaborations. 

<h2> Git basic usage (probably most common useage) </h2>


```bash
git clone # grab a repo from some location
git status # check what is different in your version of the repo from what git has "officially"
git add # add changes you've made
git commit # offically add them to git's system
git push # make the changes available for anyone else to see
```

go to github.com, login to your account, navigate to `https://github.com/YSanchezAraujo/meeting/tree/master`, and click on the `fork` button on the top right corner. 

open up a terminal, optionally navigate somewhere you'll remember and copy and paste this (replacing `YOURUSERNAME` with the appropriate text)
```
git clone https://github.com/YOURUSERNAME/meeting.git
```

now open up `test_file.sh` via your favoriate editor (I like vim) and add some lines to text - anything. Next create a new file and save it in that directory. Once your done perform a `git status`, the output should be some version of: 

```bash
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   test_file.sh

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	new_file.txt

no changes added to commit (use "git add" and/or "git commit -a")
```
you can also get more details of what's changed per file using `git diff`, this is what I get: 

```bash
diff --git a/test_file.sh b/test_file.sh
index 4710eee..d6844c4 100644
--- a/test_file.sh
+++ b/test_file.sh
@@ -1,3 +1,5 @@
 #!/bin/bash

+
+echo "MOAR LINES"
 echo "learning about git...maybe"
```
moving on, once you've made changed that you want to keep track of you add them via the `git add` command, based on the git status message above I would do:
```bash
git add test_file.sh new_file.sh # adding them together
```
the other option is to add them one by one using multiple `git add` commands after you've commited them. The reason for why you'd want to add them one by one is each might have it's own short - hopefully informative message and you don't want those to be part of the same commit. There are many ways you can add things to git, for example if you've made a ton of changes and you just want to add everything at once you can use: 


```bash
# this will add everything in your current directory
git add . 
# you can do the same thing for individual sub directories
git add dir_name
```
after you've added them you have to commit them using `git commit`:

```bash
git commit -m "this is the update message"
```
and once that's done you can push your changes so that they are reflected in the current working branch

```bash
git push origin master
# or
git push
```

<h2>Putting it together in an example</h2>
You're a researcher who works in Princeton but lives in NYC. Sometimes you work from home, sometimes in the lab, other times on the train. It use to be the case that you would email yourself the updated files, or copy them over to a portable drive to make sure you could always work on the most up to date files. Then you learned about git & github and you did away with this strategy. Now you have your set of files on github and wherever you're working from you follow the same routine:


```bash
git pull dir_name # to get the latest changes
git add files # add the work you've done for the day
git commit -m "did some work.." # commit them
git push origin master # push them so that you can pull them from another work station later on
```

<h2> Brief look at branches </h2>
Say you're working on some new algorithm that's part of a peice of software and you have a version that is good to go and can be used by others, but you also have some other ideas that may or may not break everything. Branching is useful here in that it creates a copy of your current work and lets you safely work on you new features without distruping the current working version. 

To create a new branch and switch to it:

```bash
git checkout -b new_branch
# now you're in a new branch, you can check which branch you're in with the command
git branch
# the output will look like:
```

```bash
* master
  new_branch
```

switch between branches the command is similar to when you created one however you ommit the `-b`

```bash
git checkout master
```
to push changes to your branch the workflow is the same as before with a small change in the `push` command:

```bash
# assuming you're in the new_branch branch
git add new_file.txt
git commit -m "new file in new branch"
git push origin new_branch # see the difference here
```

typically branching is where lots of problems come up with merge conflicts, people forgetting what branch they're in and trying to do things they shouldn't in that branch, forgetting to add and commit, freaking out because of merge conflict messages and so on. The best way to try and avoid this is to always check which branch you're in if uncertain with `git branch`, which the status of your files with `git status` to see if you have any untracked or unstaged changes and fix the appropriate merge conflicts. 

If you've updated the original "master" branch and you want those changes to be available in another branch **once you're in that other branch**, you can `git fetch orgin` to get those changes.  if you'd like to have your new branch become the master branch then you do `git merge origin/master`, again assuming/hoping files/changes are in order to allow for such a thing.

<h2>The Git less traveled</h2>
There are a number of other commands you can perform with git, try typing `git` in the terminal, you'll get: 

```bash
usage: git [--version] [--help] [-C <path>] [-c name=value]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout   Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
```
