<?php

namespace app\admin\controller;

use think\Controller;
use think\Db;
use think\facade\Request;

class User extends Controller
{
    public function userList()
    {
        return $this->fetch('userList', ['list' => $this->getUserList()]);
    }

    public function changeStatus()
    {
        $post = Request::post();
        $find = Db::table('user')->where(['id' => $post['id']])->find();
        if ($find) {
            $update = $post['status'] ? 0 : 1;
            $res = Db::table('user')->where(['id' => $post['id']])->update(['status' => $update]);
            if ($res) {
                return _success('操作成功！');
            } else {
                return _fail('修改失败！');
            }
        } else {
            return _fail('用户不存在！');
        }
    }

    public function getUserList()
    {
        $list = Db::table('user')->select();
        foreach ($list as &$item) {
            $item['ewm'] = 'http://' . $_SERVER['HTTP_HOST'] . $item['ewm'];
        }
        return json_encode($list, 64);
    }
}