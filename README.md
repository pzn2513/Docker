# Docker
Docker相关功能实践，对学习到的知识进行汇总记录

安装环境：centos7.6  
docker安装
```bash
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum makecache fast
yum -y install docker-ce
systemctl start docker
```

docker-compose安装
```bash
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

## 配置nginx+php+mysql+phpmyadmin
### 要点：  
#### 1、nginx需要配置php-fpm  
nginx配置文件在：  
/etc/nginx/conf.d/default.conf  
网站目录：  
/usr/share/nginx/html  
加入以下代码
```bash
    location ~ \.php$ {
        root           html;
        fastcgi_pass   172.24.0.3:9000;#此处需要填写你的php容器的docker内部通讯ip
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  /usr/share/nginx/html/$fastcgi_script_name;
        include        fastcgi_params;
    }
```
#### 2、php用fpm版本，并用dockerfile进行拓展编译
docker build -t myphp .
#### 3、mysql指定初始密码，并修改加密方式  
见docker-compose.yml  
启动后进入mysql容器：docker exec -it mysql bash  
改密码及加密方式：
```bash
alter user 'root'@'%' identified with mysql_native_password by 'password';
flush privileges;
```

#### 4、加入phpmyadmin
config.inc.php是它的配置文件，默认没有。可以cp config.sample.inc.php


# docker高级指令
```bash
docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -q)
```
