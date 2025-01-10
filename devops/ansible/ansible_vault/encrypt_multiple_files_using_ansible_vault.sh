#!/bin/bash

# ------------------------------------------------------------------
# - Filename: encrypt_multiple_files_using_ansible_vault.sh
# - Author : ottomatic
# - Dependency : none
# - Description : script that encrypt multiple files using ansible-vault
# - Creation date : 2025-01-09
# - Bash version : 5.2.15(1)-release
# ------------------------------------------------------------------

set -euo pipefail

####################################################
#                ansible vault function
####################################################

encrypt_files_with_ansible_vault() {
### encrypt all files under a folder using ansible vault ###

    for file in ${VARS_DIR_PATH_FILE}/*; do
        ansible-vault encrypt "$file" --vault-password-file "$VAULT_PASSWORD_FILE"
    done

    echo "All files in host_vars have been encrypted."

}

decrypt_files_with_ansible_vault() {
### decrypt all files under a folder using ansible vault ###

    # Encrypt all files in host_vars
    for file in ${VARS_DIR_PATH_FILE}/*; do
        ansible-vault decrypt "$file" --vault-password-file "$VAULT_PASSWORD_FILE"
    done

    echo "All files in host_vars have been decrypted."

}

####################################################
#                    Main function
####################################################

# Check if mandatory vars are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 encrypt <path_to_vars_directory> <vault_password_file>"
    echo "Usage: $0 decrypt <path_to_vars_directory> <vault_password_file>"
    exit 1
fi

SCRIPT_COMMAND=$1
VARS_DIR_PATH_FILE=$2
VAULT_PASSWORD_FILE=$3

case "$1" in
    encrypt)
        encrypt_files_with_ansible_vault
        ;;
    decrypt)
        decrypt_files_with_ansible_vault
        ;;
    *)
        echo "Usage: $0 encrypt <path_to_vars_directory> <vault_password_file>"
        echo "Usage: $0 decrypt <path_to_vars_directory> <vault_password_file>"
        exit 1
esac
