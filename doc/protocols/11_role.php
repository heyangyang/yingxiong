<?php

# 登陆/注册验证说明：
#
# 服务器ID(sid) ：1
# 随机数(rand)  ：unixtime
# 当前加密KEY   ：23d7f859778d2093
# 签名算法      ：md5(sid + rand + key + account)
#
$protocol[11000] = array(
    'name' => 'XYLMLogin',
    'c2s' => array(
        # type:
        #     1=注册
        #     2=登陆
        'type' => 'int8',
        # unixtime
        'rand' => 'int32',
        # 服务器ID
        'sid' => 'int16',
        # platform
        'platform' => 'string',
        # 帐号名
        'account' => 'string',
        # md5计算后的密码
        'password' => 'string',
        # 签名
        'signature' => 'string',
    ),
    's2c' => array(
        # 注册:
        #    10=注册成功
        #    11=帐号已存在（请更换帐号）
        #
        # 登陆:
        #    20=登陆成功
        #    21=帐号不存在
        #    22=帐号或密码不正确
        #    23=密码不能为空
        #
        # 异常:
        #    127=签名不正确
        #    128=错误的登陆方式
        #    129=请先注销
        #    131=注册失败1
        #    132=注册失败2
        #    133=注册失败3
        #    141=登陆失败1
        #    142=登陆失败2
        #
        'status' => 'int8',
        # 成长进度:
        #    1=已经创建角色
        #    2=已经选择英雄
        'progress' => 'int8',
        # 角色ID
        'id' => 'int32',
    ),
);

# 角色登陆
# $protocol[11001] = array(
#     'name' => 'login',
#     'c2s' => array(
#         # string 登陆字符串
#         'login' => 'string',
#     ),
#     's2c' => array(
#         # 登陆状态:
#         #    0=成功
#         #    1=失败
#         'state' => 'int8',
#         # 成长进度:
#         #    0=未创建角色
#         #    1=已经创建角色
#         #    2=已经选择英雄
#         'progress' => 'int8',
#         # 角色ID
#         'id' => 'int32',
#     ),
# );

# 创建角色
# $protocol[11002] = array(
#     'name' => 'create_role',
#     'c2s' => array(
#         # 角色名字
#         'name' => 'string',
#         # 性别:
#         # 1=男
#         # 2=女
#         'sex' => 'int8',
#     ),
#     's2c' => array(
#         # 状态:
#         # 0=成功
#         # 1=名字已存在
#         'state' => 'int8',
#     ),
# );

# 获取游戏基础数据
$protocol[11003] = array(
    'name' => 'get_game_data',
    'c2s' => array(
    ),
    's2c' => array(
        'diamond'       => 'int32',      # 钻石
        'coin'          => 'int32',      # 金币
        'tollgateid'    => 'int32',      # 关卡ID
        'tired'         => 'int32',      # 疲劳
        'bagequ'        => 'int16',      # 装备背包格子数
        'bagprop'       => 'int16',      # 道具背包格子数
        'bagmat'        => 'int16', 	 # 材料背包格子数
        'arenaname'     => 'string',     # 竞技场名字
        'picture'       => 'int8',	     # 竞技场头像id
        'lucknum'       => 'int32',      # 幸运星数量
        'horn'          => 'int32',      # 喇叭数量
        'chattime'      => 'int8',       # 喇叭时间间隔
        'tollgateprize' => 'int8',       # 关卡礼包
        'verify'        => 'int32',      # 激活码
        'level'         => 'int8',       # 角斗场等级
        'herotab'       => 'int8',       # 可携带英雄数
        'viplev'        => 'int8',       # vip等级
        'firstpay'      => 'int8',       # 是否充值0,1
    ),
);

# 更新荣誉值
$protocol[11004] = array(
    'name' => 'get_game_honor',
    's2c' => array(
        'honor' => 'int32',              # 荣誉值
    ),
);

# 更新游戏金币
$protocol[11005] = array(
    'name' => 'get_game_coin',
    's2c' => array(
        'coin' => 'int32',              # 金币
    ),
);

# 更新游戏钻石
$protocol[11006] = array(
    'name' => 'get_game_diamond',
    's2c' => array(
        'diamond' => 'int32',              # 钻石
    ),
);

# 更疲劳
$protocol[11007] = array(
    'name' => 'get_tired',
    'c2s' => array(
    ),
    's2c' => array(
        'tired' => 'int32',              # 疲劳
        'num'  => 'int16',				# 今天购买疲劳次数
        'time' => 'int32',              # 下次更新疲劳时间（秒）
    ),
);

# 更新幸运星
$protocol[11008] = array(
    'name' => 'get_game_luck',
    's2c' => array(
        'luck' => 'int32',              # 幸运星
    ),
);

# 更新喇叭
$protocol[11009] = array(
    'name' => 'get_game_horn',
    's2c' => array(
        'horn' => 'int32',              # 喇叭
    ),
);

# 设置成长进度 (成长进度只能设置为大于或等于当前值)
$protocol[11010] = array(
    'name' => 'setGrowth',
    'c2s' => array(
        # 成长进度：
        # 1、选择第一个英雄
        # 2、...(以下自己定义)
        # 3、...
        'growth' => 'int8',
    ),
    's2c' => array(
        # 状态:
        #    0=成功
        #    1=失败(growth小于当前值)
        'code' => 'int8',
    ),
);

