<?php

## pvp注册名字
$protocol[33001] = array(
    'name' => 'coliseumRegister',
    'c2s' => array(
        'name' => 'string',    # 角色名字
        'picture' => 'int8',   # 头像id
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 创建成功
        # 1 = 名字已被占用
		# 2 = 没有完成关卡数
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 角斗场信息
## $protocol[33004] = array(
##     'name' => 'coliseumInit',
##     'c2s' => array(
##     ),
##     's2c' => array(
##         'rank'  => 'int32',   # 排名
##         'exp'   => 'int32',	  # 功勋值
##         'level' => 'int8',	  # 等级
##         'wars'  => 'int8',	  # 战斗次数
##         'chance'=> 'int8',    # 购买战斗次数
##         'cd'    => 'int32',   # 刷新时间
##     ),
## );

## 角斗场领取荣誉值
## $protocol[33010] = array(
##     'name' => 'coliseumPrize',
##     'c2s' => array(
##     ),
##     's2c' => array(
##         # 消息代码：
##         # Code:
##         # 0 = 成功
##         # 1 = 已经领取过or没到领取时间
##         # 2 = 不在排行榜内
##         # >=127 = 程序异常
##         'code' => 'int8',
##     ),
## );

## 角斗场兑换
$protocol[33012] = array(
    'name' => 'coliseumBuy',
    'c2s' => array(
        'id' => 'int32',		# 兑换物品id
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 荣誉值不足or
        # 1 = 兑换段位不够
        # 3 = 背包已满
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 角斗场战报
$protocol[33014] = array(
    'name' => 'coliseumReport',
    'c2s' => array(
    ),
    's2c' => array(
        # 0 = 为空
        # lists = 目标id,name列表
        # >=127 = 程序异常
        'lists' => array(
            '_obj_name' => 'ColiseumReportList',
            'id' => 'int32', 	#对手ID
            'name' => 'string', #对手名字
            'win' => 'int8',    # 1=胜利，0=失败
            'combat' => 'int32', # 战斗力
            'pic' => 'int32', # 头像
        ),
    ),
);

## 角斗场挑战机会次数购买
$protocol[33024] = array(
    'name' => 'coliseumChance',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 钻石不足
        # 3 = 不是vip不能购买
        # 4 = 达到购买上限
        # >=127 = 程序异常
        'code' => 'int8',
        'num'  => 'int8',	# 已经购买次数
        'wars' => 'int32',	# 战斗次数
    ),
);

## 角斗场挑战对手信息
$protocol[33025] = array(
    'name' => 'coliseumRivalFightInfo',
    'c2s' => array(
        'id' => 'int32' , # 玩家ID
        'type' => 'int8', # 1 = 正常挑战 , 2 = 反击
        'index' => 'int32'# 对方名次
    ),
    's2c' => array(
		# 消息代码：
        # Code:
        # 0 = 成功(可以挑战)
        # 1 = 挑战次数不足
        # 2 = 揭榜次数不足
        # 3 = 不能挑战自己
        # 4 = 不能挑战排名低
        # 5 = 不能挑战他(问策划)
        # 6 = 对方名次已变,更新排行
        # >=127 = 程序异常
		'code' => 'int8',
        'id' => 'int32' , # 玩家ID
        'messege' => array(
            '_obj_name' => 'ColiseumRivalMessage',
            'type'   => 'int32' ,      #对手英雄type
            'level' => 'int16',   	   #对手英雄等级
            'hp' => 'int32',    	   #对手英雄血量
            'seat' => 'int16',  	   #对手英雄位置
            'weapon' => 'int32', 	   #对手英雄穿戴的武器ID
        ),
    ),
);

## 新版角斗场对手英雄
$protocol[33035] = array(
    'name' => 'coliseumRivalHero',
    'c2s' => array(
        'id'    => 'int32',   # 对手rid
    ),
    's2c' => array(
        # 昵称
        'name' => 'string',
        # 公会
        'guild' => 'string',
        # 排名
        'rank' => 'int32',
        # 胜场数
        'wins' => 'int32',
        # 战斗力
        'combat' => 'int32',
        # 头像
        'pic' => 'int8',
        # VIP等级
        'vip' => 'int8',
        'heroes' => array(
            '_obj_name' => 'ColiseumRivalHeroVO',
            # 'id' => 'int32',        # 英雄唯一id
            'type' => 'int32',      # 道具类型ID(道具表里有定义)
            'seat' => 'int8',       # 布阵位置(0未装备|1|2|3|4 )
            # 'quality' => 'int8',    # 品级
            # 'level' => 'int8',      # 等级
            # 'exp' => 'int32',       # 经验
            # 'foster' => 'int8',     # 培养次数

            # 'hp'                    => 'int32', # 血
            # 'attack'                => 'int32', # 攻
            # 'defend'                => 'int32', # 防
            # 'puncture'              => 'int32', # 穿刺
            # 'hit'                   => 'int32', # 命中
            # 'dodge'                 => 'int32', # 闪避
            # 'crit'                  => 'int32', # 暴击率
            # 'critPercentage'        => 'int32', # 暴击提成
            # 'anitCrit'              => 'int32', # 免暴
            # 'toughness'             => 'int32', # 韧性

            # 'seat1'                 => 'int32', # 装备TID 1 （为0时表示没有装备）
            # # 'lev1'                  => 'int8',  # 装备TID 1 的等级（默认0）

            # 'seat2'                 => 'int32', # 装备TID 2
            # # 'lev2'                  => 'int8',  # 装备TID 2 的等级

            # 'seat3'                 => 'int32', # 装备TID 3
            # # 'lev3'                  => 'int8',  # 装备TID 3 的等级

            # 'seat4'                 => 'int32', # 装备TID 4
            # # 'lev4'                  => 'int8',  # 装备TID 4 的等级

            # 'seat5'                 => 'int32', # 装备唯一ID 5

        )
    ),
);

## 新版角斗场排行榜
$protocol[33037] = array(
    'name' => 'coliseumRankInfo',
    'c2s' => array(
    ),
    's2c' => array(
        'rank'  => 'int32',   # 排名
        'exp'   => 'int32',	  # 功勋值
        'level' => 'int8',	  # 等级
        'wars'  => 'int8',	  # 战斗次数
        'chance'=> 'int8',    # 购买战斗次数
        'cd'    => 'int32',   # 刷新时间
        'targets' => array(
            '_obj_name' => 'ColiseumRankInfo',
            'pos'     => 'int32', # 排名
            'id'      => 'int32', # 目标ID
            'rid'     => 'int32', # 目标RID
            'name'    => 'string',# 目标名字
            'picture' => 'int8',  # 目标头像
            'power'   => 'int32', # 战斗力
        ),
    ),
);

## 过期消息通知
$protocol[33040] = array(
    'name' => 'coliseumSend',
    's2c' => array(
        'type' => 'int8' # 1=段位过期 2=有新战报
    ),
);

## 战斗获得奖励推送
$protocol[33042] = array(
    'name' => 'coliseumPrizeSend',
    's2c' => array(
        'diamond' => 'int32', #
        'gold' => 'int32', #
        'honor' => 'int32', #
    ),
);
