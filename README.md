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

_Please note:_ the `start.sh` script will take a few minutes to run the first
time around. This is completly normal, just hang on ;)

After the setup steps are done (a message along the lines of `Lively server
starting...` appears in the command output) you will be able to acess Lively at
http://localhost:9001/

## Public webserver

If you want to serve Lively server as part of a public web page, [it's best](https://medium.com/intrinsic/why-should-i-use-a-reverse-proxy-if-node-js-is-production-ready-5a079408b2ca) to proxy it behind another server such as nginx. The nginx config for lively-web.org looks like:

```config
server {
    listen 80;
    server_name localhost lively-web.org www.lively-web.org;
    return 301 https://$host$request_uri;
}

server {

    listen 443;
    server_name localhost lively-web.org www.lively-web.org;

    # upload
    client_max_body_size 15m;

    # ssl
    ssl on;
    ssl_certificate /etc/letsencrypt/live/lively-web.org/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/lively-web.org/privkey.pem;

    location = / {
        index /welcome.html;
    }

    location / {
        proxy_pass http://localhost:9001;

        # proxy headers
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;

        # proxy websockets:
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

<!-- -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- -->

## Notes for MacOS

1. Install docker as described here: https://docs.docker.com/installation/mac/

2. Make sure that the tcp port the Lively server is running on is forwarded by docker-machine (actually virtualbox):
`VBoxManage controlvm "$(docker-machine ls -q | head -n 1)" natpf1 "lively-server,tcp,127.0.0.1,9001,,9001"`
