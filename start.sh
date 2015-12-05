#!/bin/bash

lively_dir="$PWD/LivelyKernel"
container_name="lively-server"
container_name="lively-docker-test"

mkdir -p $lively_dir

# if the lively dir is empty first install it
dir_content=`ls -A "$lively_dir" 2>/dev/null`
if [[ -z $dir_content ]]; then
    pushd $lively_dir;
    branch=${git_branch-master}
    git clone --branch $branch --single-branch https://github.com/LivelyKernel/LivelyKernel .
    popd
fi

shutdown() { 
  echo "Stopping container..."
  docker ps --filter "image-name=$container_name" -q | xargs docker kill
}

trap shutdown SIGTERM SIGKILL SIGINT

docker run --rm \
    -v $lively_dir:/home/lively/LivelyKernel \
    -p 9001-9004:9001-9004 \
    -t $container_name
