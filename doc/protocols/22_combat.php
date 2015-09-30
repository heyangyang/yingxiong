<?php

## 战斗
$protocol[22002] = array(
    'name' => 'battle',
    'c2s' => array(
        #  1 = 主线 2= 副本 3 = 竞技场 4 = 节日活动 5 = 噩梦副本
        'type' => 'int8',
        # type == 1 时关卡id,type == 2时竞技场对手ID
        'currentCheckPoint' => 'int16',
        'pos' => 'int8', #怪的位置
    ),
    's2c' => array(
        'tried' => 'int32',             # 当前玩家的疲劳值
        'currentCheckPoint' => 'int16', # 当前关
        'success' => 'int8',            # 是否胜利(0 = 失败 1 = 胜利)
        'star' => 'int8',               # &1=胜利,&2=没有阵亡,&4=20回合
        # === 上阵英雄的初始血量 ===
        'battleHeroes' => array(
            '_obj_name' => 'battleHeroesVo',
            'pos' => 'int8',    # 英雄位置
            'hp' => 'int32',  # 英雄血量
            'power' => 'int32',  # 英雄战斗力
        ),
        # ==========================
        'battleCommands' => array(
            '_obj_name' => 'BattleVo',
            'bout'  => 'int8',   # 大回合数
            'sponsor' => 'int8', # 发起者位置
            # 发起者BUFF
            'buffid' => array('int32'),
            # 目标列表
            'targets' => array(
                '_obj_name' => 'BattleTarget',
                'id' => 'int8', # 被实施者位置(目标)
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
                'state' => 'int8',
                # BUFF
                'buffid' => array('int32'),
            ),
            'skill' => 'int32', # 技能ID(默认0)
        ),
        'upgrade' => array(
            '_obj_name' => 'UpgradeVo',
            'id' => 'int32',    # 英雄ID
            'level' => 'int8',  # 等级
            'exp' => 'int32',   # 经验
        ),
        'equip' => array(
            '_obj_name' => 'EquipVOS',
            # 装备唯一ID
            'id' => 'int32',
            # 道具类型ID(装备表里有定义)
            'type' => 'int32',
            # 道具是否已装备(<=0 未装备,>0 装备的英雄ID)
            'equip' => 'int32',
            # 等级
            'level' => 'int8',
            # 装备插槽数量
            'socketsNum' => 'int8',
            # 装备镶嵌的宝石ID
            'sockets' => array(
                '_obj_name' => 'MagicBallVOS',
                'id' => 'int32',                # 附魔宝珠表里的ID
                'value' => 'int32',             # 附魔宝珠附加属性值
            ),
            'hp'       	     => 'int32', # 血
            'attack'    	 => 'int32', # 攻
            'defend'    	 => 'int32', # 防
            'puncture'  	 => 'int32', # 穿刺
            'hit'       	 => 'int32', # 命中
            'dodge'     	 => 'int32', # 闪避
            'crit' 			 => 'int32', # 暴击率
            'critPercentage' => 'int32', # 暴击提成
            'anitCrit'       => 'int32', # 免暴
            'toughness'      => 'int32', # 韧性
        ),
        'props' => array(
            '_obj_name' => 'GoodsVOS',
            # 道具唯一ID
            'id' => 'int32',
            # 道具类型ID(道具表里有定义)
            'type' => 'int32',
            # 堆叠数
            'pile' => 'int8',
            # 等级
            'level' => 'int8',
            # 经验
            'exp'  => 'int32',
        ),
    ),
);

# ## 加载或刷新副本地图及怪物刷新时间
# $protocol[22004] = array(
#     'name' => 'fbData',
#     'c2s' => array(
#     	'type'       	=> 'int8',				# 1=加载副本地图，2=刷新副本
#     	'id'       		=> 'int8',				# 副本id
#     ),
#
#     's2c' => array(
#         'id'       => 'int8',				# 地图路线(是哪张地图)
#         'hightMap' => 'int32',				# 地图数据
#         'lowMap'   => 'int32',				# 地图数据
#         'fbTime'      => 'int32',      		# 副本刷新时间
#         'free' => 'int8',      				# 免费刷新副本次数
#         'monsters' => array(
#             '_obj_name' => 'MonstersVo',
#             'pos' => 'int8', # 怪的位置
#             'type' => 'int8', # 怪的类型：1＝精英怪，2＝BOSS，3＝大BOSS
#             'gid' => 'int16', # 关卡ID
#             'status' => 'int8', # 怪的状态：0为已被击败，1为可战斗(没有使用)
#             'time' => 'int32', # 怪的状态为0(已被击败)时的复活剩余秒数
#         ),
#     ),
# );
#
# ## 刷新当前副本地图路线
# $protocol[22006] = array(
#     'name' => 'fbMap',
#     'c2s' => array(
# 		'id'       => 'int8',				# 副本id
#     ),
#
#     's2c' => array(
#         'hightMap' => 'int32',				# 地图数据（用一个二进制数据位表示地图状态，1=开启，0=未开启）
#         'lowMap' => 'int32',				# 地图数据
#     ),
# );


## 副本
$protocol[22010] = array(
    'name' => 'fb',
    'c2s' => array(
        'id'   => 'int8', # 副本id
        'type' => 'int8', # 1=初级，2=中级，3=高级
    ),
    's2c' => array(
        'gate' => 'int16', # 关卡ID
        'num'  => 'int8',  # 挑战次数
        'time' => 'int32', # 剩余秒数
        'num2' => 'int8',  # 购买次数
    ),
);

## 购买副本战斗
$protocol[22014] = array(
    'name' => 'fbBuy',
    'c2s' => array(
        'id'   => 'int8', # 副本id
        'type' => 'int8', # 1=初级，2=中级，3=高级
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 钻石不足
        # 2 = 无需购买(已有战斗)
        # 3 = 不是vip不能购买
        # 4 = 达到购买上限
        # >=127 = 程序异常
        'code' => 'int8',
        'gate' => 'int16', # 关卡id
        'num'  => 'int8',  # 购买次数
        'num2' => 'int8',  # 战斗次数
    ),
);

## 噩梦副本
$protocol[22020] = array(
    'name' => 'fbNightmareInfo',
    'c2s' => array(
    ),
    's2c' => array(
        'nightmareInfo' => array(
            '_obj_name' => 'NightmareInfo',
            'id' => 'int16', # 关卡id
            'star' => 'int8',               # &1=胜利,&2=没有阵亡,&4=20回合
        ),
    ),
);

## 噩梦副本
$protocol[22021] = array(
    'name' => 'fbNightmare',
    'c2s' => array(
        'id'   => 'int16', # 副本关卡id
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功(可以挑战)
        # 1 = 星不够
        # 2 = 疲劳值不足
        # 3 = 道具不足
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);
