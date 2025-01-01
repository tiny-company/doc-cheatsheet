# Base git commands (reminders)

## init

the command `git init` create a new git repo in a directory

- init a repo (with ssh) : (private keys)
```
echo "# ansible-playbook" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:webdrone-infra/therepo.gi
git push -u origin main
```
- init a repo (with HTTPS) : (Password or token)
```
echo "# ansible-playbook" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/webdrone-infra/ansible-playbook.git
git push -u origin main
```

## git remote

Once you have a remote repo setup (with git init), you will need to add a remote repo url to your local git config, and set an upstream branch for your local branches. The git remote command offers such utility :
```
git remote add <remote_name> <remote_repo_url>
```

Once you have mapped the remote repo you can push local branches to it.
```
git push -u <remote_name> <local_branch_name>
```

### list remote 

- you can list the remote sets :
```
git remote -v
```

### why origin in remote branch name 

origin is an alias on your system for a particular remote repository. It's not actually a property of that repository.

By doing `git push origin branchname`

you're saying to push to the origin repository. There's no requirement to name the remote repository origin: in fact the same repository could have a different alias for another developer.

Remotes are simply an alias that store the URL of repositories. You can see what URL belongs to each remote by using  `git remote -v`

This alias name is not hard coded and could be changed using following command prompt :  `git remote rename origin mynewalias`

## git transports command explain 

![transport git commands explained](https://i.stack.imgur.com/MgaV9.png)

## branch 

### list branch 

To find out what branches are available and what the current branch name is, execute git branch :
```
git branch 
```

### create new branch  

- to create an new branch : 
```
git branch <new_branch_name>
```
This will create a new branch, but doesn’t automatically switch to that branch.

- to create a new branch from the current work, and then move to it : 
```
git checkout -b <new branch name>
```
This creates a new branch from the current branch. It also automatically switches to the new branch. (The -b option is a convenience flag that tells Git to run git branch)

### change/switch branch 

- to switch to this newly created branch do : 
```
git checkout <branch_name>
```
Switching branches is a straightforward operation. Executing the following will point HEAD to the tip of ＜branchname＞.
Git tracks a history of checkout operations in the reflog. You can execute `git reflog to view the history`.

## commit 

create a commit (package changes done, like a milestone)
A commit is a command that saves the changes made in the code.

- to show all commit with infos (hash key) : 
```
git log
```

## checkout

In Git terms, a "checkout" is the act of switching between different versions of a target entity.
The git checkout command lets you navigate between the branches created by git branch. 
Checking out a branch updates the files in the working directory to match the version stored in that branch, and it tells Git to record all new commits on that branch. Think of it as a way to select which line of development you’re working on.

### git checkout vs git clone 

The git checkout command may occasionally be confused with git clone. The difference between the two commands is that clone works to fetch code from a remote repository, alternatively checkout works to switch between versions of code already on the local system.

## clone 

git clone is used to create a copy or clone of remote repositories. You pass git clone a repository URL. Git supports a few different network protocols and corresponding URL formats.
```
git clone <repo url>
```

When executed, the latest version of the remote repo files on the main branch will be pulled down and added to a new folder. The folder will contain the full history of the remote repository and a newly created main branch.

## fetch 

The git fetch command downloads commits, files, and refs from a remote repository into your local repo. Fetching is what you do when you want to see what everybody else has been working on. Fetched content has to be explicitly checked out using the git checkout command. This makes fetching a safe way to review commits before integrating them with your local repository.

- This tells git to fetch the branch named 'master' from the remote named 'origin'. git fetch will not affect the files in your working directory; it does not try to merge changes like git pull does : 
```
git fetch origin master
```

When downloading content from a remote repo, git pull and git fetch commands are available to accomplish the task. You can consider git fetch the 'safe' version of the two commands. 
git pull is the more aggressive alternative; it will download the remote content for the active local branch and immediately execute git merge to create a merge commit for the new remote content. If you have pending changes in progress this will cause conflicts and kick-off the merge conflict resolution flow.

### compare remote repository with local repository

- When the remote branch is fetched, it can be referenced locally via FETCH_HEAD. The command above tells git to diff the working directory files against FETCHed branch's HEAD and report the results in summary format. Summary format gives an overview of the changes, usually a good way to start. If you want a bit more info, use --stat instead of --summary
```
git diff --summary FETCH_HEAD
```

## pull

The git pull command is used to fetch and download content from a remote repository and immediately update the local repository to match that content. Merging remote upstream changes into your local repository is a common task in Git-based collaboration work flows. The git pull command is actually a combination of two other commands, git fetch followed by git merge. In the first stage of operation git pull will execute a git fetch scoped to the local branch that HEAD is pointed at. Once the content is downloaded, git pull will enter a merge workflow. A new merge commit will be-created and HEAD updated to point at the new commit.

<br>

To resume **git pull = git fetch + git merge**

## push 

The git push command is used to write to a remote repository.
```
git push <remote-name> <branch-name>
```
This example will upload the local state of ＜branch-name＞ to the remote repository specified by ＜remote-name＞.

## log

The git log command displays committed snapshots. It lets you list the project history, filter it, and search for specific changes. 

## status 

List which files are staged, unstaged, and untracked.
The git status command is a relatively straightforward command. It simply shows you what's been going on with git add and git commit. Status messages also include relevant instructions for staging/unstaging files.

### difference between git log and git status

<img src="https://wac-cdn.atlassian.com/dam/jcr:52d530ce-7f51-48e3-920b-a18f776048d3/01.svg?cdnVersion=902" alt="git log vs git status img" width="700"/>

## git merge

Merging is Git's way of putting a forked history back together again. The git merge command lets you take the independent lines of development created by git branch and integrate them into a single branch.

Git merge will combine multiple sequences of commits into one unified history. In the most frequent use cases, git merge is used to combine two branches. The following examples in this document will focus on this branch merging pattern. In these scenarios, git merge takes two commit pointers, usually the branch tips, and will find a common base commit between them. Once Git finds a common base commit it will create a new "merge commit" that combines the changes of each queued merge commit sequence.

[To resolve conflict in a git merge, check the associated doc about this](resolve_conflict.md)

## sources : 

- [atlassian guide to setting a git repo](https://www.atlassian.com/git/tutorials/setting-up-a-repository)
- [atlassian guide to git merge](https://www.atlassian.com/git/tutorials/using-branches/git-merge)
- [howtogeek git merge guide](https://www.howtogeek.com/853521/git-merge/)