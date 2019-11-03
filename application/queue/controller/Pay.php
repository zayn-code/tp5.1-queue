<?php

namespace app\queue\controller;

use think\Controller;
use think\Db;
use think\facade\Cache;
use think\facade\Request;
use think\Queue;

class Pay extends Controller
{
    public function queryOrder()
    {
        $data = Request::post();
        $judge = Queue::push('app\queue\job\QueryOrder', $data, 'queryOrder');
        echo $judge;
    }

    public function frontNotify()
    {
        $data = Request::post();
        $user = Db::table('user')->where(['token' => $data['token']])->find();
        $notifyLog = [
            'money'    => $data['money'],
            'token'    => $data['token'],
            'datetime' => date('Y-m-d H:i:s'),
            'uid'      => $user ? $user['id'] : ''
        ];
        Db::table('front_notify')->insert($notifyLog);
        if (empty($user)) {
            return _fail('token错误');
        }
        $order_id = Cache::get($user['account'] . '_' . $data['money']);
        Cache::rm($user['account'] . '_' . $data['money']);
        $findOrder = Db::table('order')->where(['order_id' => $order_id])->find();
        if (empty($order_id) || empty($findOrder)) {
            return _fail('订单不存在！');
        }
        Db::table('user_moneys')
            ->where(['uid' => $findOrder['uid'], 'money' => $data['money']])
            ->update(['datetime' => '1970-01-01 00:00:00']);
        Db::table('order')->where(['order_id' => $order_id])->update(['status' => 1]);
        Db::table('user')->where(['token' => $data['token']])->setInc('total_money', $data['money']);
        Queue::push('app\queue\job\NotifyOrder', $findOrder, 'NotifyOrder');
        return _success('进入回调');
    }
}
