# bta-docker (in progress..)


Automated build of bta, an open-source Active Directory security audit framework.

    
## Docker image size

[![](https://imagelayers.io/badge/2xyo/bta:latest.svg)](https://imagelayers.io/?images=2xyo/bta:latest 'latest')


# Build 

Build from source:

    $ git clone https://github.com/2xyo/docker-bta.git
    $ cd docker-bta && docker build -t 2xyo/bta .


Or download from Docker Hub:

    $ docker pull 2xyo/bta 


# Play with bta


Start a mongodb container with persitence:

    $ mkdir -p $HOME/data/bta
    $ docker run --name bta-mongo \
        -p 27017:27017 \
        -v $HOME/data/bta:/data/db \
        -d mongo:latest
    $ docker ps


Download a precious for testing (this is not the best sample `ntds.dit`):

    $ mkdir -p $HOME/data/ntdis && \
        cd $HOME/data/ntdis
    $ curl -L -O https://github.com/ANSSI-FR/AD-permissions/raw/master/dbbrowser/sample_data/ntds.7z
    $ 7z x ntds.7z

Import the precious into mongodb:

    $ docker run --link bta-mongo:bta-mongo \
        -v $HOME/data/ntdis:/tmp/ \
        2xyo/bta \
        btaimport -C bta-mongo:27017:mydb /tmp/ntds.dit

Have fun:

    $ docker run --link bta-mongo:bta-mongo \
        2xyo/bta \
        btaminer -t ReST -C bta-mongo:27017:mydb Membership



Play inside the container:

    $ docker run --link bta-mongo:bta-mongo \
        -v $HOME/data/ntdis:/tmp/ \
        -it --entrypoint=/bin/bash \
        2xyo/bta
