FROM hustnaive/php-ext-dev:5.5.29
MAINTAINER Fang Liang <hustnaive@me.com>

ADD php-ext-embed /tmp/php-ext-embed

WORKDIR /tmp/php-ext-embed/sample

#生成配置文件
RUN cd /tmp/php-ext-embed/sample && phpize && ./configure

#替换makefile中生成的错误路径（目前还没找到原因）
RUN sed -i -e 's/tmp\/php-ext-embed\/sample\/\/tmp\/php-ext-embed/tmp\/php-ext-embed/g' /tmp/php-ext-embed/sample/Makefile

WORKDIR /tmp/php-ext-embed/

RUN make all