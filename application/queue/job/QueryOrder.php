<?php

namespace app\queue\job;

use think\queue\Job;

class QueryOrder
{
    const queryUrl = 'http://www.iyuanma.top/wxorder/porn/public/index/index/query?id=';
    const queryAttempts = 120;    //查询次数
    const queryDelay = 5;   //查询间隔（秒）
    const notifyAttempts = 3;   //回调次数
    const notifyDelay = 3;   //回调间隔（秒）

    public function fire(Job $job, $data)
    {
        $payStatus = _doCurl(self::queryUrl . $data['order_id']);
        if ($payStatus === '支付成功') {
            echo '支付成功，回调次数：' . $job->attempts();
            //开始回调
            $notifyResult = _doCurl($data['notifyUrl'], 'post', $data);
            $notifyResult = json_decode($notifyResult, true);
            if ($notifyResult['code'] == '200') {
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
