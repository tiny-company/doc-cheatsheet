# Generate ssl for nginx

## Description

A simple script to generate an ssl certificate using docker container.

## Prerequisite

- in order to perform certbot check, server on which script is launch must be configured to answer to dns domain configured

## Usage 

- define mandatory vars in env file :
```
DOMAIN_NAME="test.example.fr"
CERTBOT_EMAIL="email@mail.com"
CERTBOT_HOST_DATA_PATH=~/certificate_for_nginx
```

- launch the script
```
chmod +x generate_ssl_for_nginx.sh
./generate_ssl_for_nginx.sh
```

certificate should be generated at : ~/certificate_for_nginx/certificates/live/test.example.fr


## Sources : 

- [docker-nginx-certbot](https://github.com/JonasAlfredsson/docker-nginx-certbot/)
- [certbot documentation](https://eff-certbot.readthedocs.io/en/stable/index.html)
- [self signed generator docker container](https://github.com/stakater/dockerfile-ssl-certs-generator)
- [OMGWTFSSL - Self Signed SSL Certificate Generator docker container](https://github.com/paulczar/omgwtfssl)
- [An Elegant way to use docker-compose to obtain and renew a Let’s Encrypt SSL certificate with Certbot and configure the NGINX service to use it](https://blog.jarrousse.org/2022/04/09/an-elegant-way-to-use-docker-compose-to-obtain-and-renew-a-lets-encrypt-ssl-certificate-with-certbot-and-configure-the-nginx-service-to-use-it/)
- [Nginx and Let’s Encrypt with Docker in Less Than 5 Minutes](https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71)
- [certbot renew certificate for nginx shell script](https://raw.githubusercontent.com/wmnnd/nginx-certbot/master/init-letsencrypt.sh)