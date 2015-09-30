<?php

## 获取战报排行榜
$protocol[34010] = array(
    'name' => 'videoRank',
    'c2s' => array(
        'tollgateid' => 'int32',  # 关卡id
    ),
    's2c' => array(
        'videoRankInfo' => array(
            '_obj_name' => 'videoRankList',
            'name'  => 'string',
            'power' => 'int32',
            'picture' => 'int8',
        ),
    ),
);

## 获取战报数据录像
$protocol[34020] = array(
    'name' => 'videoInfo',
    'c2s' => array(
        'tollgateid' => 'int32',  # 关卡id
        'id' => 'int32',          # 排行榜排名
    ),
    's2c' => array(
        # === 英雄数据 ===
        'heroes' => array(
            '_obj_name' => 'videoHeroes',
            'id'                    => 'int32', # 英雄唯一id
            'type'                  => 'int32', # 道具类型ID(道具表里有定义)
            'seat'                  => 'int8',  # 布阵位置(0未装备|1|2|3|4 )
            'quality'               => 'int8',  # 品级
            'level'                 => 'int8',  # 等级
            'exp'                   => 'int32', # 经验

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
            'seat2'                 => 'int32', # 装备TID 2
            'seat3'                 => 'int32', # 装备TID 3
            'seat4'                 => 'int32', # 装备TID 4
        ),
        'videoData' => array(
            '_obj_name' => 'videoDataInfo',
            # === 战斗胜利 ===
            'iswin' => 'int8',
            # === 上阵英雄的初始血量 ===
            'videoHeroes' => array(
                '_obj_name' => 'videoHeroesVo',
                'pos'   => 'int8',   # 英雄位置
                'hp'    => 'int32',  # 英雄血量
                'power' => 'int32',  # 英雄战斗力
            ),
            # ==========================
            'videoCommands' => array(
                '_obj_name' => 'videoVo',
                'bout'  => 'int8',   # 大回合数
                'sponsor' => 'int8', # 发起者位置
                # 发起者BUFF
                'buffid' => array('int32'),
                # 目标列表
                'targets' => array(
                    '_obj_name' => 'videoBattleTarget',
                    'id' => 'int8',  # 被实施者位置(目标)
                    'hp' => 'int32', # 被实施者剩余HP
                    # 被实施者状态:
                    #  &1   - 暴击
                    #  &2   - 闪避
                    #  &4   - 复活
                    #  &8   - 治疗
                    #  &16  -
                    #  &32  -
                    #  &64  -
                    #  &128 -
                    'state'  => 'int8',
                    # BUFF
                    'buffid' => array('int32'),
                ),
                'skill' => 'int32',  # 技能ID(默认0)
            ),
            'videoUpgrade' => array(
                '_obj_name' => 'videoUpgradeVo',
                'id'    => 'int32',  # 英雄ID
                'level' => 'int8',   # 等级
                'exp'   => 'int32',  # 经验
            ),
        ),
    ),
);
