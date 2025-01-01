# Remove file on repository listed on gitignore

- remove file manually :
```
git rm --cached file1 file2 dir/file3
```

- remove by reading .gitignore file :
```
git rm --cached `git ls-files -i -c --exclude-from=.gitignore`
```

- delete everything from cache and re-add :
```
git rm -r --cached .
git add .
git commit -m "Drop files from .gitignore"
```