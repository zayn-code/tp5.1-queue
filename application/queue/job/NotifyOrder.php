<?php

namespace app\queue\job;

use think\queue\Job;

class NotifyOrder
{
    const notifyAttempts = 3;   //回调次数
    const notifyDelay = 3;   //回调间隔（秒）

    public function fire(Job $job, $data)
    {
        $result = json_decode(_doCurl($data['notify_url'], 'post', $data), true);
        if ($result['code'] === 200) {
            echo '回调成功';
            $job->delete();
        } else {
            echo $result['msg'];
            if ($job->attempts() >= self::notifyAttempts) {
                $job->failed();
            } else {
                $job->release(self::notifyDelay);
            }
        }
    }
}
