#!/bin/bash

mkdir -p $HOME/LivelyKernel

# if the lively dir is empty first install it
dir_content=`ls -A "$HOME/LivelyKernel" 2>/dev/null`
cd $HOME/LivelyKernel;
if [[ -z $dir_content ]]; then
    branch=${git_branch-master}
    git clone --branch $branch --single-branch https://github.com/LivelyKernel/LivelyKernel .
fi

rm *.pid 2>/dev/null;

forever bin/lk-server.js \
     --host 0.0.0.0 \
     -p 9001 \
     --behind-proxy | tee $HOME/logs/lively.log
