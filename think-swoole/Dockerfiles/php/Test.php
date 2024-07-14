<?php
namespace app\controller;
use app\BaseController;
use think\facade\Db;
use Redis;
use GuzzleHttp\Client;
use RdKafka\Conf;
use RdKafka\Producer;
use RdKafka\TopicConf;
use RdKafka\KafkaConsumer;
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
    // 生产消息
    public function produce($message = "Hello Kafka!")
    {
        $conf = new Conf();
        $conf->set('metadata.broker.list', 'kafka:9092');

        $producer = new Producer($conf);
        $topic = $producer->newTopic("my-topic");
        $topic->produce(RD_KAFKA_PARTITION_UA, 0, $message);
        // 等待消息传输完成
        $producer->flush(10000);
        return json(['status' => 'success', 'message' => $message, 'result' => 'Message produced to Kafka']);
    }
    // 消费消息 (仅举例，控制器中不适合长时间运行，后台处理的内容）
    public function consume()
    {
        $conf = new Conf();
        $conf->set('metadata.broker.list', 'kafka:9092');
        $conf->set('group.id', uniqid()); // 使用固定的消费者组 ID
        $conf->set('auto.offset.reset', 'earliest'); // 从最早的消息开始消费 earliest latest

        $consumer = new KafkaConsumer($conf);
        $consumer->subscribe(['my-topic']);
        while (true) {
            // $startTime = microtime(true); // 开始时间
            $message = $consumer->consume(5000); // 设置4秒的超时时间
            // $endTime = microtime(true); // 结束时间
            // $duration = $endTime - $startTime; // 计算运行时间
            // echo "Consume duration: " . $duration . " seconds<br>"; // 输出运行时间
            if ($message === null) {
                echo "No message received<br>";
            } else {
                switch ($message->err) {
                    case RD_KAFKA_RESP_ERR_NO_ERROR:
                        echo $message->payload . "<br>";
                        break;
                    case RD_KAFKA_RESP_ERR__PARTITION_EOF:
                        echo "No more messages; will wait for more<br>";
                        break;
                    case RD_KAFKA_RESP_ERR__TIMED_OUT:
                        echo "Timed out<br>";
                        return;
                    default:
                        echo "Error: " . $message->errstr() . "<br>";
                        break;
                }
            }
        }
    }
}
