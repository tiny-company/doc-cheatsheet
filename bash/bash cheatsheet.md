
Here is a list of other string comparison operators that you can use in your Bash script.
```
= : equal
!= :not equal
< : less then
> : greater then
-n s1 :string s1 is not empty
-z s1 : string s1 is empty
```

Here is a list of other Bash file testing operators that you can use in your Bash script.
```
-b filename 	Block special file
-c filename 	Special character file
-d directoryname 	Check for directory existence
-e filename 	Check for file existence
-f filename 	Check for regular file existence not a directory
-G filename 	Check if file exists and is owned by effective group ID.
-g filename 	true if file exists and is set-group-id.
-k filename 	Sticky bit
-L filename 	Symbolic link
-O filename 	True if file exists and is owned by the effective user id.
-r filename 	Check if file is a readable
-S filename 	Check if file is socket
-s filename 	Check if file is nonzero size
-u filename 	Check if file set-ser-id bit is set
-w filename 	Check if file is writable
-x filename 	Check if file is executable
```

## Sources :

- Good tutorial about bash scripting operator : https://linuxconfig.org/bash-scripting-operators
- git submodule foreach doc : https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-foreach--recursiveltcommandgt

- IFS usage : https://en.wikipedia.org/wiki/Input_Field_Separators

- reading output as an array : https://www.baeldung.com/linux/reading-output-into-array