---
layout: post
title: 'Advanced Git: make git tree pretty'
date: '2022-02-22'
author: Nick Yang
tags:
- Git
---

The git commits increase over time, and the git tree might become more ugly. This is hard to find the commit we want when we need to trace the history. As a senior git user, it is a good habit to sort commits before pushing them to the server. This article will teach you a command, [git-rebase](https://git-scm.com/docs/git-rebase).

## [Git-rebase](https://git-scm.com/docs/git-rebase)

Let me give you an instance to introduce this command. In the beginning, we create a simple git tree. You can also perform the shell as below to create quickly a git tree.

```bash
#!bin/bash

mkdir git-tutorial
cd git-tutorial

git init
echo "Init" > README.md
git add README.md
git commit -m "Init"

echo "File1" > File1
git add File1
git commit -m "Add File1"

echo "File2" > File2
git add File2
git commit -m "Add File2"

echo "File4" > File4
git add File4
git commit -m "Add File4"

echo "File3" > File3
git add File3
git commit -m "Add File-3"

echo "File5" > File5
git add File5
git commit -m "Add File5"
```

The result of the git tree is below. The order is 1, 2, 4, 3, and 5. It is obversely the tree is not in order. Hence, the first thing is to sort all commits in order by ascending. 

```
Init(8a77bbd) -> Add File1(9bc62aa) -> Add File2(0e02641) -> Add File4(501a07c) -> Add File-3(7e7fb03) -> Add File5(32c93d4)
```

### Sort commits

In order to sort the commits, we add an argument `i` behind `git-rebase`. This argument helps us enter the interactive mode. And we specify commit `8a77bbd` to sort commits behind that.

```bash
$ git rebase -i 8a77bbd
```

You will enter the edit mode after the above command. Then you can sort all commits as below video.

![git-rebas sort](/public/advanced_git/git-rebase-sort.gif)

After saving, the current tree as below.

```
Init(8a77bbd) -> File1(9bc62aa) -> Add File2(0e02641) -> Add File-3(bc2b027) -> Add File4(b24c64d) -> Add File5(5537350)
```

### Delete commit

Delete a commit is an easy way. As we mentioned before, we still use `git rebase -i 8a77bd` to do all of the following operations. You can refer to this manual to perform advanced operations.

```bash
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup <commit> = like "squash", but discard this commit's log message
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified). Use -c <commit> to reword the commit message.
```

At this time, we want to delete a commit for File5. So we revise the `pick` to `drop` on the line for File5.

![git-rebas drop](/public/advanced_git/git-rebase-drop.gif)

```
Init(8a77bbd) -> Add File1(9bc62aa) -> Add File2(0e02641) -> Add File-3(bc2b027) -> Add File4(b24c64d)
```

### Reword commit

In our tree, you might find we have typos on the commit for File-3. We can use `reword` on the commit for File-3 to revise commit message.

![git-rebas reword](/public/advanced_git/git-rebase-reword.gif)

```
Init(8a77bbd) -> Add File1(9bc62aa) -> Add File2(0e02641) -> Add File3(629f780) -> Add File4(50b27db)
```

### Merge two commits

Sometimes, we may find the commits are too much. There is no sense if commits are tiny. Hence, we want to merge those into a single. In this case, we can use `squash` or `fixup`. `squash` would keep the current commit message and merge it with the previous. In the contrast, `fixup` keeps the previous commit message. In this demo, I use `squash` to merge File3 and File4.

![git-rebas squash](/public/advanced_git/git-rebase-squash.gif)

```
Init(8a77bbd) -> Add File1(9bc62aa) -> Add File2(0e02641) -> Add File3&File4(fa99362)
```

### Divide commit into two

Thanks for reading until here even this article is too long. Sometimes, our passion for coding causes us to forget so that the content of a single commit becomes large. It is meaningless if a single commit is large. Because we can not trace it if we have a bug in that. The good way is to keep simple for each commit. Here, I would like to introduce a great operation to you. You can divide a single commit into two. In this demo, we want to divide the previous merging commit into two. We use `edit` and [git-reset](https://git-scm.com/docs/git-reset). After making the commit as `edit`, we perform `git-reset` to make File3&File4 to unstaged status. And then we can divide commits into several commits. Finally, we perform `git rebase --continue` to complete this whole operation.

```bash
# enter the interactive mode
$ git rebase -i 8a77bd
# reset to `Add File2`
$ git reset 0e02641
```

![git-rebas edit](/public/advanced_git/git-rebase-edit.gif)

```
Init(8a77bbd) -> Add File1(9bc62aa) -> Add File2(0e02641) -> File3(60901c4) -> File4(180e801)
```

## Delete the Multiple Remote Branches

In addition to the git commits cause the ugly git tree, but multiple branches might cause it as well. Hence, regular deleting unused branches become more important. Here I provide a command to make an easy way to delete the remote branches.

```bash
$ git branch -r | grep 'origin/feature-*' | sed 's/origin\///' | xargs -I {} git push origin :{}
```

## [Git-reflog](https://git-scm.com/docs/git-reflog)

This article introduced an advanced git command, git-rebase. If you are a beginner or not good at git. You might be frustrated if the result is not expected, and do not know how to restore to the original status. The good news is git could record all of the operations including your commit revise every time. Hence, you can try this command to restore your previous status when the result is not expected.

---

## Git Official Documents

- [git-rebase](https://git-scm.com/docs/git-rebase)
- [git-reset](https://git-scm.com/docs/git-reset)
- [git-reflog](https://git-scm.com/docs/git-reflog)