<?php

## 布阵
$protocol[14001]['name'] = 'embattle';
$protocol[14001]['c2s'] = array(
    'heroes' => array(
        '_obj_name' => 'HeroPosition',
        'id'=> 'int32',     # 英雄唯一id
        'position'=>'int8', # 英雄位置(1|2|3|4)
    ),
);
$protocol[14001]['s2c'] = array(
    'status' => 'int8',     # 状态(0=成功;1英雄个数错误,>1失败)
);

## 玩家所有英雄
## 数据结构和14025一致
$protocol[14002] = array(
    'name' => 'get_all_hero',
    'c2s' => array(
    ),
    's2c' => array(
        'heroes' => array(
            '_obj_name' => 'HeroVO',
            'id' => 'int32',        # 英雄唯一id
            'type' => 'int32',      # 道具类型ID(道具表里有定义)
            'seat' => 'int8',       # 布阵位置(0未装备|1|2|3|4 )
            'quality' => 'int8',    # 品级
            'level' => 'int8',      # 等级
            'exp' => 'int32',       # 经验
            'foster' => 'int8',     # 培养次数

            'hp'                    => 'int32', # 血
            'attack'                => 'int32', # 攻
            'defend'                => 'int32', # 防
            'puncture'              => 'int32', # 穿刺
            'hit'                   => 'int32', # 命中
            'dodge'                 => 'int32', # 闪避
            'crit'                  => 'int32', # 暴击率
            'critPercentage'        => 'int32', # 暴击提成
            'anitCrit'              => 'int32', # 免暴
            'toughness'             => 'int32', # 韧性

            'seat1'                 => 'int32', # 装备唯一ID 1 （为0时表示没有装备）
            'seat2'                 => 'int32', # 装备唯一ID 2
            'seat3'                 => 'int32', # 装备唯一ID 3
            'seat4'                 => 'int32', # 装备唯一ID 4
            'seat5'                 => 'int32', # 装备唯一ID 5
        )
    ),
);

## 学习技能
## $protocol[14005] = array(
##     'name' => 'study_skill',
##     'c2s' => array(
##         'widgetid' => 'int32',   # 技能书ID
##         'heroid' => 'int32',     # 英雄唯一ID
##         // TODO: oldSkillid 修改为技能位置
##         // 'oldSkillid' => 'int32', # 被替换的技能ID(0=表示新装技能);
##         'seat' => 'int8',  # 技能位置
##     ),
##     's2c' => array(
##         # 消息代码:
##         # 0 = 成功
##         # >=127 = 程序异常
##         'state' => 'int8',
##     ),
## );

