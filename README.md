# Running [Lively Web](https://github.com/LivelyKernel/LivelyKernel) on Docker

## Install and Run Lively

Using the Dockerfile in this repo you can now build and run Lively:

```sh
git clone https://github.com/LivelyKernel/lively-docker/
docker build --rm -t lively-server .
./start.sh
```

The script will create a a directory LivelyKernel in the base folder if no such folder exists yet and will git clone Lively into it. If you want to use an exisiting Lively install just copy it into this LivelyKernel folder before running start.sh.


<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- -->



## [Docker](http://www.docker.com/) setup on MacOS

First make sure you have [homebrew](http://brew.sh/) installed.

Docker on MacOS runs inside a [VirtualBox](https://www.virtualbox.org/) image, so please install VirtualBox as well. Since docker containers only run on Linux, the VirtualBox image will be used to host the containers on your system and runs the main docker application. In order to interact with docker you also need the boot2docker distribution. To install both run:

```sh
brew install docker boot2docker
```

Now initialize boot2docker:

```sh
boot2docker download
boot2docker init
boot2docker up
```

Make sure the rest of your sytems can talk to the boot2docker distro by copying (and executing) the enviroment settings suggested by docker (replace IP address and username):

```sh
export DOCKER_HOST=tcp://[IP address]:2376
echo 'export DOCKER_HOST=tcp://[IP address]:2376' >> ~/.bash_profile
```

### Port forwarding with boot2docker

Specifically for MacOS: Above command only forwards port 9001 from the Docker container to the boot2docker distro running in your VBox image. To also forward this port from VBox to your main machine run:

```sh
VBoxManage controlvm boot2docker-vm natpf1 "lively-server,tcp,127.0.0.1,9001,,9001"
```
