package game.data {
    import com.utils.Constants;

    import game.utils.Config;


    /**
         *
         * @author Administrator
         */
    public class Val {
        private static const OK:String = "确定";
        private static const GOTO:String = "继续";
        private static const CANCEL:String = "取消";
        private static const exit:String = "退出";
        private static const exit_msg:String = "是否确定退出游戏?";
        private static const tips_title:String = "提示";
        private static const ServerClose:String = "服务器即将关闭!";
        private static const elsewhereLogin:String = "您的账号已经在别处登录!";
        private static const update_data:String = "数据需要更新,请重新进入游戏!";
        private static const connect_tips:String = "正在连接中...请稍等";
        private static const connect_again:String = "您的网络好像不太稳定哦，请确认后重新连接";
        private static const close_app:String = "更新完毕，请重新进入游戏！";
        private static const loader_server:String = "正在拼命更新资源:";
        private static const loader:String = "正在拼命加载本地的图片无需耗流量";
        private static const NET_CONNECT_ERROR:String = "网络连接失败,请检测你的网络!";
        private static const LOAD_NO_WIFT:String = "您的当前网络不是wifi,是否确认继续更新?";

        private static const OK_En:String = "OK";
        private static const GOTO_En:String = "Continue";
        private static const CANCEL_En:String = "Cancel";
        private static const exit_En:String = "Exit";
        private static const exit_msg_En:String = "Are you sure exit the game?";
        private static const tips_title_En:String = "Tips";
        private static const ServerClose_En:String = "Server will be shut down!";
        private static const elsewhereLogin_En:String = "Your account is already logged in elsewhere!";
        private static const update_data_En:String = "Data needs to be updated, re-enter the game!";
        private static const connect_tips_En:String = "Connecting ... Please wait";
        private static const connect_again_En:String = "Your network seem unstable, reconnect please";
        private static const close_app_En:String = "Updated, please re-enter the game！";
        private static const loader_server_En:String = "Resources are desperately update";
        private static const loader_En:String = "Pictures are desperately load without consumption of local traffic ";
        private static const NET_CONNECT_ERROR_En:String = "Network connection fails, please check your network";
        private static const LOAD_NO_WIFT_En:String = "Your current network is not wifi, continue to update?";

        public static function getlange(value:String):String {
            if (Config.Device_Lan == Constants.EN) {
                return Val[value + "_En"];
            } else {
                return Val[value];
            }
        }

        public static const DROP_PVP:String = "0";
        public static const DROP_PVP_GET:String = "-1";

        public static const PASS_FB:int = 1;

//        /**
//         * 最大上阵位置
//         */
        public static const SEAT_MAX:int = 5;

        /**
         * 客户端位置转服务器
         * @param pos
         * @return
         *
         */
        public static function posC2S(pos:int):int {
            return pos >= Val.SEAT_COUNT ? 21 + pos : 11 + pos;
        }

        /**
         * 服务器位置转客户端
         * @param pos
         * @return
         *
         */
        public static function posS2C(pos:int):int {
            return pos >= 21 ? pos - 21 + Val.SEAT_COUNT : pos - 11;
        }

        public static var filter:Vector.<Number> = new Vector.<Number>;
        filter.push(0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0)

        public static var MAGICBALL:Array = ["attack", "hp", "defend", "puncture", "hit", "dodge", "crit", "critPercentage",
                                             "anitCrit", "toughness"];
        public static var tabList:Object = {5: "bagequ", 2: "bagprop", 1: "bagmat"};

        public static var hardList:Object = {1: 5, 2: 10, 3: 20}


        public static var PROPERTY_ICON:Object = {attack: "ui_tongyong_tubiao_gongji", hp: "ui_tongyong_tubiao_xueliang",
                defend: "ui_tongyong_tubiao_fangyu", puncture: "ui_tongyong_tubiao_chuanci", hit: "ui_tongyong_tubiao_mingzhong",
                dodge: "ui_tongyong_tubiao_shanbi", crit: "ui_tongyong_tubiao_baoji", critPercentage: "ui_tongyong_tubiao_baoqiang",
                anitCrit: "ui_tongyong_tubiao_mianbao", toughness: "ui_tongyong_tubiao_renxing"};
        /*
         *
         * 角色形象缩放的分母
         *
         * */
        public static var ROLE_ZISE:int = 100;
        /**
         * 英雄身上最大技能数量
         */
        public static const SKILL_COUNT:int = 5;
        /**
         * 英雄身上的装备数量
         */
        public static const EQUIP_COUNT_ON_HERO:int = 4;
        /**
         * 装备分类
         */
        public static const SEAT_WEAPON:int = 1;
        /**
         *
         * @default
         */
        public static const SEAT_NECKLACE:int = 2;
        /**
         *
         * @default
         */
        public static const SEAT_RING:int = 3;
        /**
         *
         * @default
         */
        public static const SEAT_BRACELET:int = 4;

        /**
         * 物品分类
         */
        public static const TAB_EQUIP:int = 1;
        /**
         *
         * @default
         */
        public static const TAB_OBJ:int = 2;
        /**
         *
         * @default
         */
        public static const TAB_PROP:int = 3;
        /**
         *
         * @default
         */
        public static const TAB_SKILL:int = 4;

        public static const HERO_COLOR:Array = [0xffffff, 0x3cff00, 0x0042ff, 0xde00ff, 0xffae00, 0xfd0000, 0xfffc00];
        /**
         * 布阵位置数量
         */
        public static const SEAT_COUNT:int = 9;
        /*
           #  &1   - 暴击
           #  &2   - 闪避
           #  &4   - 复活
           #  &8   - 治疗
         */
        /**
         *
         * @default
         */
        public static const BJ:int = 1;
        // 闪避
        /**
         *
         * @default
         */
        public static const SB:int = 2;
        // 复活
        /**
         *
         * @default
         */
        public static const FH:int = 4;
        // 治疗
        /**
         *
         * @default
         */
        public static const ZL:int = 8;

        // 战斗驱动时间间隔
        /**
         *
         * @default
         */
        public static const BATTLE_DRIVER_DELAY:Number = 0.8;

        public static const PORT_PUBLISH:int = 8200;
    }
}
