# think-swoole 分支

## 1. 自动重载和配置

- `app` 控制器的修改可以自动重载，但配置文件的修改需要重启服务才生效。

- 在 Docker 容器间配置 MySQL 时，使用服务名而不是 `localhost`：
    ```php
    'hostname' => env('DB_HOST', 'mysql'),
    ```

- 根目录下 `.env` 文件开启调试模式：
    ```dotenv
    APP_DEBUG=true
    ```

- 用以下方法测试数据库连接：
    ```php
    use think\facade\Db;

    public function test_db()
    {
        $result = Db::table('mysql.user')
                    ->where('user', 'root')
                    ->field('user, host, plugin, authentication_string')
                    ->select();
        return json($result);
    }
    ```

## 2. 端口占用和 Redis 配置

- 若本地有 3306 端口占用，Docker 映射冲突不会明显报错，但会映射失败。

- 已配置好 Redis 拓展，可以使用以下代码测试 Redis 连接：
    ```php
    use Redis;

    public function test_redis()
    {
        // 创建 Redis 对象
        $redis = new Redis();
        $redis->connect('redis', 6379);
        $redis->set('test_key', 'Hello, Redis!');
        $value = $redis->get('test_key');
        $redis->close();
        return $value;
    }
    ```

## 3. ClickHouse 自构建

- 选择自构建 ClickHouse，按需逐步拓展。
- 配置文件使用自定义的 `config.xml`，并附官方的 `config.full.xml` 供参考。
