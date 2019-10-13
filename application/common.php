<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件
function _doCurl($url, $type = 'get', $data = [])
{
    //初始化
    $ch = curl_init();
    //设置选项
    curl_setopt($ch, CURLOPT_URL, $url);    //需要获取的 URL 地址 $url
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);    //true 将curl_exec()获取的信息以字符串返回，false直接输出
    curl_setopt($ch, CURLOPT_HEADER, 0);    //参数为1表示输出信息头,为0表示不输出
    if ($type == 'post') {
        //post请求
        curl_setopt($ch, CURLOPT_POST, 1);        //TRUE 时会发送 POST 请求
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data); //全部数据使用HTTP协议中的 "POST" 操作来发送
    }
    //执行并获取内容 抓取URL并把它传递给浏览器
    $output = curl_exec($ch);
    //关闭cURL资源，并且释放系统资源
    curl_close($ch);
    return $output;
}

function _success($msg, $data=[])
{
    return json([
        'msg' => $msg,
        'code' => 200,
        'data' => $data
    ]);
}

function _fail($msg)
{
    return json([
        'msg' => $msg,
        'code' => 201,
    ]);
}
