# libyui development machine
# https://github.com/libyui/libyui
FROM opensuse:42.2
MAINTAINER Martin Vidner <mvidner@suse.cz>
WORKDIR /root/docker-build
COPY bootstrap.sh functions.sh ./
RUN ./bootstrap.sh

