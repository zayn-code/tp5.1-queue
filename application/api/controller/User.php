<?php
/**
 * Created by PhpStorm.
 * User: 86136
 * Date: 2019/10/13
 * Time: 15:56
 */

namespace app\api\controller;

use think\Controller;
use think\Db;
use think\facade\Request;

class User extends Controller
{
    public function payRecord()
    {
        $token = Request::post('token');
        $find = Db::table('user')->where(['token' => $token])->find();
        if (!$find) {
            return _fail('token错误！');
        }
        $list = Db::table('order')->where(['uid' => $find['id']])->order('id desc')->limit(10)->select();
        return _success('', $list);
    }

    public function userInfo()
    {
        $token = Request::post('token');
        $find = Db::table('user')->where(['token' => $token])->find();
        if ($find) {
            return _success('', $find);
        } else {
            return _fail('token错误！');
        }
    }

    public function updateConfig()
    {
        $data = Request::post();
        Db::startTrans();
        $find = Db::table('user')->where(['token' => $data['token']])->find();
        if ($find) {
            $delUserMoneys = true;
            $userMoneys = Db::table('user_moneys')->where(['uid' => $find['id']])->find();
            if ($userMoneys) {
                $delUserMoneys = Db::table('user_moneys')->where(['uid' => $find['id']])->delete();
            }
            $moneys = array_filter(explode(',', $data['moneys']));
            $userMoneyList = [];
            foreach ($moneys as $money) {
                $userMoneyList[] = [
                    'uid'   => $find['id'],
                    'money' => $money
                ];
            }
            $judInsert = Db::table('user_moneys')->insertAll($userMoneyList);
            $judUpdate = Db::table('user')->where(['token' => $data['token']])->update(['moneys' => $data['moneys'], 'ewm' => $data['ewm']]);
            if ($judUpdate && $judInsert && $delUserMoneys) {
                Db::commit();
                return _success('保存成功！');
            } else {
                Db::rollback();
                return _fail('保存失败！');
            }
        } else {
            return _fail('token错误！');
        }
    }

    public function upload()
    {
        // 获取表单上传文件 例如上传了001.jpg
        $file = request()->file('image');
        // 移动到框架应用根目录/uploads/ 目录下
        $info = $file->move('./uploads');
        if ($info) {
            // 成功上传后 获取上传信息
            $url = str_replace("\\", '/', $info->getSaveName());
            $data = Request::post();
            $data['ewm'] = '/uploads/' . $url;
//            Db::table('user')->where(['token'=>$data['token']])->update($data);
            echo $data['ewm'];
        } else {
            // 上传失败获取错误信息
            echo $file->getError();
        }
    }
}