<?php
/**
 * Created by PhpStorm.
 * User: 86136
 * Date: 2019/10/13
 * Time: 13:38
 */

namespace app\api\controller;

use think\Controller;
use think\Db;
use think\facade\Request;

class Register extends Controller
{
    public function index()
    {
        $data = Request::post();
        if (!isset($data['account']) || !isset($data['password'])) {
            return _fail('参数错误！');
        }
        if (Db::table('user')->where(['account' => $data['account']])->find()) {
            return _fail('账号已存在！');
        }
        $data['password'] = md5($data['password']);
        $id = Db::table('user')->insertGetId($data);
        if ($id) {
            $token = md5($data['account'] . $id);
            Db::table('user')->where(['id' => $id])->update(['token' => $token]);
            return _success('注册成功！', ['token' => $token]);
        } else {
            return _fail('注册失败！');
        }
    }
}