# ansible troubleshooting

- List the host :
```
ansible all --list-hosts
```

- "Ping" (it will test ssh connection) all host :
```
ansible all -m ping
```

- To check the syntax of the yaml playbook and show which taks will be executed :
```
ansible-playbook <your_playbook.yml> -i <your_inventory_file> --syntax-check --list-tasks
```

- To check (test the playbook without applying modification) :
```
ansible-playbook <your_playbook.yml> -i <your_inventory_file> --check
```