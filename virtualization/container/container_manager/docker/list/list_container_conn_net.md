# list connected network to container

docker inspect --format='{{json}}: {{range .NetworkSettings.Networks}}{{.NetworkID}} {{end}}' $(docker ps -aq) 


docker inspect --format='{{json .range .NetworkSettings.Networks}}{{.NetworkID}} end' $(docker ps -aq)   | jq


docker network inspect --format='{{.Name}}' <network_id>


docker ps -q | xargs -I {} docker inspect --format='{"ContainerName": "{{.Name}}", "Networks": {{json .NetworkSettings.Networks.NetworkID}}}' {}
