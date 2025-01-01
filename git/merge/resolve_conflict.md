# resolv git conflict

## what is a merge conflict

If the two branches you're trying to merge both changed the same part of the same file, Git won't be able to figure out which version to use. When such a situation occurs, it stops right before the merge commit so that you can resolve the conflicts manually.

When you encounter a merge conflict, running the git status command shows you which files need to be resolved. For example, if both branches modified the same section of hello.py, you would see something like the following:

```
On branch main
Unmerged paths:
(use "git add/rm ..." as appropriate to mark resolution)
both modified: hello.py
```


## How to resolv a merge conflict

When a merge conflict occurred, start `git mergetool`

go to the conflict line and choose what content to keep with :

:diffg RE  " get from REMOTE
:diffg BA  " get from BASE
:diffg LO  " get from LOCAL

After everything has been fixed, quit and save with `:wqa`

Finally recreate a new commit with the merge change : `git commit`

## source :

- [git merge with mergetool](https://www.rosipov.com/blog/use-vimdiff-as-git-mergetool/#fromHistor)