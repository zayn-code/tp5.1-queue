<?php
/**
 * Created by PhpStorm.
 * User: 97285
 * Date: 2019/4/28
 * Time: 11:16
 */

namespace app;

/**
 * Class Redis
 * @package app\common
 * @method static exists($key)
 * @method static get($key)
 * @method static set($key, $value, $timeout)
 * @method static incr($key)
 * @method static incrby($key,$num)
 * @method static decr($key)
 * @method static decrby($key,$num)
 * @method static hGet($table, $field)
 * @method static hSet($table, $field, $value)
 * @method static hKeys($table)
 * @method static hDel($table, $field)
 * @method static hExists($table, $field)
 * @method static hIncrby($table, $field, $value)
 * @method static del($key)
 * @method static hLen($key)
 * @method static hGetAll($key)
 * @method static lPop($key)
 * @method static rPush($key, $value)
 * @method static lLen($key)
 * @method static lIndex($key, $index)
 * @method static lRange($key, $start, $end)
 * @method static expire($key, $seconds)
 */
class Redis
{
    private static $redis;

    /**
     * 初始化redis
     */
    public static function init()
    {
        if (!self::$redis) {
            try {
                self::$redis = new \Redis();
                $redisConnect = config('queue.');
                self::$redis->connect($redisConnect['host'], $redisConnect['port']);
                self::$redis->auth($redisConnect['password']);
            } catch (\Exception $e) {
                print $e->getMessage();
                exit;
            }
        }
    }

    /**
     * 魔术方法静态调用
     * @param $method_name
     * @param $param
     * @return mixed
     */
    public static function __callStatic($method_name, $param)
    {
        if (!self::$redis) {
            self::init();
        }
        try {
            return call_user_func_array([self::$redis, $method_name], $param);
        } catch (\Exception $e) {
            print $e->getMessage();
            exit;
        }
    }
}
