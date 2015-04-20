FROM          dockerfile/nodejs
MAINTAINER    Robert Krahn <robert.krahn@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install curl git bzip2 unzip

# for debugging
RUN npm install -g node-inspector
RUN apt-get install lsof

# lively
RUN mkdir -p /var/www/
RUN git clone https://github.com/LivelyKernel/LivelyKernel /var/www/LivelyKernel

WORKDIR /var/www/LivelyKernel
RUN npm install
ENV WORKSPACE_LK /var/www/LivelyKernel

# PartsBin
RUN node -e "require('./bin/env'); require('./bin/helper/download-partsbin')();"
# ADD PartsBin/ /var/www/LivelyKernel/PartsBin/ # <-- alternative

# optional lively dependencies
RUN npm install forever -g

# object DB, sqlite
# ADD objects.sqlite /var/www/LivelyKernel/objects.sqlite

ENV livelyport 9001
EXPOSE 9001
EXPOSE 9002
EXPOSE 9003
EXPOSE 9004

CMD npm start
