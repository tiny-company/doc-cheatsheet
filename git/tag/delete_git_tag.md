# delete git tag

## List tag locally

```
git tag
```

## List all tag on remote

```
git ls-remote --tags origin
```

## Delete tag locally

```
git tag -d tag_name
```

## Delete tag on remote

```
git push origin --delete tag_name
```

## Purge all tags (locally and remotly)

- Make sure to get all tag from remote :
```
git fetch --tags
```

- Delete all tags on remote :
```
git tag -l | xargs -n 1 git push --delete origin
```

- Delete all tags locally :
```
git tag | xargs git tag -d
```

## Sources :

- [tutorial to delete git tags](https://ioflood.com/blog/git-delete-tag-how-to-remove-tags-from-local-and-remote-git-repositories/)