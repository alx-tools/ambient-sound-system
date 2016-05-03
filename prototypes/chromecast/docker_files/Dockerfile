FROM debian:jessie
MAINTAINER John Serrano<johnserrano404@gmail.com>

RUN apt-get update && apt-get install -y git
RUN apt-get install -y npm

COPY node-v5.6.0-linux-x64 /opt/node

RUN npm install castnow -g

RUN cp /opt/node/bin/node /bin/node
