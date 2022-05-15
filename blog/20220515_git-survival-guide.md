---
title: Git Survival Guide
author: Frédéric Delorme
date: 2022-APR-24
description: This docuemnt intends to provide some helpt on git usage. Some parts are from their respective author (see provided links)
tags: git,branch,tag,flow
---

# Git Survival Guide

## Overview

Git is command line tool to manage source versioning of a project.

![Git operations](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Git_operations.svg/734px-Git_operations.svg.png)

_source: https://en.wikipedia.org/wiki/Git#/media/File:Git_operations.svg_

## Init repo

first create a project directory:

```bash
mkdir my-project
```

and initialize the git repo in it

```bash
cd my-project
git init
Initialized empty Git repository in C:/Users/frederic/Projects/personnel/my-project/.git/
```

The default created branch is `master`.

## Remote repository

To add a remote repository where to push securely your [my-project] code, 

```bash
git remote add origin git@[my-server]:[my-account]/[my-project].git
```

where:

- `origin` is the keyword for this remote repo (the default one)
- `git@[my-server]:[my-account]/[my-project].git` the destination 'URL' for this server's repo.

**typically:**
- via ssh : `git@github.com:mcgivrer/my-project.git` 
- via https : `https://github.com/mcgivrer/my-porject.git`

But before beeing able to push data throuh the ssh protocole, you must create an ssh key:

```bash
ssh-keygen
```

And follow the requesting things.  At end a new `~/.ssh/id_rsa.pub` file (your public ssh key) will be created.

