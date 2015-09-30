<?php

## 活动开启(活动列表)
$protocol[25001] = array(
    'name' => 'startFest',
    'c2s' => array(
    ),
    's2c' => array(
        'ids' => array(
            '_obj_name' => 'FestIds',
            'id' => 'int8', # fest ID
        ),
    ),
);

## 钻石大放送活动开启
$protocol[25002] = array(
    'name' => 'diamondFest',
    'c2s' => array(
    ),
    's2c' => array(
        'code' => 'int32', #验证码
        'loadUrl' => 'string', #下载地址
        'ratingUrl' => 'string', #评星地址
        'ids' => array(
            '_obj_name' => 'FestValues',
            'id' => 'int8',   # fest ID
            'val'=> 'int32',  # 完成数量/分享时间
            'num'=> 'int8',   # 当前阶段(default=1)
            # (0=不可领取,1=可以领取,2=已经领取)
            'state' => 'int8',
        ),
    ),
);

## 节日兑换
$protocol[25004] = array(
    'name' => 'buyFest',
    'c2s' => array(
        'id' => 'int32', # 兑换id
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 材料不足
        # 3 = 背包已满
        # >=127 = 程序异常
        'code' => 'int8',
        'items' => array(
            '_obj_name' => 'FestItem',
            'tid' => 'int32',
            'num' => 'int8',
        ),
    ),
);


## 非节日活动

## 微信分享
$protocol[25030] = array(
    'name' => 'weixinShare',
    'c2s' => array(
        # 62 = wechat
        # 68 = facebook
        # ..
        'id' => 'int8',
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 分享成功(可以领奖)
        # 1 = 不可以领奖
        'code' => 'int8',
        'id' => 'int8',
        'num'  => 'int32', # cd time
        ),
);

## 微信分享领奖
$protocol[25031] = array(
    'name' => 'weixinSharePrize',
    'c2s' => array(
        # 62 = wechat
        # 68 = facebook
        # ..
        'id' => 'int8',
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 不可领取
        # >=127 = 程序异常
        'code' => 'int8',
        'id' => 'int8',
        'num'  => 'int32', # cd time
        ),
);

## 首充活动领取状态
$protocol[25032] = array(
    'name' => 'firstPayStart',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 可以领取
        # 1 = 不能领取
        # 2 = 已经领取过
        # >=127 = 程序异常
        'code' => 'int8',
        ),
);

## 首充活动领奖
$protocol[25033] = array(
    'name' => 'firstPayPrize',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 未完成
        # 2 = 不能领取
        # >=127 = 程序异常
        'code' => 'int8',
        ),
);

## 邀请用户数领奖
$protocol[25034] = array(
    'name' => 'inviteGetPrize',
    'c2s' => array(
        # 'type' => 'int8',  # 不同阶段(1,2,3)
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 未完成
        # 2 = 已经领取过
        # 3 = 背包已满
        # >=127 = 程序异常
        'code' => 'int8',
        'num'  => 'int8',    # 下个领奖阶段
        # (0=不可领取,1=可以领取,2=已经领取)
        'state' => 'int8',   # 是否可以领奖
    ),
);

## 评星
$protocol[25035] = array(
    'name' => 'grade',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 可以领取
        # 1 = 不可领取
        # >=127 = 程序异常
        'code' => 'int8',
        ),
);

## 评星领奖
$protocol[25036] = array(
    'name' => 'gradeGetPrize',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 不可领取
        # >=127 = 程序异常
        'code' => 'int8',
        ),
);

## 好友登录数领奖
$protocol[25038] = array(
    'name' => 'loginGetPrize',
    'c2s' => array(
        # 'type' => 'int8',  # 不同阶段(1,2,3)
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 未完成
        # 2 = 已经领取过
        # 3 = 背包已满
        # >=127 = 程序异常
        'code' => 'int8',
        'num'  => 'int8',    # 下个领奖阶段
        # (0=不可领取,1=可以领取,2=已经领取)
        'state' => 'int8',   # 是否可以领奖
        ),
);

## 绑定激活码登录
$protocol[25040] = array(
    'name' => 'inviteVerify',
    'c2s' => array(
        'account' => 'int32',
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 已经绑定过
        # 2 = 激活码错误
        # >=127 = 程序异常
        'code' => 'int8',
        ),
);

## 绑定激活码领奖
$protocol[25041] = array(
    'name' => 'verifyGetPrize',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 不可领取
        # >=127 = 程序异常
        'code' => 'int8',
        ),
);

## 运营活动激活码领奖
$protocol[25044] = array(
    'name' => 'activateKey',
    'c2s' => array(
        'key' => 'string',
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 激活码过期
        # 2 = 激活码已使用
        # 3 = 无效激活码
        # 4 = 已经兑换过
        # >=127 = 程序异常
        'code' => 'int8',
        ),
);

## pay double
$protocol[25046] = array(
    'name' => 'PayDouble',
    'c2s' => array(
    ),
    's2c' => array(
        'doubleids' => array('int32'),
    ),
);
