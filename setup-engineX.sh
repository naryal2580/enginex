#!/bin/bash

container_name="enginex"

cd $container_name

docker build -t $container_name .

# docker run -d --rm --name "$container_name" -p 8888:80 -p 4444:443 $container_name

docker run -d --rm --name "$container_name" -p 80:80 -p 443:443 $container_name

docker exec -it "$container_name" vhost
