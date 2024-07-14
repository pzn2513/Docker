#!/bin/sh

# 检查 tp 项目是否存在，如果不存在则创建并移预设（不覆盖），如果存在则跳过创建删除预设
if [ ! -d "/wwwroot/tp" ]; then
  echo "Project directory does not exist. Creating project..."
  composer create-project topthink/think /wwwroot/tp
  mv -n /home/_Ghini_build/Test.php /wwwroot/tp/app/controller/Test.php
  echo "Moved /home/_Ghini_build/Test.php to /wwwroot/tp/app/controller/Test.php"
  mv -n /home/_Ghini_build/.env /wwwroot/tp/.env
  echo "Moved /home/_Ghini_build/.env to /wwwroot/tp/.env"
else
  # echo "Project directory already exists. Skipping project creation. rm -rf /home/_Ghini_build"
  rm -rf /home/_Ghini_build
fi

# 进入 tp 目录并确保权限
cd /wwwroot/tp
chmod +x think
# 检查并安装 topthink/think-swoole
if ! composer show | grep -q "topthink/think-swoole"; then
  echo "Installing topthink/think-swoole..."
  composer require topthink/think-swoole
# else
#   echo "topthink/think-swoole already exists. Skipping."
fi
# 检查并安装 GuzzleHttp
if ! composer show | grep -q "guzzlehttp/guzzle"; then
  echo "Installing GuzzleHttp..."
  composer require guzzlehttp/guzzle
# else
#   echo "GuzzleHttp already exists. Skipping."
fi

exec php think swoole