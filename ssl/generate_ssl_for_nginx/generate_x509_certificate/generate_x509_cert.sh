#!/bin/bash

# ------------------------------------------------------------------
# - Filename: generate_x509_cert.sh
# - Author : vsypo
# - Dependency : none
# - Description : script that generate self signed certificate with CA
# - Creation date : 2025-01-23
# - Bash version : 5.2.15(1)-release
# ------------------------------------------------------------------

set -e
SCRIPT_OUTPUT_PATH=${SCRIPT_OUTPUT_PATH:-"."}
SCRIPT_OUTPUT_CA_PATH=${SCRIPT_OUTPUT_CA_PATH:-"$SCRIPT_OUTPUT_PATH/CA"}
SCRIPT_OUTPUT_CLIENT_PATH=${SCRIPT_OUTPUT_CLIENT_PATH:-"$SCRIPT_OUTPUT_PATH/client"}
SCRIPT_OUTPUT_SERVER_PATH=${SCRIPT_OUTPUT_SERVER_PATH:-"$SCRIPT_OUTPUT_PATH/server"}

DEFAULT_SSL_DURATION=3650

####################################################
#                    Parameters
####################################################

## Generate Root CA private key
openssl genrsa -out ${SCRIPT_OUTPUT_CA_PATH}/ca-key.pem 2048

## Generate Root CA Certificate
openssl req -new -x509 -nodes -days ${DEFAULT_SSL_DURATION} \
   -key ${SCRIPT_OUTPUT_CA_PATH}/ca-key.pem \
   -out ${SCRIPT_OUTPUT_CA_PATH}/ca-cert.pem

## Generate Server Private Key and Server CSR
openssl req -newkey rsa:2048 -nodes -days ${DEFAULT_SSL_DURATION} \
   -keyout ${SCRIPT_OUTPUT_SERVER_PATH}/csr/server-key.pem \
   -out ${SCRIPT_OUTPUT_SERVER_PATH}/csr/server-req.pem

## Server Certificate Creation and Signing using CA Key
openssl x509 -req -days ${DEFAULT_SSL_DURATION} -set_serial 01 \
   -in server-req.pem \
   -out server-cert.pem \
   -CA ca-cert.pem \
   -CAkey ca-key.pem \
   -extensions SAN   \
   -extfile <(printf "\n[SAN]\nsubjectAltName=DNS:host1.bastionxp.com\nextendedKeyUsage=serverAuth")

## Generate client Certificate
openssl req -newkey rsa:2048 -nodes -days ${DEFAULT_SSL_DURATION} \
   -keyout client-key.pem \
   -out client-req.pem

## Client Certificate Creation and Signing using CA Key
openssl x509 -req -days ${DEFAULT_SSL_DURATION} -set_serial 01  \
   -in client-req.pem    -out client-cert.pem  \
   -CA ca-cert.pem   \
   -CAkey ca-key.pem   \
   -extensions SAN  \
   -extfile <(printf "\n[SAN]\nsubjectAltName=DNS:host2.bastionxp.com\nextendedKeyUsage=clientAuth")
