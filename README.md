
# Simple docker container
How to run ubuntu 20.04 - focal docker
```
# pull imange
$ docker pull ubuntu:focal

# start container
$ docker run -it ubuntu:focal

# mount a local dir as volume:
$ mkdir mounted_volumed
$ docker run -it -v ./mounted_volume:/mnt/mounted_volume ubuntu:focal
```


# Using a docker file
Dockerfile example:
```
# syntax=docker/dockerfile:1

FROM ubuntu:focal
RUN apt-get update
RUN apt install -y python3

VOLUME /mnt/mounted_volume
```


build image from docker file and tag image
```
$ docker build . -t py_focal
```

start container from tagged image
```
$ docker run -it -v mounted_volume:/mnt/mounted_volume py_focal
```


# Building python from source
reference
```
# release sources example:
https://www.python.org/downloads/release/python-3717/

# dependencies:
https://devguide.python.org/getting-started/setup-building/#build-dependencies
```

instructions:
```
#1. run prepare utility to download py3 source and setup build dir at: `./mounted_volume`
$ /bin/sh prepare_build.sh

#2. start container with locally created dir
$ docker run -it -v ./mounted_volume:/mnt/mounted_volume py_focal

#3. configure and make -> executed within newly spinned container
$ cd mnt/mounted_volume/py_src/Python-3.7.17/
$ ./configure
$ make install

#4. enjoy newly built python
$ which python3
/usr/local/bin/python3
$ python3
Python 3.7.17 (default, Apr 27 2024, 15:13:35) 
[GCC 9.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>

```




