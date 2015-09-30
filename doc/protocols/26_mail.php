<?php

## 新邮件通知
$protocol[26001] = array(
    'name' => 'mailNotice',
    's2c' => array(
    ),
);

## 新邮件列表
$protocol[26005] = array(
    'name' => 'mailList',
    'c2s' => array(
        'maxId' => 'int32', # 邮件缓存中的最大邮件ID
    ),
    's2c' => array(
        'mail' => array(
            '_obj_name' => 'newMail',
            'id' => 'int32', # 邮件ID
            'from' => 'string', # 发件人 (@表示系统管理员)
            'content' => 'string', # 邮件内容
            'time' => 'int32', # 过期剩余时间(秒)
            'items' => array(
                '_obj_name' => 'mailItems',
                # 附件类型：
                # 1=金币,
                # 2=钻石,
                # 3=幸运星,
                # 5=英雄,
                # 7=疲劳值,
                # 大于100 = 物品ID
                'type' => 'int32',
                'num' => 'int32', # 附件数量
                'custom' => 'int32',# 自定义字段(英雄品质)
            ),
        ),
    ),
);

## 收取附件
$protocol[26010] = array(
    'name' => 'getMailItems',
    'c2s' => array(
        'id' => 'int32', # 邮件ID
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 失败
        # 3 = 背包空间不足
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 删除邮件
$protocol[26015] = array(
    'name' => 'deleteMail',
    'c2s' => array(
        'id' => 'int32', # 邮件ID
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 失败
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);