## 净化
$protocol[14010] = array(
    'name' => 'purge',
    'c2s' => array(
        'heroid' => 'int32', #英雄ID
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 金币不足
        # 2 = 钻石不足
        # 3 = 材料不足
        # 4 = 已达到上限
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 删除英雄（英雄吞噬）
$protocol[14015] = array(
    'name' => 'deletehero',
    's2c' => array(
         'heroes' => array(
         		'id' => 'int32',		# 英雄唯一ID
         	),
    ),
);

## 英雄锁
$protocol[14019] = array(
    'name' => 'herolock',
    'c2s' => array(
        'id' => 'int32',           # 英雄酒馆表的英雄id
        'lock' => 'int8',          # 0=申请解锁1=申请锁住英雄
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 酒馆中刷新英雄，每次刷新3个英雄，
$protocol[14020] = array(
    'name' => 'searchhero',
    'c2s' => array(
        'type' => 'int8',                   # 0=请求上次刷新列表；1=刷新酒馆
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 金币不足
        # 2 = 钻石不足
        # >=127 = 程序异常
        'code' => 'int8',
        'cd'  => 'int32',           #刷新CD
        'heroes' => array(
            '_obj_name' => 'TavernHeroVo',
            'id' => 'int8', # 唯一ID
            #道具类型ID(道具表里有定义)
            'type' => 'int32',
            'lock' => 'int8',               # 英雄锁0=未锁，1=锁住
            # 品极
            # 1 = d
            # 2 = c
            # 3 = b
            # 4 = a
            # 5 = s
            # 6 = ss
            # 7 = sss
            'quality' => 'int8',    #品级
            'ravity' => 'int8',     #稀有度
        ),
    ),
);

## 酒馆中购买英雄，购买成功，14025接口被自动调用
$protocol[14022] = array(
    'name' => 'buyhero',
    'c2s' => array(
        'id' => 'int32'               # 英雄酒馆表的英雄id
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 金币不足
        # 2 = 钻石不足
        # 3 = 英雄格子数不足
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 赠送英雄
$protocol[14023] = array(
    'name' => 'givehero',
    'c2s' => array(
        'id' => 'int32'               # 英雄id
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 已经赠送
        # 3 = 英雄格子数不足
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 增加/更新英雄
## 如果唯一ID已存在，则为更新英雄
## 数据结构和14002一致
$protocol[14025] = array(
    'name' => 'newhero',
    's2c' => array(
        'id' => 'int32',        # 英雄唯一id
        'type' => 'int32',      # 道具类型ID(道具表里有定义)
        'seat' => 'int8',       # 布阵位置(0未装备|1|2|3|4 )
        'quality' => 'int8',    # 品级
        'level' => 'int8',      # 等级
        'exp' => 'int32',       # 经验
        'foster' => 'int8',     # 培养次数

        'hp'                    => 'int32', # 血
        'attack'                => 'int32', # 攻
        'defend'                => 'int32', # 防
        'puncture'              => 'int32', # 穿刺
        'hit'                   => 'int32', # 命中
        'dodge'                 => 'int32', # 闪避
        'crit'                  => 'int32', # 暴击率
        'critPercentage'        => 'int32', # 暴击提成
        'anitCrit'              => 'int32', # 免暴
        'toughness'             => 'int32', # 韧性

        'seat1'                 => 'int32', # 装备唯一ID 1 （为0时表示没有装备）
        'seat2'                 => 'int32', # 装备唯一ID 2
        'seat3'                 => 'int32', # 装备唯一ID 3
        'seat4'                 => 'int32', # 装备唯一ID 4
        'seat5'                 => 'int32', # 装备唯一ID 5
    ),
);



## 英雄吞噬
$protocol[14030] = array(
    'name' => 'Absorb',
    'c2s' => array(
        'heroid' => 'int32', # 英雄唯一ID
        'id1' => 'int32',	# (0=没有英雄，0>英雄唯一ID )
        'id2' => 'int32',# (0=没有英雄，0>英雄唯一ID )
        'id3' => 'int32',# (0=没有英雄，0>英雄唯一ID )
        'id4' => 'int32',# (0=没有英雄，0>英雄唯一ID )
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 金币不足
        # >=127 = 程序异常
        'code' => 'int8',
        'heroid' => 'int32', # 英雄唯一ID
        'level' => 'int8', # 英雄等级
        'exp' => 'int32', # 英雄经验
    ),
);

## 英雄携带数
$protocol[14032] = array(
    'name' => 'HeroTab',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码:
        # Code:
        # 0 = 成功
        # 1 = 钻石不足
        # 2 = 达到上限
        # >=127 = 程序异常
        'code' => 'int8',
        'num'  => 'int8',    # 当前可携带英雄数
    ),
);

## 英雄解雇
$protocol[14034] = array(
    'name' => 'HeroDismissal',
    'c2s' => array(
        'id' => 'int32',     # 英雄唯一id
    ),
    's2c' => array(
        # 消息代码:
        # Code:
        # 0 = 成功
        # 3 = 背包已满(解雇失败)
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 英雄经验药水
$protocol[14036] = array(
    'name' => 'HeroPotion',
    'c2s' => array(
        'id' => 'int32',          # 英雄唯一id
        'mats' => 'int32',        # 药水材料物品id
    ),
    's2c' => array(
        # 消息代码:
        # Code:
        # 0 = 成功
        # 1 = 材料不足
        # 2 = 英雄等级上级
        # >=127 = 程序异常
        'code' => 'int8',
        'level' => 'int8',  # 等级
        'exp' => 'int32',   # 经验
    ),
);

## 英雄培养
$protocol[14037] = array(
    'name' => 'HeroStar',
    'c2s' => array(
        'heroid' => 'int32', #英雄ID
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 金币不足
        # 2 = 钻石不足
        # 3 = 材料不足
        # 4 = 已达到上限
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 关卡英雄是否购买
$protocol[14038] = array(
    'name' => 'IsHeroBuy',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # state:
        # 1 = 配置错误
        # 2 = 其他异常
        # >=127 = 程序异常
        'code' => 'int8',
        'heroes' => array(
            '_obj_name' => 'GateHero',
            # state:
            # 0 = 可以购买
            # 1 = 未解锁
            # 2 = 已经购买
            # 3 = 配置错误
            # 4 = 其他异常
            # >=127 = 程序异常
            'id' => 'int32',
            'state' => 'int8',
        ),
    ),
);

## 关卡英雄购买
$protocol[14039] = array(
    'name' => 'HeroBuy',
    'c2s' => array(
        'id' => 'int32', #英雄序号ID
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 购买成功
        # 1 = 金币不足
        # 2 = 关卡未达到
        # 3 = 已经购买过
        # 4 = 配置表错误
        # 5 = 背包格子不足
        # 6 = 钻石不足
        # >=127 = 程序异常
        'state' => 'int8',
    ),
);
