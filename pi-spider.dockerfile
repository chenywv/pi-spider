FROM armhf/alpine
# maintainer vic.chen

ADD qemu-arm-static /usr/bin/

RUN cp /etc/apk/repositories /etc/apk/repositories.bak \
    && echo "http://mirrors.aliyun.com/alpine/v3.5/main/" > /etc/apk/repositories
RUN apk update && apk add python3 python3-dev build-base openssl-dev py3-lxml py3-cryptography bash

RUN mkdir ~/.pip \
    && echo -e "[global]\nindex-url = http://pypi.douban.com/simple\n[install]\ntrusted-host=pypi.douban.com" > ~/.pip/pip.conf \
    && echo -e "[easy_install]\nindex_url = http://pypi.douban.com/simple" > ~/.pydistutils.cfg \
    && echo -e "alias ls=\"ls --color=auto\"\nalias ll=\"ls -lh\"\nalias " > /root/.bashrc \
    && mkdir /root/scrapy

RUN pip3 install scrapy

WORKDIR /root/scrapy
CMD /bin/bash
