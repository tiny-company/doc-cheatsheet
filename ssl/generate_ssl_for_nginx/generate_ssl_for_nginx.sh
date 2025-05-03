#!/bin/bash

# ------------------------------------------------------------------
# - Filename: generate_ssl_for_nginx.sh
# - Author : ottomatic
# - Dependency : logs.sh
# - Description : script that generate ssl certificate for nginx web server using docker
# - Creation date : 2025-01-01
# - Bash version : 5.2.15(1)-release
# ------------------------------------------------------------------

set -euo pipefail

####################################################
#                    Parameters
####################################################
MANDATORY_VAR_LIST=("DOMAIN_NAME" "CERTBOT_EMAIL")

## ENV parameters
ENV_FILE_NAME=.env

## logs parameters
LOG_STD_OUTPUT=${LOG_STD_OUTPUT:-false}
LOG_DIR=${LOG_DIR:-./}
SCRIPT_NAME="${SCRIPT_NAME:-nginx_ssl_gen_script}.log"
LOG_FILE=${LOG_DIR}/${SCRIPT_NAME}
LOG_COLORED=${LOG_COLORED:-true}

## self signed certificate parameters
SSC_GENERATION_HOST_PATH=${SSC_GENERATION_HOST_PATH:-/tmp/ssc}

## certbot certificate parameters
CERTBOT_NGINX_CONFIG_FILE_PATH=${CERTBOT_NGINX_CONFIG_FILE_PATH:-/tmp/certbot/nginx.conf}
CERTBOT_RSA_KEY_SIZE=${CERTBOT_RSA_KEY_SIZE:-4096}
CERTBOT_HOST_DATA_PATH=${CERTBOT_HOST_DATA_PATH:-/tmp/certbot/certificates}
CERTBOT_HOST_WWW_PATH=${CERTBOT_HOST_WWW_PATH:-/tmp/certbot/www}
CERTBOT_EMAIL=${CERTBOT_EMAIL:-}
CERTBOT_STAGING=${CERTBOT_STAGING:-1} # Set to 1 if you're testing your setup to avoid hitting request limits
CERTBOT_STAGING_ARG=${CERTBOT_STAGING_ARG:-}
CERTBOT_IMAGE_VERSION=${CERTBOT_IMAGE_VERSION:-v3.0.1}

####################################################
#                    ENV var loading
####################################################

## Load environment variables from .env file if file exist
if [ -f ${ENV_FILE_NAME} ]; then 
    source ${ENV_FILE_NAME}
else 
    echo "error environment file '${ENV_FILE_NAME}' not found"
    exit 1
fi

####################################################
#                    Dependencies
####################################################

. ./modules/log.sh

####################################################
#                 Common utils function
####################################################

checkMandatoryVariable() {
### valid that all variables tagged as mandatory are defined ###
    MANDATORY_VAR_LIST_TMP=$1
    for var in "${MANDATORY_VAR_LIST[@]}"; do
        if [[ -z "${!var}" ]]; then
            error "$var is not defined or is empty."
            return 1
        fi
    done
}

####################################################
#              Main function
####################################################

validate_log_path

## check mandatory var
checkMandatoryVariable ${MANDATORY_VAR_LIST} || error_exit "mandatory variable not defined, see errors above"

## make sure that all host path exist
mkdir -p $(dirname ${SSC_GENERATION_HOST_PATH}) $(dirname ${CERTBOT_NGINX_CONFIG_FILE_PATH}) $(dirname ${CERTBOT_HOST_DATA_PATH}) $(dirname ${CERTBOT_HOST_WWW_PATH})

## generate self-signed certificate
docker run --rm -v ${SSC_GENERATION_HOST_PATH}:/certs -e SSL_SUBJECT=${DOMAIN_NAME}  paulczar/omgwtfssl
if [ $? -eq 0 ]; then
    log "Self signed certificate successfuly generated for domain : '${DOMAIN_NAME}' at path : '${SSC_GENERATION_HOST_PATH}'"
else
    error_exit "Fail to generate self signed certificate for domain : '${DOMAIN_NAME}'"
fi

## generate nginx simple configuration file to use

cat << EOF > ${CERTBOT_NGINX_CONFIG_FILE_PATH}
server {

    listen 80;
    listen [::]:80;
    server_name ${DOMAIN_NAME};

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }
}

server {
    listen 443 ssl;
    listen [::]:443;
    server_name ${DOMAIN_NAME};

    ssl_certificate /etc/ssl/fake/cert.pem;
    ssl_certificate_key /etc/ssl/fake/key.pem;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }
}
EOF


## start a simple nginx container for certbot check
# - volume for dummy certificate at : SSC_GENERATION_HOST_PATH:/etc/ssl/fake/
# - volume for certbot shared file  : CERTBOT_HOST_WWW_PATH:/var/www/certbot
# - volume for nginx config file : CERTBOT_NGINX_CONFIG_FILE_PATH:/etc/nginx/nginx.conf
NGINX_CONTAINER_ID=$(docker run -d --rm -p 80:80/tcp -v ${SSC_GENERATION_HOST_PATH}:/etc/ssl/fake/ -v ${CERTBOT_HOST_WWW_PATH}:/var/www/certbot -v ${CERTBOT_NGINX_CONFIG_FILE_PATH}:/etc/nginx/conf.d/default.conf nginx)

## start certbot container to generate let's encrypt certificate
# - volume for certbot shared file  : CERTBOT_HOST_WWW_PATH:/var/www/certbot
# - volume for generated file : /etc/letsencrypt/live/${DOMAIN}/privkey.pem

if [ $CERTBOT_STAGING != "0" ]; then CERTBOT_STAGING_ARG="--staging"; fi

docker run --rm -v ${CERTBOT_HOST_WWW_PATH}:/var/www/certbot -v ${CERTBOT_HOST_DATA_PATH}:/etc/letsencrypt/ certbot/certbot:${CERTBOT_IMAGE_VERSION} certonly --webroot -w /var/www/certbot -d ${DOMAIN_NAME} --rsa-key-size ${CERTBOT_RSA_KEY_SIZE} --non-interactive --agree-tos --force-renewal ${CERTBOT_STAGING_ARG} -m ${CERTBOT_EMAIL}

if [ $? -eq 0 ]; then
    log "let's encrypt certificate successfuly generated for domain : '${DOMAIN_NAME}' at path : '${CERTBOT_HOST_DATA_PATH}'"
    docker stop ${NGINX_CONTAINER_ID}
else
    docker stop ${NGINX_CONTAINER_ID}
    error_exit "Fail to generate let's encrypt certificate for domain : '${DOMAIN_NAME}'"
fi
