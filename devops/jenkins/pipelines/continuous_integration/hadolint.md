# hadolint

## Description

Find below jenkins pipeline examples to create CI hadolint job :

```
stage ("hadolint") {
    agent {
        docker {
            image 'hadolint/hadolint:latest-debian'
        }
    }
    steps {
        sh 'hadolint --config .hadolint.yaml Dockerfile'
    }
}
```

This pipeline assume that the docker plugin is already installed. It will start a new docker container based on 'hadolint/hadolint:latest-debian' and then launch cmd 'hadolint --config .hadolint.yaml Dockerfile' in this container to apply hadolint on the Dockerfile.