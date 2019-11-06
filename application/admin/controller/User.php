<?php

namespace app\admin\controller;

use think\Controller;
use think\Db;
use think\facade\Request;

class User extends Controller
{
    public function userList()
    {
        return $this->fetch('userList');
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

    public function delUser()
    {
        $id = Request::param('id');
        Db::table('user')->where(['id'=>$id])->update(['is_delete'=>1]);
    }

    public function getUserList()
    {
        $limit = Request::param('limit');
        $list = Db::table('user')->where(['is_delete' => 0])->paginate($limit)->toArray();
        foreach ($list['data'] as &$item) {
            $item['ewm'] = 'http://' . $_SERVER['HTTP_HOST'] . $item['ewm'];
        }
        return json($list);
    }
}