# Git Pull Force – How to Overwrite Local Changes With Git

When you have work on local that differ from work on the main branch, how to git pull ?

3 way to do it (losing change on local, saving change, and "merging") :
- [force git pull](https://www.freecodecamp.org/news/git-pull-force-how-to-overwrite-local-changes-with-git/)

Quick infos to force it (loosing local data) :
```
git fetch
git reset --hard HEAD
git merge origin/$CURRENT_BRANCH
```

$CURRENT_BRANCH is main by default