<?php

# 玩家物品
$protocol[13001] = array(
    'name' => 'allgoods',
    'c2s' => array(
        # 类型
        # 1、请求玩家所有物品(登陆后请求)；
        # 2、请求战斗后掉落的物品。
        'type' => 'int8',
    ),
    's2c' => array(
        # 类型
        # 1、请求玩家所有物品(登陆后请求)；
        #
        # 2、请求战斗后掉落的物品，
        #    如果道具唯一ID已存在，表示更新堆叠数，
        #    实际掉落数量 = 当前堆叠数 - 原堆叠数，
        #    如果是装备则无须考虑堆叠；
        #
        # 3、增加或更新物品，由服务端推送(如强化)，
        #    如果道具唯一ID已存在，表示更新堆叠数。
        'type' => 'int8',
        'equip' => array(
            '_obj_name' => 'EquipVO',
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
                '_obj_name' => 'MagicBallVO',
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
            '_obj_name' => 'GoodsVO',
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


# 穿装备 / 卸载装备
$protocol[13003] = array(
    'name' => 'setEquip',
    'c2s' => array(
        'aotoEquipVO' => array(
            '_obj_name' => 'AotoEquipVO',
            'heroID'  => 'int32', # 英雄唯一ID
            'seat'    => 'int8' , # 英雄装备格子位置 (1 至 4)
            # 装备唯一ID :
            #     >0 : 大于0为穿装备
            #     =0 : 等于0为卸载装备
            'equipID' => 'int32',
        ),
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 装备/卸载 成功
        # 1 = 卸载装备时背包已满
        # 2 = 英雄等级不够
        # 127 = 英雄不存在
        # 128 = 穿戴装备时物品(装备)不存在
        # 129 = 穿戴位置不正确
        # 130 = 没有装备可被卸载
        # 131 = 此装备已穿在别的英雄身上
        'code' => 'int8',
    ),
);


## 装备强化
$protocol[13005] = array(
    'name' => 'strengthen',
    'c2s' => array(
        'equid' => 'int32', # 装备ID
        # 'luck' => 'int32',  # 幸运石唯一ID (默认0)
        'enId1' => 'int32', # (>0:强化石id, =0:没有使用强化石)
        'enId2' => 'int32',
        'enId3' => 'int32',
        'pay' => 'int8'     # 是否付费加速CD（1=是,0=否）
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 强化成功
        # 1 = 强化失败（注：不是错误）
        # 2 = 金币不足
        # 3 = 疲劳CD
        # 4 = 材料不足
        # 5 = 已强化到顶级
        # 6 = 钻石不足
        # 7 = 不可强化或已经达到强化上限
        # >=127 = 程序异常
        'code' => 'int8',
        # 装备ID
        'equid' => 'int32',
        # 强化后的装备等级
        'level' => 'int8',
        # 疲劳CD剩余时间
        'time' => 'int16'
    ),
);


## 装备强化CD
$protocol[13006] = array(
    'name' => 'strengthenCD',
    'c2s' => array(
        'equid' => 'int32', # 装备ID
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # >=127 = 程序异常

        'code' => 'int8',
        # 疲劳CD剩余时间
        'time' => 'int16'
    ),
);


## 镶嵌
## 附魔
## 成功后调用[13001]返回类型为3
$protocol[13010] = array(
    'name' => 'embed',
    'c2s' => array(
        'equid' => 'int32', # 装备ID
        'gemid' => 'int32', # 宝石类型ID,改成唯一ID
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 镶嵌失败（注：不是错误）
        # 2 = 金币不足
        # 3 = 钻石不足
        # 4 = 装备的孔不足或不可镶嵌(插槽数为0)
        # >=127 = 程序异常
        'code' => 'int8',
        # 装备ID
        'equid' => 'int32',
    ),
);

## 宝珠卸载
$protocol[13011] = array(
    'name' => 'unembed',
    'c2s' => array(
        'equid' => 'int32', # 装备ID
        'gemid' => 'int32', # 宝石类型ID
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 金币不足
        # 2 = 钻石不足
        # 3 = 背包已满(暂停使用,背包满折卸失败)
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 合成
$protocol[13012] = array(
    'name' => 'forge',
    'c2s' => array(
        'ids' => array(
            '_obj_name' => 'forgeIds',
            'id' => 'int32', # 待合成物品ID
        ),
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 失败（注：不是错误）
        # 2 = 材料不足
        # 3 = 背包已满
        # 4 = 金币不足
        # 5 = 钻石不足
        # 6 = 装备已穿戴
        # >=127 = 程序异常
        'code' => 'int8',
        'ids' => array(
            '_obj_name' => 'forgeDoneIds',
            'id' => 'int32',
            # 0 = 成功
            # 1 = 失败（注：不是错误）
            'type' => 'int8',
        ),
    ),
);


## 在商城购买商品
$protocol[13021] = array(
    'name' => 'shop',
    'c2s' => array(
        'id' => 'int32', # 商城ID
        # 'buySort' => 'int8',#购买类型(1,2)
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 金币不足
        # 2 = 钻石不足
        # 3 = 背包已满
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);


## 魔法宝珠获取
$protocol[13022] = array(
    'name' => 'getMagicOrbs',
    'c2s' => array(
        'level' => 'int8', # 魔法宝珠等级(1,2,3,4,5)
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 金币不足
        # 2 = 钻石不足
        # 3 = 背包已满
        # >=127 = 程序异常
        'code' => 'int8',
        'level' => 'int8',	# =0 不开启，>0 即将开启的魔法宝珠等级
        'id' => 'int32',	# 获取的魔法宝珠物品唯一ID（没获取则为0）
        'type' => 'int32',	# 获取的魔法宝珠物品类型（没获取则为0）
    ),
);

## 魔法宝珠状态
$protocol[13024] = array(
    'name' => 'magicOrbsState',
    'c2s' => array(

    ),
    's2c' => array(
        'magicOrbs' => array(
            '_obj_name' => 'magicOrbsStateVO',
            'level' => 'int8',  # 魔法宝珠等级
            'state' => 'int8',  # 1=开启 0 = 非开启
        ),
    ),
);

## 宝珠吞噬升级
$protocol[13025] = array(
    'name' => 'jewelry',
    'c2s' => array(
        'id' => 'int32',          # 宝珠唯一id
        'ids' => array('int32'),  # 宝珠唯一id
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 失败
        # 2 = 宝珠不足
        # 4 = 金币不足
        # 5 = 钻石不足
        # >=127 = 程序异常
        'code' => 'int8',
        'level' => 'int32',
        'exp'   => 'int32',
    ),
);

## 装备身上的宝珠吞噬升级
$protocol[13026] = array(
    'name' => 'jewelryequ',
    'c2s' => array(
        'equid' => 'int32',       # 装备唯一id
        'jewtid' => 'int32',      # 升级宝珠Tid
        'ids' => array('int32'),  # 吞噬宝珠唯一id
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 失败
        # 2 = 宝珠不足
        # 4 = 金币不足
        # 5 = 钻石不足
        # >=127 = 程序异常
        'code' => 'int8',
        'level' => 'int32',
        'exp'   => 'int32',
    ),
);

## 背包格子数
$protocol[13027] = array(
    'name' => 'bags',
    'c2s' => array(
        # 1 : 付费开放
        # 2 ：成就开放
        # 3 ：vip开放
        'type' => 'int8',
        'line' => 'int8',    # 开放行数
        # tab : 格子类型
        # 1   : 材料
        # 2   ：道具
        # 5   ：装备
        'tab'  => 'int8',
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 金币不足
        # >=127 = 程序异常
        'code' => 'int8',
        'tab'  => 'int8',    # tab : 格子类型
        'bags' => 'int16',   # bags: 开放成功后格子数
    ),
);

## 批量出售
$protocol[13028] = array(
    'name' => 'oversellItem',
    'c2s' => array(
        # tab : 格子类型
        # 1   : 材料
        # 2   ：道具
        # 5   ：装备
        'tab'  => 'int8',
        'ids' => array('int32'), # 出售物品的唯一ID列表
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 出售成功
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 删除物品(或减少道具堆叠数)
$protocol[13030] = array(
    'name' => 'delGoods',
    's2c' => array(
        'props' => array(
            '_obj_name' => 'DelGoodsVO',
            'id' => 'int32',                # 道具唯一ID
            'pile' => 'int8',               # 堆叠数,大于0时为更新堆叠数,等于0时删除该物品
        ),
    ),
);

## 出售宝珠
$protocol[13032] = array(
    'name' => 'oversellMagicOrbs',
    'c2s' => array(
        # tab : 格子类型
        # 1   : 材料
        # 2   ：道具
        # 5   ：装备
        'tab'  => 'int8',
        'ids' => array(
            '_obj_name' => 'MagicIds',
            'id' => 'int32',
            'num' => 'int8',
        ), # 出售物品的[类型ID,数量]列表

    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 出售成功
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

## 转盘开始...
$protocol[13040] = array(
    'name' => 'luck_start',
    'c2s' => array(
    ),
    's2c' => array(
        # 消息代码：
        # 0=成功
        # 1=没有幸运石
        # 3=背包已满
        # >=127 = 程序异常
        'code' => 'int8',
        'diamond' => 'int32',	# 累积的幸运钻石
        'pos' => 'int8',		# 位置
    ),
);

## 转盘信息,实时排行榜
$protocol[13042] = array(
    'name' => 'luck_rebate',
    'c2s' => array(
    ),
    's2c' => array(
        'recent' => array(
            '_obj_name' => 'RebateRank',
            'name' => 'string',		# string 角色名
            'reward_id' => 'int32',	# int32 最近获得的奖励id
            'reward_num' => 'int32',# int32 物品数量
        ),
    ),
);

## 转盘排行榜(每天凌晨更新)
$protocol[13044] = array(
    'name' => 'luck_rank',
    'c2s' => array(
        'type' => 'int8', # 0 = 本期,1 = 总榜
    ),
    's2c' => array(
        'recent' => array(#
            '_obj_name' => 'LuckRank',
            'name' => 'string',		# 角色名
            'values' => 'int32',	# 使用过的幸运石累计数量
            'sum'	=> 'int32',		# 奖励总价值
        ),
    ),
);
## 转盘(初始信息)
$protocol[13045] = array(
    'name' => 'luckInitInfo',
    'c2s' => array(
    ),
    's2c' => array(
        'id' => 'int8', 	 # 期号
        'luck' => 'int32',   # 幸运星数量
        'values' => 'int32', # 消费累积的点卷
    ),
);

## 签到界面显示
## $protocol[13050] = array(
## 	'name' => 'acc_sign',
## 	'c2s' => array(
## 	),
## 	's2c' => array(
## 		# code:
##      # 0 = 已经签到
## 		# 1 = 没有签到
## 		'code' => 'int8',
## 		'days1' => 'int8',    # 当前签到天数
## 		'days2'  => 'int8',    # 已经签到天数
## 	),
## );

## 签到登录推送
$protocol[13051] = array(
    'name' => 'send_sign',
    'c2s'  => array(
    ),
    's2c'  => array(
        # code:
        # 1 = 有签到奖励没领取
        'code' => 'int8',
    ),
);

## 连续签到
$protocol[13052] = array(
    'name' => 'sign',
    'c2s' => array(
    ),
    's2c' => array(
        # code:
        # 0 = 签到成功
        # 1 = 已经签到
        # 2 = 签到失败(没到签到时间)
        # >=127 = 程序异常
        'code' => 'int8',
        'type' => 'int8',      # 奖励类型(1,2)
        'days1'  => 'int8',    # 当前签到天数
        'days2'  => 'int8',    # 已经签到天数
        'days' => array(
            '_obj_name' => 'SignState',
            'day' => 'int8',
            'state' => 'int8', # 0=未签到,1=可领取,2=已领取
        ),
    ),
);

## 签到续签
$protocol[13054] = array(
    'name' => 'offset_sign',
    'c2s' => array(
    ),
    's2c' => array(
        # code:
        # 0 = 续签成功
        # 1 = 钻石不足
        # 2 = 没有漏签
        # >=127 = 程序异常
        'code' => 'int8',
        'days1'  => 'int8',    # 当前签到天数
        'days2'  => 'int8',    # 已经签到天数
        #'diamond' => 'int32',  # 续签扣除钻石
        'days' => array(
            '_obj_name' => 'OffsetState',
            'day' => 'int8',
            'state' => 'int8', # 0=未签到,1=可领取,2=已领取
        ),
    ),
);

## 签到领奖
$protocol[13056] = array(
    'name' => 'get_sign',
    'c2s' => array(
        'day' => 'int8',     # 领取天数
    ),
    's2c' => array(
        # code:
        # 0 = 成功
        # 1 = 已经领取
        # 2 = 没有签到
        # 3 = 背包已满
        # >=127 = 程序异常
        'code' => 'int8',
        'state' => 'int8',   # 1 = 存在奖励未领取, 0 = 不存在
    ),
);

## 关卡礼包通知
$protocol[13058] = array(
    'name' => 'tollgateNotice',
    's2c' => array(
        'id' => 'int8',    # 可领取id
    ),
);

## 关卡礼包领奖
$protocol[13059] = array(
    'name' => 'get_tollgatePrize',
    'c2s' => array(
        # 'tollgate' => 'int16',     # 领取关卡
    ),
    's2c' => array(
        # code:
        # 0 = 成功
        # 1 = 已经领取或没达到条件
        # 3 = 背包已满
        # >=127 = 程序异常
        'code' => 'int8',
        'id'  => 'int8',         # 下阶段关卡id
        'type'  => 'int8',       # 0=未完成,1=可以领取
    ),
);

## 图鉴功能(pictorialial)
$protocol[13062] = array(
    'name' => 'pictorialial',
    'c2s' => array(
    ),
    's2c' => array(
        'herose' => array(
            '_obj_name' => 'Pictorial',
            'id' => 'int32',    # 英雄id
        ),
    ),
);

## 角色头像更换
$protocol[13064] = array(
    'name' => 'rolePictrue',
    'c2s' => array(
        'id' => 'int8',
    ),
    's2c' => array(
        # code:
        # 0 = 成功
        # 1 = 没开通角斗场
        # 2 =
        # >=127 = 程序异常
        'code' => 'int8',
    ),
);

# 客户端数据存储
$protocol[13066] = array(
    'name' => 'clientInfoStore',
    'c2s' => array(
        # type=1(存储),=2(获取),=3(删除)
        'type'    => 'int8',
        'key'   => 'int8',
        'value' => 'string',
    ),
    's2c' => array(
        # 消息代码：
        # Code:
        # 0 = 成功
        # 1 = 失败
        # >=127 = 程序异常
        'code'  => 'int8',
        'custom' => 'string',
    ),
);

# 13067英雄魂
$protocol[13067] = array(
    'name' => 'herosoul',
    'c2s' => array(
        # 0 = 请求数据
        # 1 = 刷新
       'type' => 'int8',
    ),
    's2c' => array(
        # 0 = 成功
        # 1 = 钻石不足
        # 2 = 配置错误
        # >=127 = 程序异常
        'code' => 'int8',
        'time' => 'int32',             # 剩余刷新时间/秒
        'coin_time' => 'int32',        # 金币抽取剩余时间/秒
        'lefttimes' => 'int8',         # 金币抽取剩余次数
        'herosoul' => array(
            '_obj_name' => 'heroSoulList',
            'pos' => 'int8',           # 位置1-9
            'id' => 'int32',           # 英雄魂id
            'type' => 'int8',          # 0=正常,1=锁定
            'rare' => 'int8',          # 稀有度
        ),
    ),
);

# 抽取英雄魂
$protocol[13068] = array(
    'name' => 'getherosoul',
    'c2s' => array(
        # 1 = 金币抽取
        # 2 = 钻石抽取
        # 3 = 一键收取
        'type' => 'int8',
    ),
    's2c' => array(
        # 0 = 成功
        # 1 = 金币不足
        # 2 = 钻石不足
        # 3 = 金币cd未到,
        # 4 = 配置错误
        # 5 = 其他错误
        # 6 = 背包不足
        # 7 = 金币抽取次数不足
        # 8 = 没有英雄魂,需要刷新
        # >=127 = 程序异常
        'code' => 'int8',
        'time' => 'int32',
        'num' => 'int8',
        'pos' => 'int8',  #位置
        'id' => 'int32',  #id,英雄魂id,如果是全部收取,返回id为0
    ),
);
