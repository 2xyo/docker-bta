FROM ubuntu:14.04
MAINTAINER Yohann Lepage <yohann@lepage.info>

RUN apt-get update && \
    apt-get -y install software-properties-common apt-transport-https

RUN add-apt-repository -y ppa:gift/stable

RUN apt-get update && \
    apt-get -y install python-pymongo python-dev curl git python-ldap make

WORKDIR /opt

RUN curl -L -O https://bitbucket.org/iwseclabs/bta/downloads/libesedb-alpha-20120102.tar.gz && \
    tar xzf libesedb-alpha-20120102.tar.gz && \
    cd libesedb-20120102 && \
    ./configure && \
    make && \
    make install 

RUN curl https://bootstrap.pypa.io/get-pip.py | python 

RUN pip install --upgrade git+https://bitbucket.org/iwseclabs/bta.git#egg=bta

RUN apt-get clean &&  rm -rf /var/cache/apt/* /var/lib/apt/lists/*

# Set terminal to UTF-8 by default
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8


WORKDIR /usr/local/bin
COPY "bta-switch.sh" "bta-switch.sh"
RUN chmod a+x bta-switch.sh


ENTRYPOINT ["/usr/local/bin/bta-switch.sh"]