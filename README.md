# Running [Lively Web](https://github.com/LivelyKernel/LivelyKernel) on Docker

## Install and Run Lively

Using the Dockerfile in this repo you can now build and run Lively:

```sh
git clone https://github.com/LivelyKernel/lively-docker/
docker build --rm -t lively-server .
./start.sh
```

The script will create a a directory LivelyKernel in the base folder if no such
folder exists yet and will git clone Lively into it. If you want to use an
exisiting Lively install just copy it into this LivelyKernel folder before
running start.sh.

<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- -->

## [Docker](http://www.docker.com/) setup on MacOS

1. Install docker as described here: https://docs.docker.com/installation/mac/

2. Make sure that the tcp port the Lively server is running on is forwarded by docker-machine (actually virtualbox):
`VBoxManage controlvm "$(docker-machine ls -q | head -n 1)" natpf1 "lively-server,tcp,127.0.0.1,9001,,9001"`
