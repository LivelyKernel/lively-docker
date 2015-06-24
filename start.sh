#!/bin/bash

# build the container with
#   docker build --rm -t lively-web-server .

port=${1-9001}
git_branch=${2-master}
container_name=lively-server
data_dir=$PWD/LivelyKernel
log_dir=$PWD/logs

mkdir -p $data_dir
mkdir -p $log_dir


docker_procs=$(docker ps | grep $container_name | awk '{ print $1 }')
if [ -n "$docker_procs" ]; then
    echo "docker for container $container_name already running ($docker_procs)... stopping it..."
    sleep 1
    echo $docker_procs | xargs docker stop
    sleep 1
fi

docker run \
    --rm \
    -v $data_dir:/home/lively/LivelyKernel \
    -v $log_dir:/home/lively/logs \
    -p $port:9001 \
    -p 9002:9002 \
    -p 9003:9003 \
    -p 9004:9004 \
    --env git_branch="$git_branch" \
    -t \
    $container_name

echo "[$(date +"%Y-%m-%d_%H:%M:%S")] Docker exited with $?"
