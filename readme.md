

## 项目名称：
Docker跨容器组网络通讯测试

## 项目简介：
通过此示例，测试docker跨容器组网络通讯逻辑

## 目录结构

```plaintext
project1/
|-- docker-compose.yml
|-- service1/
|   |-- Dockerfile
|   |-- app.js
|   `-- package.json

project2/
|-- docker-compose.yml
|-- service2/
    |-- Dockerfile
    |-- app.js
    `-- package.json
```
## 特别注意
在自己默认网络下，拥有“昵称”和全名，加入的网络则没有昵称，需要全名。  
比如service1，本就在shared，可以用http://service1:3000访问，connect加入，则需要用全名http://project1-service1-1:3000访问。  
全名的格式为：`目录名-服务名-序号`  
可以进入到对应的容器中，curl host 测试

## 准备工作

确保已安装以下工具：
- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## 快速开始

### 创建共享网络

首先，创建一个共享网络：

```bash
docker network create shared
```

### 构建和启动服务

分别启动两个项目：

```bash
cd project1
docker-compose up -d --build

cd ../project2
docker-compose up -d --build
```


#### 一些相关指令

```bash
docker network create shared
docker network ls
docker network rm shared

docker network inspect shared

docker network connect shared ID
docker network disconnect shared ID

docker ps --format '{{.Names}}' 
```

### 访问服务

打开浏览器访问：

- 项目 1 服务: `http://localhost:3001`
- 项目 2 服务: `http://localhost:3002`



```

## 许可证

本项目遵循 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。
```
