<?php

# 游戏更新检测，只有下行
$protocol[10000] = array(
    'name' => 'update',
    's2c' => array(
        'versions' => 'string', # 版本号 比如：1.0.1
        'url' => 'string', # 版本地址
    ),
);



# 消息代码
$protocol[10001] = array(
    'name' => 'msgCode',
    's2c' => array(
        # 类型：
        # 1＝提示（自动消失）
        # 2＝错误（主动点击后消失）
        'type' => 'int8',
        # 代号：
        # 1001＝服务器关闭
        # 1002＝已在别处登陆
        # 1003＝服务器爆满，请稍后再尝试登陆
        # 1004＝服务器繁忙，请稍后再尝试登陆
        # 1008＝背包空间不足
        # 1009＝调用角色进程超时
        # 1010＝客户端资源更新
        'code' => 'int32',
    ),
);

# 新公告通知
$protocol[10004] = array(
    'name' => 'newNotice',
    's2c' => array(
    ),
);

# 公告消息
$protocol[10005] = array(
    'name' => 'notice',
    'c2s' => array(
    ),
    's2c' => array(
        'notice' => array(
            '_obj_name' => 'noticeVO',
            'id' => 'int32',
            'msg' => 'string',
        ),
    ),
);

# 反馈
$protocol[10010] = array(
    'name' => 'feedback',
    'c2s' => array(
        'type' => 'int8', # 1=意见，2=BUG
        'content' => 'string', # 内容
    ),
    's2c' => array(
        # 0=成功，1=失败
        'code' => 'int8',
    ),
);

# 购买钻石
#
# 服务器ID(sid) ：1
# 随机数(rand)  ：unixtime
# 当前加密KEY   ：23d7f859778d2093
# 签名算法      ：md5(sid + key + account + rand)
#
$protocol[10011] = array(
    'name' => 'diamondshop',
    'c2s' => array(
        # windows | ios | android |
        # ios_91 | ios_tb | android_91
        # android_wdj | android_uc | android_xm |
        'platform' => 'string',
        # App Store提供的付款收据
        'receipt' => 'string',
        'rand' => 'int32', # unixtime
        'signature' => 'string', # 签名
    ),
    's2c' => array(
        # 0=成功, 1=失败, 2=超时
        'code' => 'int8',
    ),
);
