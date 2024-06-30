<div style="font-size: 32px; ">
    ✨ <span style="font-family: '思源黑体', sans-serif; font-weight: bold; 
            background: -webkit-linear-gradient(45deg, #f3ec78, #af4261); 
            -webkit-background-clip: text; color: transparent; 
            text-align: center; margin-top: 20px;">think-swoole 分支</span> 🚀
</div>

## 准备工作
1. Git设置，统一LF设置，不然entrypoint.sh等LF换行可能会在win被替代为CRLF，导致sh脚本启动运行时报错
2. 最好需要能连上外网环境，避免有网络异常，compose构建时遇到异常尝试多运行几次
```bash
# Windows系统
git config --global core.autocrlf input
git clone -b think-swoole https://github.com/pzn2513/Docker.git
cd Docker/think-swoole
docker-compose up -d --build
cp .\example\.env .\wwwroot\tp
docker-compose restart php
cp .\example\test.php .\wwwroot\tp\app\controller\Test.php
```
测试运行
```
https://localhost/test/mysql
https://localhost/test/redis
https://localhost/test/https
https://localhost/test/clickhouse
http://localhost:9200/_license
http://localhost:5601
Kibana主页
    Management-开发工具-控制台：将example/kibana.console内容复制到控制台中进行测试。
    Management-Stack Management-数据视图：添加filebeat数据源
    Analytics-Discover：查看filebeat数据源
```

## 注意事项
