<?php

## 排行榜信息
$protocol[29010] = array(
    'name' => 'rankList',
    'c2s' => array(
        'type' => 'int8',      # 1=幸运星,2=财富榜,3=战斗力,4=角斗场
    ),
    's2c' => array(
        'type' => 'int8',
        'num'  => 'int32',     # 幸运星总价值
        'lev'  => 'int8',      # 角斗场等级
        'ranks' => array(
            '_obj_name' => 'RankInfo',
            'index'     => 'int32',
            'attr'      => 'int32',
            'id'        => 'int32',
            'name'      => 'string',
            'picture'   => 'int8',
            'custom'    => 'int32', # 自定义字段(角斗场等级)
        )
    ),
);

## 查看英雄
$protocol[29020] = array(
    'name' => 'rankHero',
    'c2s' => array(
        'id'    => 'int32',   # 对手rid
    ),
    's2c' => array(
        'heroes' => array(
            '_obj_name' => 'rankHeroInfo',
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

            'seat1'                 => 'int32', # 装备TID 1 （为0时表示没有装备）
            # 'lev1'                  => 'int8',  # 装备TID 1 的等级（默认0）

            'seat2'                 => 'int32', # 装备TID 2
            # 'lev2'                  => 'int8',  # 装备TID 2 的等级

            'seat3'                 => 'int32', # 装备TID 3
            # 'lev3'                  => 'int8',  # 装备TID 3 的等级

            'seat4'                 => 'int32', # 装备TID 4
            # 'lev4'                  => 'int8',  # 装备TID 4 的等级

            'seat5'                 => 'int32', # 装备唯一ID 5
        )
    ),
);
