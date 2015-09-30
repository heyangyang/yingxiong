<?php

## 成就完成推送
$protocol[24001] = array(
    'name' => 'attain_send',
    'c2s' => array(
    ),
    's2c' => array(
        'id'   => 'int32',	# 成就ID
    ),
);

## 每日任务推送
$protocol[24002] = array(
    'name' => 'attaintoday_send',
    'c2s' => array(
    ),
    's2c' => array(
        'id'   => 'int32',  # 成就ID
        'num'  => 'int32',  # 完成数量
    ),
);

## 每日任务增减推送
$protocol[24003] = array(
    'name' => 'attaintoday',
    'c2s' => array(
    ),
    's2c' => array(
        'id'   => 'int32',  # 成就ID
        'num'  => 'int8',   # 1=增加,2=删除
    ),
);

## 领取成就
$protocol[24004] = array(
    'name' => 'attain_get',
    'c2s' => array(
        'id' => 'int32', # 成就id
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 3 = 背包已满
        # >=127 = 程序异常
        'code' => 'int8',
        'id' => 'int16',	# 成就id  =0:已经全部完成
        'type' => 'int8',	# 0=未完成,1=可以领取
    ),
);

## 成就初始化
$protocol[24006] = array(
    'name' => 'attain_init',
    'c2s' => array(
    ),
    's2c' => array(
        'ids'  => array(
            '_obj_name' => 'AttainInfo',
            'id' => 'int32',
            'num' => 'int32',   # 完成数量
            'type' => 'int8',	# 0=未完成,1=可以领取
        ),
    ),
);

## 任务引导开启推送
$protocol[24008] = array(
    'name' => 'attain_condition',
    'c2s' => array(
    ),
    's2c' => array(
        'id'   => 'int32',  # 任务ID
    ),
);
