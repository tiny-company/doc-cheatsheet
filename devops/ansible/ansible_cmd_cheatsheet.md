# Ansible command cheatsheet

- using playbook on a specific host on a large inventory :
```
ansible-playbook -i inventory --limit your_host_name example_playbook.yml
```

More at [ansible documentation about limit option](https://docs.ansible.com/ansible/latest/inventory_guide/intro_patterns.html#id12)

- Start playbook at specific task :
```
ansible-playbook -i inventory --start-at-task "task name" playbook.yml
```

- run only a specific tag of a playbook :
```
ansible-playbook -i inventory --tags "tag_name1, tag_name2" playbook.yml
```

- skip specific tag of a playbook :
```
ansible-playbook -i inventory --skip-tags "tag_name1, tag_name2" playbook.yml
```