think-swoole分支

1.
app 控制器的修改可以自动重载，配置文件的修改就需要重启服务才生效。
docker容器间，配置mysql，用服务名而不是localhost：
'hostname' => env('DB_HOST', 'mysql'),

根目录下.env文件开启调试模式：
APP_DEBUG=true

用此方法测试数据库连接：
use think\facade\Db;
...
public function test_db()
{
    $result = Db::table('mysql.user')
                ->where('user', 'root')
                ->field('user, host, plugin, authentication_string')
                ->select();
    return json($result);
}



2.
若本地有3306占用，docker映射冲突不会明显报错，但会映射失败。
已配置好redis拓展：
use Redis;
...
public function test_redis()
{
    // 创建Redis对象
    $redis = new Redis();
    $redis->connect('redis', 6379);
    $redis->set('test_key', 'Hello, Redis!');
    $value = $redis->get('test_key');
    $redis->close();
    return $value;
}

3.
选择自构建clickhouse，按需逐步拓展。配置文件使用自定义config.xml，附官方config.full.xml供参考。