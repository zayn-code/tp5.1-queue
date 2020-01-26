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
        Db::table('user')->where(['id' => $id])->update(['is_delete' => 1]);
    }

    public function getUserList()
    {
        $param = Request::param();
        $condition = [];
        if (!empty($param['status']) || $param['status'] === '0') {
            $condition[] = ['status', '=', $param['status']];
        }
        if (!empty($param['nickname'])) {
            $condition[] = ['nickname', 'like', '%' . $param['nickname'] . '%'];
        }
        $list = Db::table('user')
            ->where(['is_delete' => 0])
            ->where($condition)
            ->paginate($param['limit'])
            ->toArray();
        foreach ($list['data'] as &$item) {
            $item['ewm'] = 'http://' . $_SERVER['HTTP_HOST'] . $item['ewm'];
        }
        return json($list);
    }
}