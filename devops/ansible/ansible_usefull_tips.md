# Ansible usefull tips

## Using assert to manage mandatory parameters

- example asserting that variables is defined :
```
- name: Ensure profile storage configuration is valid
  tags: always
  assert:
    that:
      - profile.storage is defined
      - profile.storage.repository is defined
    fail_msg: Profile must have repository in storage section
```


See more at [ansible assert documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/assert_module.html)

