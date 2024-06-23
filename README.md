操作步骤：  
cd tp  
docker-compose up -d --build  

访问https://localhost 出现tp主页即为成功。



项目环境配置说明
该项目使用 Docker Compose 来管理多个服务，以便在开发和测试过程中提供一致的环境。以下是每个服务的配置说明：

1. PHP 服务
路径：Dockerfiles/php
Dockerfile：php83
挂载卷：
./wwwroot:/wwwroot：将主机的 wwwroot 目录挂载到容器的 /wwwroot 目录。
./etc/php/php.ini:/usr/local/etc/php/php.ini：将主机的 php.ini 配置文件挂载到容器的相应位置。
网络：backend
2. Nginx 服务
镜像：nginx
端口映射：
80:80：将主机的 80 端口映射到容器的 80 端口。
443:443：将主机的 443 端口映射到容器的 443 端口。
挂载卷：
./wwwroot:/wwwroot：将主机的 wwwroot 目录挂载到容器的 /wwwroot 目录。
./etc/nginx/ssl:/etc/nginx/ssl：将主机的 SSL 配置目录挂载到容器的相应位置。
./etc/nginx/conf.d:/etc/nginx/conf.d：将主机的 Nginx 配置目录挂载到容器的相应位置。
依赖：php
网络：backend
环境变量：设置时区 Asia/Shanghai
3. MySQL 服务
镜像：mysql:8.0
环境变量：
TZ=Asia/Shanghai：设置时区为上海。
MYSQL_ROOT_PASSWORD=root_531642：设置 MySQL root 用户的密码。
MYSQL_DATABASE=mydb：创建一个名为 mydb 的数据库。
挂载卷：
mysql_data:/var/lib/mysql：将主机的 mysql_data 卷挂载到容器的 MySQL 数据目录。
端口映射：
3306:3306：将主机的 3306 端口映射到容器的 3306 端口。
网络：backend
4. Redis 服务
镜像：redis
挂载卷：
redis_data:/data：将主机的 redis_data 卷挂载到容器的 Redis 数据目录。
端口映射：
6379:6379：将主机的 6379 端口映射到容器的 6379 端口。
网络：backend
命令：
redis-server --appendonly yes --appendfsync everysec：启用 AOF 操作持久化。
5. ClickHouse 服务
镜像：yandex/clickhouse-server
容器名称：clickhouse-server
端口映射：
8123:8123：将主机的 8123 端口映射到容器的 8123 端口。
9000:9000：将主机的 9000 端口映射到容器的 9000 端口。
9009:9009：将主机的 9009 端口映射到容器的 9009 端口。
挂载卷：
clickhouse_data:/var/lib/clickhouse：将主机的 clickhouse_data 卷挂载到容器的 ClickHouse 数据目录。
网络：backend
可选服务（未启用）
Kafka：wurstmeister/kafka
Zookeeper：wurstmeister/zookeeper
RabbitMQ：rabbitmq:management
网络
backend：后端服务网络。
frontend：前端服务网络（未使用）。
挂载卷
mysql_data：MySQL 数据卷。
clickhouse_data：ClickHouse 数据卷。
redis_data：Redis 数据卷。
