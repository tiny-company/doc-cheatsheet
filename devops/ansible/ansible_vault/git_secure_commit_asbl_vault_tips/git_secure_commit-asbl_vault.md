# git_secure_commit_asbl_vault_tips

## Description

Find in the file [pre-commit](./pre-commit) a shell script that prevent any git commit with clear ansible vars and show a message to force ansible-vault usage.

This file must be added under `.git/hooks` of the wanted repository in order to automatically work for any commit under this repo.

