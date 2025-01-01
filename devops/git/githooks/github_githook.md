# github githook

## Repository githook

- Under the repository click on tabs 'Settings'
- On left panel, click on 'WebHooks'
- On top right, click on 'Add Webhook'
- Then fill the form :
    - Payload URL (jenkins example): `https://<jenkins-url>/github-webhook/`
    - Content Type : application/json
    - Secret : webhook secret (see secret manager)
    - SSL Validation (disable this might be very unsecure): Enable SSL verification
    - Choose event to send : (push)
    - Enable or disable webhook : (Active)

[See more at official github documentation](https://docs.github.com/en/webhooks/using-webhooks/creating-webhooks#creating-a-repository-webhook)
