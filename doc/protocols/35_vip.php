<?php

## vip数据变化通知
$protocol[35001] = array(
    'name' => 'vipSend',
    's2c' => array(
        'code' => 'int8',   # 1=vip更新,2=
    ),
);

## vip特权基础数据
$protocol[35010] = array(
    'name' => 'vipInfo',
    'c2s' => array(
    ),
    's2c' => array(
        'lev'         => 'int8',    # vip等级
        'diamond'     => 'int32',   # 充值钻石
        'free'        => 'int32',   # 自由值
        'chattime'    => 'int8',    # 喇叭时间间隔
        'prize'       => 'int8',    # 特权礼包
        'fast'        => 'int8',    # 加速
        'tired'       => 'int8',    # 疲劳购买
        'coli_buy'    => 'int8',    # 角斗场购买
        'fb_buy'      => 'int8',    # 副本购买
    ),
);

## vip礼包奖励领取
$protocol[35020] = array(
    'name' => 'vipPrize',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 已经领取
        # 3 = 背包已满
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);