Copy and paste the content file of your new public key to the remote server configuration page (e.g.: https://github.com/settings/keys on github, or https://gitea.com/user/settings/keys on gitea).

Now you are ready to push code !

> **Note**<br/>
> while using http protocole, you must authenticate to the remote server on each operation. To avoid such discrepencies, you can use a credential storage. To activate the storing of the credential, you must configure it:
>
> `git config credential.helper store`
>
> _see https://git-scm.com/docs/git-credential-store for details._
 


## Add files and commit

To add any modified, created or track deleted files:

```bash
touch README.md
```

Just  execute the following command:

```bash
git add .
warning: LF will be replaced by CRLF in REAMDE.md.
The file will have its original line endings in your working directory
```

and then to record the change to the repo, apply a commit command:

```bash
git commit -m "Create My-Project"
[master (root-commit) cdea82c] Create My-Project
 1 file changed, 5 insertions(+)
```

The `-m` option let's you add a comment (a **m**essage) to your commit to explain the reason of such changes.
There are some well known standard about commit message, the 

> **TIPS** #1 <BR/>The magic of `.gitignore` file allow you to automatically filter not desired file to be added to your repo. 
> Just add full filename or joker filename (eg: `*.class`,  `*.log`) to this file, one per line, and that's it; the `git add` command will automatically exclude the `.gitignore` entries.
> an easy way to start is to execute a `touch .gitignore`. 

here is my own for this fantastic my-project

```gitignore
# exclude common java files
**/*.class
**/*.log
target/
# exclude IDE metadata files
.idea/
*.iws
*.ipr
*.iml
.vsdcode/
.settings/
.project
.classpath
```

>**TIPS** #2<BR/> The github platform will propose standard .gitignore file according to programmation language you intend to use in your project.


## Pushing code to remote repo

```bash
git push
```

and if its a newly create branch

```bash
git push --set-upstream origin master
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 8 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 311 bytes | 311.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To github.com:mcgivrer/my-project.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
```

## Managing branch

Here is a typical branching model:

![A typical Branching model](https://user-images.githubusercontent.com/1256329/80170009-f9d03200-85b4-11ea-94d3-3041887565ac.png)

_source: https://www.bryanbraun.com/2020/04/24/drawing-git-branching-diagrams/_

## Create branch

```bash
git checkout -b {my-branch-name}
```

It will create a branch named `my-branch-name`.

> **TIPS** <br/>Creating a branch from a tag see [create branch from a tag](#create-branch-from-a-tag)

*sample*:

```bash
git checkout -b feature/add-main-programm-structure
Switched to a new branch 'feature/add-main-programm-structure'
```

## Rename a branch

(from https://linuxize.com/post/how-to-rename-local-and-remote-git-branch/)

### Follow the steps 

To rename a Local and Remote Git Branch:

1. Start by switching to the local branch which you want to rename:

```bash
git checkout <old_name>
```

2. Rename the local branch by typing:

```bash
git branch -m <new_name>
```

3. At this point, you have renamed the local branch.

If you’ve already pushed the <old_name> branch to the remote repository , perform the next steps to rename the remote branch.

Push the <new_name> local branch and reset the upstream branch:

```bash
git push origin -u <new_name>
```

4. Delete the <old_name> remote branch:

```bash
git push origin --delete <old_name>
```

That’s it. You have successfully renamed the local and remote Git branch.

> **NOTE**
> Branches are part of the software development process and one of the most powerful features in Git. Branches are essentially pointers to a certain commit.
> Renaming a local Git Branch is a matter of running a single command. However, you can’t directly rename a remote branch; you need to push the renamed local branch and delete the branch with the old name.


## Publishing a release

First tag your code on the `main` (or `master`) branch, an then create a `release/[x.y.z]` branch for maintainance purpose.

```bash
git tag v[x.y.z]
```

> **INFO**<br/>A TAG is a short name for specific commitId. Mutliple tags can be attached to same commitId.

> **TIPS**<br/>To know how to create tag correctly, you can read the [SemVer](https://semver.org/) principle.

And to synchronize your new tag with remote repo:

```bash
git push --tags
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
To github.com:mcgivrer/my-project.git
 * [new tag]         v0.0.1 -> v0.0.1
```

Then create a new branch to proceed maintenance purpose on the create release:

```bash
git checkout -b release/v[x.y.z] v[x.y.z]
```

where :

- `release/v[x.y.z]` is the name for this new branch
- `v[x.y.z]` is the tag to create this branch from.


e.g.:

```bash
git checkout -b release/v0.0.1 v0.0.1
Switched to a new branch 'release/v0.0.1'
```

Now you can code all your new feature in this feature branch.

## Merge a branch

When you finish developing your fancy fantastic feature (FFF) in your feature branch, you must merge it to your master (or develop, see [git flow](#Annexe-Git-Flow)).

So first go back to master branch, and then merge the new code into it:

```bash
git checkout master
git merge feature/add-main-programm-structure
Merge made by the 'ort' strategy.
 src/main/java/App.java | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 src/main/java/App.java
```

And it's done !

> **TIPS**<BR/> There is 2 political ways to proceed.  
> 1. You can delete the feature branch as soon the feature is merged, 
> 2. You can wait until the next release is publish, thene delete all the relatives branches.

### Annexe Git Flow

[Git flow](https://nvie.com/posts/a-successful-git-branching-model/ "visit this official post where all begin") is a core dev wellknown standard way to manage all branches, tags, bugfixes and releases in your project repo.

To manage your repo according to this standard, you must first install the git 'plugin' to manage it (see :::), and execute the following command:

```bash
git flow init
```

After a few common question, the following branch model structure will be initialized :

- `develop` where everything start
- `main` or `master` the point where everything end
- `feature/` where all new feature must be created
- `bugfix/` where any bug must be fixed before falling in a target branch and in main/master.
- `release/` to maintain any release you are intend to create and make it survive ;)

to know how to manage the flow, see the 

## Checkout from a tag

### Simply checkout tag

```bash
git checkout v1.0.1-1
```

### create branch from a tag

```bash
git checkout -b new-branch v1.0.1-1
```

## Delete a tag

### delete a local tag

```bash
git tag -d  v1.0.1-1
```

### delete a remote tag

```bash
git push --delete origin v1.0.1-1
```

where:

- `origin` is the remote id
- `v1.0.1-1` the ga to be deleted.


## Change author on commits

You will pop-up an editor to confirm all git commit message, one by one.

### change author from a particular SHA

```bash
git rebase -i YOUR_SHA -x "git commit --amend --author 'Author Name <author.name@mail.com>' -CHEAD"
```

### Change author for n last commit

```bash
git rebase -i HEAD~4 -x "git commit --amend --author 'Author Name <author.name@mail.com>' --no-edit"
```

> **NOTE**:<br>
> A simple script to perform user/author/email replacement on all commits : [git-replace-author.sh](https://gist.github.com/mcgivrer/81f67eddf93b0a9d46cac5f1ff4e45c6#file-git_replace_author-sh), just replace `OLD_EMAIL`, `CORRECT_NAME` and `CORRECT_EMAIL` with the required values.

## ANNEXES

### intialize a simple java project

- script : [`initjavaprj.sh`](https://gist.github.com/mcgivrer/81f67eddf93b0a9d46cac5f1ff4e45c6/raw/34fb587688e84cce179ce09cc4c04b3303a37126/initjavaprj.sh)
- usage: `initjavaprj my-project`


```bash
#!/bin/bash
mkdir $1
cd $1
mkdir -p src/main/{java,resources}
mkdir -p src/test/{java,resources}
echo "# README" > README.md
curl https://gist.githubusercontent.com/mcgivrer/85075539679f32763146ee4d9335a437/raw/2516dd23b766f5c6cf4b91385e0cb6c027621d7a/build.sh -o build.sh
touch .gitignore
echo "Project $1 created."
```
