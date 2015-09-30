<?php

## 发送聊天消息
$protocol[27010] = array(
    'name' => 'chatSend',
    'c2s' => array(
        'type' => 'int8',      # 1=世界,2=喇叭,4=工会
        'content' => 'string', # 聊天内容
    ),
    's2c' => array(
        # 0=成功,
        # 1=喇叭不足,
        # 2=时间间隔太短(世界聊天)
        # 3=内容不能为空
        # 4=没有注册名字不能发
        'code' => 'int8',
    ),
);

## 聊天广播
$protocol[27020] = array(
    'name' => 'chat',
    's2c' => array(
        'type' => 'int8',      # 1=世界, 2=喇叭, 3=系统/(玩家触发:强化..), 4=工会
        'id' => 'int32',       # 角色ID (当ID为0时为系统消息)
        'name' => 'string',    # 角色名字
        'content' => 'string', # 聊天内容
        # 属性
        #  &1   - VIP (0=否，1=是)
        #  &2   -
        #  &4   -
        #  &8   -
        #  &16  -
        #  &32  -
        #  &64  -
        #  &128 -
        'attr' => 'int8',
    ),
);
