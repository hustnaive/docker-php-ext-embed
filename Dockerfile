FROM hustnaive/php-ext-dev:5.5.29
MAINTAINER Fang Liang <hustnaive@me.com>

ADD php-ext-embed /tmp/php-ext-embed

#调整一下m4文件中的一些问题
RUN sed -i -e 's/PHP_EXT_EMBED_DIR\=php-ext-embed/PHP_EXT_EMBED_DIR\=\/tmp\/php-ext-embed/g' /tmp/php-ext-embed/php_ext_embed.m4
RUN sed -i -e 's/m4_include(php-ext-embed\/php_ext_embed.m4)/m4_include(\/tmp\/php-ext-embed\/php_ext_embed.m4)/g' /tmp/php-ext-embed/sample/config.m4

WORKDIR /tmp/php-ext-embed/sample

#生成配置文件
RUN cd /tmp/php-ext-embed/sample && phpize && ./configure

#替换makefile中生成的错误路径（目前还没找到原因）
RUN sed -i -e 's/tmp\/php-ext-embed\/sample\/\/tmp\/php-ext-embed/tmp\/php-ext-embed/g' /tmp/php-ext-embed/sample/Makefile

WORKDIR /tmp/php-ext-embed/

RUN make all

RUN echo n | make test