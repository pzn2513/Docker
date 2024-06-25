# 使用Ubuntu 20.04作为基础镜像
FROM ubuntu:20.04

# 设置工作目录
WORKDIR /home

# 更新包列表并安装curl
RUN apt-get update && apt-get install -y curl
# 下载并安装ClickHouse
RUN curl https://clickhouse.com/ | sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
# CMD ["tail", "-f", "/dev/null"]