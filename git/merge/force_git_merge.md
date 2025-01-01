# force git merge 

It happen that if you try to merge two branches (often main and master) that have nothing in common, git refused to do a merge with the error "fatal: refusing to merge unrelated histories"

In this case (know what you do) you can force the merge with option "--allow-unrelated-histories" : 
```
git checkout main
git merge --allow-unrelated-histories <branch to merge>
```

You can also use this option with other command : 
```
git pull  origin main --allow-unrelated-histories
```

Beware if there is really nothing in common, It will create a lot of conflicts, as it is not able to find the history of your local changes.