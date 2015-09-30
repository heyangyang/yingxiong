<?php

## pvp注册名字
$protocol[23001] = array(
    'name' => 'create_name',
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

## 竞技场信息
$protocol[23004] = array(
    'name' => 'arena_init',
    'c2s' => array(
    ),
    's2c' => array(
        'rank' => 'int32',    # 排名
        'point' => 'int32',	  # 积分
        'honor' => 'int32',	  # 荣誉值
        'level' => 'int8',	  # 等级
    ),
);

## 竞技场兑换
$protocol[23012] = array(
    'name' => 'arena_buy',
    'c2s' => array(
        'id' => 'int32',		# 兑换物品id
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 荣誉值不足
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 竞技场战报
$protocol[23014] = array(
    'name' => 'arena_report',
    'c2s' => array(
    ),
    's2c' => array(
        # 0 = 为空
        # lists = 目标id,name列表
        # >=127 = 程序异常
        'lists' => array(
            '_obj_name' => 'ReportList',
            'id' => 'int32', 	#对手ID
            'name' => 'string', #对手名字
        ),
    ),
);

## 竞技场挑战 （对手基本信息）
$protocol[23015] = array(
    'name' => 'arena_rivalInfo',
    'c2s' => array(
    ),
    's2c' => array(
        'number' => 'int8',	  # 挑战次数
        'cd'	 => 'int32',  # 刷新时间
        'chance' => 'int8',   # 购买挑战机会次数
        'team1'	=>	'int8',	  # 组1宝箱状态,0=未领取,1=已领取
        'team2'	=>	'int8',	  # 组2宝箱状态,0=未领取,1=已领取
        'targets' => array(
            '_obj_name' => 'RivalInfo',
            'id' => 'int32',      # 目标ID
            'name' => 'string',   # 目标名字
            'picture' => 'int8',  # 目标头像
            'beat'	    => 'int8',# 击败状态0=未击败,1=已击败
        ),
    ),
);

## 竞技场排名
$protocol[23016] = array(
    'name' => 'arena_rank',
    'c2s' => array(
    ),
    's2c' => array(
        'lists' => array(
            '_obj_name' => 'RankList',
            'index' => 'int16',     #排名
            'id' => 'int32',
            'name' => 'string',
            'exp'  => 'int16',		# 积分
            'fighting' => 'int32',	# 战斗力
        ),
    ),
);

## 发布悬赏挑战
$protocol[23017] = array(
    'name' => 'arena_Fightbonus',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
		# 1 = 不能发布(一天3次)
		# 2 = 已经有人正在悬赏挑战Ta了
        # >=127 = 程序异常
        'code'   => 'int8',
    ),
);

## 悬赏挑战榜
$protocol[23018] = array(
    'name' => 'arena_bonus',
    'c2s' => array(
    ),
    's2c' => array(
        'active' => array(
            '_obj_name' => 'ActiveTarget',
            'id'   => 'int32',
            'name1' => 'string',
            'name2' => 'string',
        ),
    ),
);

## 竞技场刷新目标
$protocol[23022] = array(
    'name' => 'arena_refresh',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 钻石不足
        # >=127 = 程序异常
        'code' => 'int8',
        'time' => 'int32',	# 刷新时间(40分钟)
        'team1'	=>	'int8',	  # 组1宝箱状态,0=未领取
        'team2'	=>	'int8',	  # 组2宝箱状态,0=未领取
        'targets' => array(
            '_obj_name' => 'RefreshTarget',
            'id' => 'int32',      # 目标ID
            'name' => 'string',   # 目标名字
            'picture' => 'int8',  # 目标头像
            'beat'	=> 'int8',	  # 0=未击败,1=击败
        ),
    ),
);

## 竞技场挑战机会次数购买
$protocol[23024] = array(
    'name' => 'arena_chance',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 钻石不足
        # >=127 = 程序异常
        'code' => 'int8',
        'num'  => 'int8',	# 已经购买次数
    ),
);

## 竞技场挑战对手信息
$protocol[23025] = array(
    'name' => 'arena_RivalFightInfo',
    'c2s' => array(
        'id' => 'int32' , #玩家ID
        'type' => 'int8', # 1 = 正常挑战 , 2 = 反击  ,3 = 揭榜
    ),
    's2c' => array(
		# 消息代码：
        # Code:
        # 0 = 成功(可以挑战)
        # 1 = 挑战次数不足
        # 2 = 揭榜次数不足
        # 3 = 不能挑战自己
        # >=127 = 程序异常
		'code' => 'int8',
        'messege' => array(
            '_obj_name' => 'RivalMessage',
            'type'   => 'int32' ,      #对手英雄type
            'level' => 'int16',   	   #对手英雄等级
            'hp' => 'int32',    	   #对手英雄血量
            'seat' => 'int16',  		   #对手英雄位置
            'weapon' => 'int32', 	   #对手英雄穿戴的武器ID
        ),
    ),
);

## 竞技场排行榜宝箱
$protocol[23028] = array(
    'name' => 'rank_box',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 已经领取
        # 2 = 失败(不满足领取条件)
        # >=127 = 程序异常
        'code' => 'int8',
        'gold'  => 'int32',	# 金币
        'honor' => 'int32', # 荣誉值
    ),
);

## 竞技场挑战宝箱
$protocol[23029] = array(
    'name' => 'combat_box',
    'c2s' => array(
        'type' => 'int8',	# =1(第一组),=2(第二组)
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 已经领取
        # 2 = 失败(不满足领取条件)
        # >=127 = 程序异常
        'code' => 'int8',
        'gold'  => 'int32',	# 金币
        'honor' => 'int32', # 荣誉值
        'point' => 'int16', # 积分
    ),
);

## 竞技场战斗结算
$protocol[23033] = array(
    'name' => 'arena_result',
    'c2s' => array(
    ),
    's2c' => array(

        'gold'    => 'int32', # 金币
        'add_exp' => 'int32', # 积分
        'lev'     => 'int8' , # 当前等级
        'exp'     => 'int32', # 当前经验
    ),
);

## 竞技场对手英雄
$protocol[23035] = array(
    'name' => 'arena_RivalHero',
    'c2s' => array(
        'id'    => 'int32',   # 对手rid
    ),
    's2c' => array(
        'heroes' => array(
            '_obj_name' => 'RivalHeroVO',
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
