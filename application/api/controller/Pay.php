<?php
/**
 * Created by PhpStorm.
 * User: 86136
 * Date: 2019/10/13
 * Time: 19:49
 */

namespace app\api\controller;

use think\Controller;
use think\Db;
use think\facade\Cache;
use think\facade\Request;

class Pay extends Controller
{
    public function order()
    {
        $data = Request::post();
//        $data = [
//            'money' => 1,
//            'attach' => '10012',
//            'notify_url' => 'http://127.0.0.1/cs.php'
//        ];
        //下面是赞赏码支付------------------
        $dateDiff = date('Y-m-d H:i:s',strtotime('-2 minute'));
        $userList = Db::table('user u')
            ->join('user_moneys um','um.uid=u.id')
            ->where(['status'=>1,'money'=>$data['money']])
            ->where('datetime','<',$dateDiff)
            ->select();
        if(empty($userList)){
            return _fail('暂无收款码');
        }
        $result = $userList[array_rand($userList)];
        $order = [
            'order_id' => date('YmdHis') . rand(1000, 9999),
            'attach' => $data['attach'],
            'money' => $result['money'],
            'date' => date('Y-m-d H:i:s'),
            'notify_url' => $data['notify_url'],
            'uid'=>$result['uid']
        ];
        Db::startTrans();
        $judInsert = Db::table('order')->insert($order);
        $judUpdate = Db::table('user_moneys')->where(['id'=>$result['id']])->update(['datetime'=>date('Y-m-d H:i:s')]);
        if ($judInsert && $judUpdate) {
            Db::commit();
            Cache::set($result['account'] . '_' . $result['money'], $order['order_id'], 60);
            return _success('下单成功！', ['money' => $result['money'], 'url' => $result['ewm']]);
        } else {
            Db::rollback();
            return _fail('下单失败！');
        }



        //以下是个人转账代码-----------------------
        $userList = Db::table('user')->where(['status' => 1])->select();
        if (empty($userList)) {
            return _fail('暂无收款码');
        }
        $user = $userList[array_rand($userList)];
        $money = number_format($data['money'], 2);
        $payMoney = 0;
        for ($a = $money; $a <= bcadd($a, '10', 2); $a = bcadd($a, '1', 2)) {
            $a = bcadd($a, '0', 2);
            if (!Cache::get($user['account'] . '_' . $a)) {
                $payMoney = $a;
                break;
            }
        }
        if ($payMoney === 0) {
            return _fail('当前额度支付人太多，请稍后再试，或换其他额度支付');
        }
        $order = [
            'order_id' => date('YmdHis') . rand(1000, 9999),
            'attach' => $data['attach'],
            'money' => $payMoney,
            'date' => date('Y-m-d H:i:s'),
            'notify_url' => $data['notify_url'],
            'uid'=>$user['id']
        ];
        if (Db::table('order')->insert($order)) {
            Cache::set($user['account'] . '_' . $payMoney, $order['order_id'], 60);
            return _success('下单成功！', ['money' => $payMoney, 'url' => $user['ewm']]);
        } else {
            return _fail('下单失败！');
        }
    }
}