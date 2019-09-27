<?php

namespace app\queue\controller;

use think\Controller;
use think\Queue;
use think\Request;

class Pay extends Controller
{
    public function queryOrder(Request $request)
    {
        $data = [
            'orderID' => '1569552131150',
            'uid' => '',
            'notifyUrl' => '',
            'money'=>''
        ];
        $judge = Queue::push('app\queue\job\QueryOrder', $data, 'queryOrder');
        echo $judge;
    }
}
