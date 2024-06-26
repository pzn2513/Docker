#!/bin/bash

# 等待配置文件挂载完成
while [ ! -f /etc/clickhouse-server/config.xml ]; do
  echo "Waiting for config.xml to be available..."
  sleep 1
done

# 配置文件挂载完成后启动 ClickHouse 服务器
exec /home/clickhouse server --config-file=/etc/clickhouse-server/config.xml
