# yamllint

## Description

This file will describe how to launch a jenkins CI yamllint pipeline.

```
stage('Yamllint') {
    steps{
        sh 'docker run --rm --user yamllint -v $(pwd):/data contane/yamllint -c ./.yamllint/.yamllint_conf -f colored .'
    }
}
```