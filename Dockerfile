FROM          node:slim
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update; \
    apt-get upgrade -y; \
    apt-get -y install curl git bzip2 unzip zip \
                       lsof sysstat dnsutils

# lively user, password: livelyrocks
# openssl passwd -1 livelyrocks
RUN /usr/sbin/useradd \
    --create-home --home-dir /home/lively \
     --shell /bin/bash \
     --groups sudo \
     --password "$1$nEklFay0$7HTGsdmybFMWcH52WPqH0." \
     lively

# git
ADD gitconfig /home/lively/.gitconfig

# nodejs tooling
RUN npm install -g \
  node-inspector \
  nodemon forever \
  phantomjs \
  http-server \
  grunt-cli

# For the Lively spell checker:
RUN apt-get install -y aspell

# lively
ENV WORKSPACE_LK=/home/lively/LivelyKernel \
    HOME=/home/lively \
    livelyport=9001

USER lively

WORKDIR /home/lively/LivelyKernel

EXPOSE 9001 9002 9003 9004

CMD rm "*.pid" >/dev/null 2>&1; \
    [ ! -d node_modules/ ] && npm install; \
    forever bin/lk-server.js \
    --port 9001 --host 0.0.0.0 --behind-proxy
