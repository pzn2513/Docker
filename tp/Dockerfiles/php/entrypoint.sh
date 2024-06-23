#!/bin/sh

# 检查 tp 项目是否存在，如果不存在则创建
if [ ! -d "/wwwroot/tp" ]; then
  echo "Project directory does not exist. Creating project..."
  composer create-project topthink/think /wwwroot/tp
else
  echo "Project directory already exists. Skipping project creation."
fi

# 执行传递的命令
exec "$@"