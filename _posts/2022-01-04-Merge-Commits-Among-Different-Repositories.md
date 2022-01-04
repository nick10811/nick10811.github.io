---
layout: post
title: Merge Commits Among Different Repositories
date: '2022-01-04'
author: Nick Yang
tags:
- Git
---

This article aims to introduce advanced git commands. The company might clone an existing repository to build a new project in certain cases. But, they also need to retain features consistent among those projects. Hence, I wrote this article to address those problems.

In this article, I will introduce three approaches that help me to achieve my object.

- git-cherry-pick
- git-diff
- git-patch

## git-cherry-pick

You might wonder why I choose [`cherry-pick`](https://git-scm.com/docs/git-cherry-pick). It just applies commits among **branches** instead of repositories. But there has a difference when I adopt [`git-remote`](https://git-scm.com/docs/git-remote). I can still use [`cherry-pick`](https://git-scm.com/docs/git-cherry-pick) when I fetch the source repo to current repo. After fetching, I can apply multiple commits to the current branch.

```bash
# add source repo to existing
$ git remote add [<source repo>] [<repo url>]
$ git fetch [<source repo>]

# apply commits to current branch
$ git cherry-pick [<commit A>] [<commit B>]
```

> 💡 Add `--no-commit` if you don’t want to leave the commit message.

## git-diff

The main purpose of [`git-diff`](https://git-scm.com/docs/git-diff) is to show changes between commits. So we can make a **diff** file between two commits, and apply it in the destination project.

```bash
# generate diff file
$ git diff [<start commit>] [<end commit>] > update.diff

# switch to destination repo & place diff file to the root of project
$ git apply update.diff
$ rm update.diff
```

## git-format-patch

This command is similar to the previous one. The biggest difference is [`git-format-patch`](https://git-scm.com/docs/git-format-patch) will append commit message, and generate a patch file with email format. The operation is also similar. First, we find a commit as a start point and set the number of commits that you want to package it. After generating patch file, we place it in the root of the project of destination repo. Second, we use [`git-am`](https://git-scm.com/docs/git-am)  to apply this patch.

> 💡 **HINT:** patch file is only for the commits in a row

```bash
# generate a patch file
$ git format-patch -[number] [<start commit>] --output update.patch

# switch to destination repo & place patch file to the root of project
$ git apply --check update.patch
# when the patch doesn't apply cleanly, fall back on 3-way merge
$ git am -3 update.patch
$ rm update.patch
```

> - [`git-apply`](https://git-scm.com/docs/git-apply) → apply a patch/file
> - [`git-am`](https://git-scm.com/docs/git-am) → apply a series patches/files

## How to choose?

The above approaches have their own advantages and disadvantages. According to my study, I give you my conclusions as follows.

- git-cherry-pick
    - If you have multiple sparse commits need to apply to the current repo.
- git-diff
    - If you just apply the changes without commit message.
- git-patch
    - if you have the commits in a row need to apply to the current repo, and need to keep each commit message.

---

**Git Official Documents**

- [git-cherry-pick](https://git-scm.com/docs/git-cherry-pick)
- [git-remote](https://git-scm.com/docs/git-remote)
- [git-diff](https://git-scm.com/docs/git-diff)
- [git-apply](https://git-scm.com/docs/git-apply)
- [git-format-patch](https://git-scm.com/docs/git-format-patch)
- [git-am](https://git-scm.com/docs/git-am)