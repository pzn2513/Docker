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

### 配置nginx+php+mysql+phpmyadmin
要点：  
1、nginx需要配置php-fpm  
2、php用fpm版本，并用dockerfile进行拓展编译  
3、mysql指定初始密码，并修改加密方式  


# docker高级指令
```bash
docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -q)
```
