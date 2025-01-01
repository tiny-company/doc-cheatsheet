# revert a commit 


- IF you have NOT pushed your changes to remote
```
git reset HEAD~1
```

- Check if the working copy is clean by `git status`.

ELSE you have pushed your changes to remote
```
git revert HEAD
```