# 用swoole可以不用fpm
FROM php
WORKDIR /wwwroot
# 更新包列表并安装必要的依赖
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    pkg-config \
    libbrotli-dev \
    wget \
    git \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql
# 安装 Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
# 安装 Swoole，Redis 扩展
RUN pecl install swoole \
    && docker-php-ext-enable swoole
RUN pecl install redis \
    && docker-php-ext-enable redis


COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
