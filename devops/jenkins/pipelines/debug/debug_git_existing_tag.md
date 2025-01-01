# debug existing git tag in jenkins pipeling

When pushing new tag (with incremental feature) in a pipeline, if the tag is not deleted in case of failure then the error "tag already exist occured" (i.e : `fatal: tag '1.0.8' already exists`)

To solve this issue, we need to go to the jenkins worker to manually delete the tag.

Example below with dockerize jenkins worker/agent :
```
docker exec -it jenkins_agent /bin/sh
cd /home/jenkins/agent/workspace/<path_to_the_job>
git config --global --add safe.directory /home/jenkins/agent/workspace/<path_to_the_job>
git tag -d <already_existing_tag>
git push origin --delete <already_existing_tag>
rm -r /home/jenkins/agent/workspace/<path_to_the_job>/*
```