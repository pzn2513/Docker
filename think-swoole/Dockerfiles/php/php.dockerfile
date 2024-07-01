# 用swoole可以不用fpm
FROM php
WORKDIR /wwwroot
# 更新包列表并安装必要的依赖
RUN apt-get update && apt-get install -y \
    libssl-dev libzip-dev unzip git \
    pkg-config \
    libbrotli-dev \
    wget \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql
# 安装 Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
# # 安装 Swoole，Redis 扩展
# RUN pecl install swoole --with-openssl-dir=/usr/include/openssl \
#     && docker-php-ext-enable swoole
# 下载并手动编译 Swoole，启用 OpenSSL 支持
RUN git clone https://github.com/swoole/swoole-src.git \
    && cd swoole-src \
    && phpize \
    && ./configure --enable-openssl \
    && make \
    && make install \
    && docker-php-ext-enable swoole \
    && cd .. \
    && rm -rf swoole-src
RUN pecl install redis \
    && docker-php-ext-enable redis


COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY Test.php /home/_Ghini_build/Test.php
COPY .env /home/_Ghini_build/.env
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
