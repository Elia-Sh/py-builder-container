# syntax=docker/dockerfile:1

## Defining codename to control over which major release is pulled
## always refer to docs, https://docs.docker.com/reference/dockerfile/#understand-how-arg-and-from-interact
ARG VERSION_CODENAME="focal"
FROM ubuntu:${VERSION_CODENAME}

ARG VERSION_CODENAME="focal"
RUN echo "setting up ubuntu - ${VERSION_CODENAME}"
ARG sources_file_path="/etc/apt/sources.list"
ARG focal_archive_str="deb-src http://archive.ubuntu.com/ubuntu/ ${VERSION_CODENAME} main restricted"
RUN echo ${focal_archive_str} >> ${sources_file_path}
RUN apt-get update
#RUN apt install -y python3

# tzdata is req for building python3, setting not interactive install
RUN DEBIAN_FRONTEND=noninteractive TZ=UTC apt-get -y install tzdata
# installing rest of dependencies
RUN apt-get -y install build-essential gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev

# volume containing source files for python3
VOLUME /mnt/mounted_volume

