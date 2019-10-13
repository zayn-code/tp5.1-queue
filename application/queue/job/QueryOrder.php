<?php

namespace app\queue\job;

use think\queue\Job;

class QueryOrder
{
    const queryUrl = 'http://120.78.217.145/wxorder/porn/public/index/index/query?id=';
    const queryAttempts = 5;    //查询次数
    const queryDelay = 4;   //查询间隔（秒）
    const notifyAttempts = 3;   //回调次数
    const notifyDelay = 3;   //回调间隔（秒）

    public function fire(Job $job, $data)
    {
        $payStatus = _doCurl(self::queryUrl . $data['orderId']);
        if ($payStatus === '支付成功') {
            echo '支付成功，回调次数：' . $job->attempts();
            //开始回调
            $notifyResult = _doCurl($data['notifyUrl'], 'post', $data);
            if ($notifyResult['status'] === 'success') {
                $job->delete();
            } else {
                if ($job->attempts() <= self::notifyAttempts) {
                    $job->release(self::notifyDelay);
                }
            }
        } else if ($payStatus === '暂未支付') {
            echo '暂未支付，查询次数' . $job->attempts();
            if ($job->attempts() >= self::queryAttempts) {
                $job->delete();
            } else {
                $job->release(self::queryDelay);
            }
        } else {
            echo '查询接口错误，次数：' . $job->attempts();
            if ($job->attempts() >= self::queryAttempts) {
                $job->failed();
            } else {
                $job->release(self::queryDelay);
            }
        }
    }
}
