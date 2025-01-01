# buildx image build

## Description

This file describes how to build a image container (docker/podman) using buildx on a jenkins pipeline.

This pipeline assume that buildx is already installed. See [official buildx documentation about how to install it](https://github.com/docker/buildx?tab=readme-ov-file#installing).


```
stage('Build Docker Image') {
    environment {
        DOCKER_BUILDKIT = 1
    }
    steps {
        script {
            docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
        }
    }
}
```