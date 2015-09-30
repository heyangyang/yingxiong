<?php

## 任务完成推送
$protocol[36001] = array(
    'name' => 'SendTask',
    'c2s' => array(
    ),
    's2c' => array(
        'id'   => 'int32',  # 任务ID
    ),
);

## 任务开启推送
$protocol[36002] = array(
    'name' => 'OpenTask',
    'c2s' => array(
    ),
    's2c' => array(
        'id'   => 'int32',  # 任务ID
    ),
);

## 任务更新推送
$protocol[36003] = array(
    'name' => 'UpdateTask',
    'c2s' => array(
    ),
    's2c' => array(
        'id'   => 'int32',  # 任务ID
        'num' => array(
            '_obj_name' => 'TaskVal',
            'type' => 'int32',
            'number' => 'int32',
        ),
    ),
);

## 领取任务
$protocol[36004] = array(
    'name' => 'GetTask',
    'c2s' => array(
        'id' => 'int32', # 任务id
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 失败(未完成,已完成)
        # 2 = 已经领取
        # 3 = 背包已满(领取成功)
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 任务列表
$protocol[36005] = array(
    'name' => 'InitTask',
    'c2s' => array(
    ),
    's2c' => array(
        'ids'  => array(
            '_obj_name' => 'TaskInfo',
            'id' => 'int32',
            # 'num' => 'int32',   # 完成数量
            'num' => array(
                '_obj_name' => 'TaskPlan',
                'type' => 'int32',
                'number' => 'int32',
            ),
            'state' => 'int8',   # 0=未完成,1=可以领取
        ),
    ),
);

## share / praise
$protocol[36006] = array(
    'name' => 'PlatformShare',
    'c2s' => array(
        # 1 = facebook
        # 2 = wechat
        # ..
        'id' => 'int8',
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 分享成功
        # ..
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);
