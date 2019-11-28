# Running [Lively Web](https://github.com/LivelyKernel/LivelyKernel) on Docker

## Prerequisites

You need to have [git](https://git-scm.com/) and
[docker](https://docs.docker.com/install/) available on the machine that should
host Lively.

## Install and Run Lively

Using the Dockerfile in this repo you can now build and run Lively:

```sh
git clone https://github.com/LivelyKernel/lively-docker/
cd lively-docker
docker build --rm -t lively-server .
./start.sh
```

The script will create a directory LivelyKernel in the base folder if no such
folder exists yet and will clone the LivelyKernel repository into it.
Additionally, it will pull down the PartsBin and user directory from
[lively-web.org](https://lively-web.org). If you want to use an exisiting Lively
install just copy it into this LivelyKernel folder before running start.sh.

After the setup steps are done you will be able to acess Lively at http://localhost:9001/

<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- -->

## Notes for MacOS

## [Docker](http://www.docker.com/) setup on MacOS

1. Install docker as described here: https://docs.docker.com/installation/mac/

2. Make sure that the tcp port the Lively server is running on is forwarded by docker-machine (actually virtualbox):
`VBoxManage controlvm "$(docker-machine ls -q | head -n 1)" natpf1 "lively-server,tcp,127.0.0.1,9001,,9001"`
