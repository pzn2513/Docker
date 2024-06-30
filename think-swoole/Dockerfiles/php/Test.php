<?php

namespace app\controller;
use app\BaseController;
use think\facade\Db;
use Redis;
use GuzzleHttp\Client;
class Test extends BaseController
{
    public function mysql()
    {
        $result = Db::table('mysql.user')
                    ->where('user', 'root')
                    ->field('user, host, plugin, authentication_string')
                    ->select();
        return json($result);
    }
    public function redis()
    {
        // 创建 Redis 对象
        $redis = new Redis();
        $redis->connect('redis', 6379);
        $redis->set('test_key', 'Hello, Redis!');
        $value = $redis->get('test_key');
        $redis->close();
        return $value;
    }
    public function https()
    {
        $client = new Client();
        $response = $client->get('https://www.google.com');
        $result = $response->getBody()->getContents();
        echo $result;
        // return json(['data' => $result]);
    }
    public function clickhouse()
    {
        $client = new Client();
        // 浏览器中：http://localhost:8123/?user=default&password=default_password&query=SELECT+version()+FORMAT+JSON
        $response = $client->get('http://clickhouse:8123/?user=default&password=default_password&query=SELECT version() FORMAT JSONEachRow');
        echo $response->getBody()->getContents();
        $response = $client->get('http://clickhouse:8123/', [
            'query' => [
                'user'=>'default',
                'password'=>'default_password',
                'query' => 'SELECT version() FORMAT JSONEachRow'],
        ]);
        echo $response->getBody()->getContents();
        // 也可以用post
        $response = $client->post('http://clickhouse:8123/', [
            'auth' => ['default', 'default_password'], // 认证信息
            'query' => [
                'query' => 'SELECT version() FORMAT JSON'
            ]
        ]);
        echo $response->getBody()->getContents();

    } 
}