# 引导完成进度
$protocol[11011] = array(
    'name' => 'funGuideData',
    'c2s' => array(
        # 引导类型(1=净化/2=酒馆,3=副本,4=竞技场)
        'value' => 'int8',
        # 0=引导做完,N=完成阶段
        'value1' => 'int8',
    ),
    's2c' => array(
        # 状态:
        #    0=成功
        #    1=失败(guide小于当前值/type错误)
        'code' => 'int8',
     ),
);

# 登录时引导进度推送
$protocol[11013] = array(
    'name' => 'sendGuideData',
    'c2s' => array(
    ),
    's2c' => array(
        # 引导类型(1=净化/2=酒馆,3=副本,4=竞技场)
        'value' => 'int8',
        # N=完成阶段(=0时不推送)
        'value1' => 'int8',
     ),
);

# 功能开放进度
## 1       装备强化
## 2       图鉴
## 3       酒馆
## 4       雇佣兵
## 5       幸运星
## 6       聊天
## 7       角斗场
## 8       副本
## 9      邮件
## 10      噩梦
## 11      商店
## 12      英雄进化
## 13      英雄培养
## 14      宝珠抽取
## 15      装备合成
## 16      英雄分解
## 17      装备镶嵌
## 18      宝珠吞噬
## 19      经验药水
## 20      宝珠合成
$protocol[11014] = array(
    'name' => 'setfunData',
    'c2s' => array(
        'id' => 'int8',    # 功能ID
        'value' => 'int8', # 进度
    ),
    's2c' => array(
        # 状态:
        # 0=成功
        # >= 127 = 程序异常
        'code' => 'int8',
    ),
);

# 登录时功能开放进度推送
$protocol[11015] = array(
    'name' => 'sendFunData',
    'c2s' => array(
    ),
    's2c' => array(
        'list' => array(
            '_obj_name' => 'funData',
            # 功能id
            'id' => 'int8',
            # N=完成阶段
            'value' => 'int8',
        ),
     ),
);

# ping socket
$protocol[11016] = array(
    'name' => 'PingSocket',
    'c2s' => array(),
    's2c' => array(),
);

# 购买疲劳
$protocol[11027] = array(
    'name' => 'buy_tired',
    'c2s' => array(
    ),
    's2c' => array(
        # code:
        # 0 = 购买成功
        # 1 = 钻石不足
        # 2 = 无需购买(>=100)
        # 3 = 不是vip不能购买
        # 4 = 达到购买上限
        # >= 127 = 程序异常
        'code'  => 'int8',
        'tired' => 'int32',   # 疲劳
        'num'   => 'int16',   # 今天购买疲劳次数
    ),
);

# 用帐号密码登陆
# $protocol[11101] = array(
#     'name' => 'useUserPsw',
#     'c2s' => array(
#         'account' => 'string', # 帐号
#         'password' => 'string', # 密码
#     ),
#     's2c' => array(
#         # 登陆状态:
#         #    0=成功
#         #    1=密码错误或帐号不存在
#         'state' => 'int8',
#         # 成长进度:
#         #    1=正常
#         'progress' => 'int8',
#         # 角色ID
#         'id' => 'int32',
#     ),
# );
#
# # 注册帐号
# $protocol[11102] = array(
#     'name' => 'registUser',
#     'c2s' => array(
#         'account' => 'string', # 帐号
#         'password' => 'string', # 密码
#     ),
#     's2c' => array(
#         # 状态:
#         #    0=成功
#         #    1=帐号已存在
#         #    >=127 异常
#         'code' => 'int8',
#     ),
# );

# 检查帐号是否可注册
$protocol[11103] = array(
    'name' => 'matchUser',
    'c2s' => array(
        'account' => 'string', # 帐号
    ),
    's2c' => array(
        # 状态:
        #    0=可注册
        #    1=帐号已存在
        'code' => 'int8',
    ),
);



# 获取玩家所有数据数据，按顺序：1.游戏基础数据；2.玩家道具；3.玩家英雄
# 服务器推送完成所有数据后再返回本协议
$protocol[11104] = array(
    'name' => 'retrieveAllData',
    'c2s' => array(
    ),
    's2c' => array(
		 'code' => 'int8',  # 0=成功>0各种原因失败
    ),
);

# 获取验证码，如果5分钟内没有收到验证码，请重新获取
$protocol[11111] = array(
    'name' => 'getVerifyCode',
    'c2s' => array(
        # 玩家帐号，必段是符合以下条件才能获取：
        # 1、长度为11字节
        # 2、全部为数字
        # 3、开头两头必须是：13、14、15、18
        'account' => 'string',
    ),
    's2c' => array(
        # 0=成功
        # 1=帐号不存在
        # 2=你的帐号不是11位数字的手机号码，请联系客服重置
        # 3=请稍后再获取验证码 (5分钟倒计时不为0时收到了请求)
        # 127=获取失败
        'code' => 'int8',
    ),
);

# 重置密码
$protocol[11112] = array(
    'name' => 'resetPassword',
    'c2s' => array(
        # 玩家帐号，必段是符合以下条件才能获取：
        # 1、长度为11字节
        # 2、全部为数字
        # 3、开头两头必须是：13、14、15、18
        'account' => 'string',
        # 六位数字的验证码，10分钟内有效
        'verifyCode' => 'int32',
        # 新密码
        'password' => 'string',
    ),
    's2c' => array(
        # 0=成功
        # 1=帐号不存在
        # 2=你的帐号不是11位数字的手机号码，请联系客服重置
        # 3=验证码已失效，请重新获取
        # 4=验证码不正确
        # 127=重置失败
        'code' => 'int8',
    ),
);
