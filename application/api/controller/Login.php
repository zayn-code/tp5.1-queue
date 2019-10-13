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

class Login extends Controller
{
    public function index()
    {
        $data = Request::post();
        if (!isset($data['account']) || !isset($data['password'])) {
            return _fail('参数错误！');
        }
        $data['password'] = md5($data['password']);
        $user = Db::table('user')->where($data)->find();
        if ($user) {
            return _success('登陆成功！', ['token' => $user['token']]);
        }else{
            return _fail('账号或密码错误！');
        }
    }
}