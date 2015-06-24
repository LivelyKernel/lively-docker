FROM          node
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>

USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update; \
    apt-get upgrade -y; \
    apt-get -y install curl git bzip2 unzip zip \
                       sudo lsof sysstat dnsutils

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# lively user
RUN /usr/sbin/useradd \
    --create-home --home-dir /home/lively \
     --shell /bin/bash \
     --groups sudo \
     --password niHEcdDiD3J1o \
     lively

# nodejs tooling
RUN npm install forever -g

# lively
ENV WORKSPACE_LK=/home/lively/LivelyKernel \
    HOME=/home/lively

USER lively

RUN mkdir /home/lively/bin
ENV PATH=$HOME/bin:$PATH

ADD gitconfig /home/lively/.gitconfig
ADD start-lively-server.sh /home/lively/bin/start-lively-server.sh
USER root
RUN chown lively $HOME/bin/start-lively-server.sh; \
    chmod a+x $HOME/bin/start-lively-server.sh
USER lively

EXPOSE 9001 9002 9003 9004 9005

WORKDIR /home/lively/LivelyKernel

CMD start-lively-server.sh