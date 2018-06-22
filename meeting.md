
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

![alt text](https://github.com/YSanchezAraujo/YSanchezAraujo.github.io/tree/master/images/Github.png "Logo Title Text 1")


[logo]: https://github.com/YSanchezAraujo/YSanchezAraujo.github.io/tree/master/images/Github.png
