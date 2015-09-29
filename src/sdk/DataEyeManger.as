package sdk
{
import com.utils.Constants;

/**
     * 数据之眼
     * @author hyy
     *
     */
    public class DataEyeManger
    {
        public static const BUY_FB:String="副本次数";
        public static const FLUSH_HERO:String="刷新英雄";
        public static const BUY_HERO:String="英雄";
        public static const BUY_TIRED:String="疲劳";
        public static const STRENGTHEN:String="强化";

        private static var _instance:DataEyeManger;

        public static function get instance():DataEyeManger
        {
            if (_instance == null)
            {
                _instance=new DataEyeManger();
            }
            return _instance;
        }

        private var isStart:Boolean;

        public function start():void
        {
            if (Constants.WINDOWS)
                return;
            isStart=true;
            onActive();
        }

        public function onActive():void
        {
            if (!isStart)
                return;

        }

        public function deActive():void
        {
            if (!isStart)
                return;

        }

        /**
         * 登陆
         *
         */
        public function login():void
        {
            if (!isStart)
                return;

        }

        /**
         * 游戏登出
         *
         */
        public function loginOut():void
        {
            deActive();
        }

        /**
         * 开始充值
         * @param id
         * @param money
         *
         */
        private var chargeId:String;

        public function onCharge(id:String, money:int):void
        {
            if (!isStart)
                return;
            chargeId=id;

        }

        /**
         * 充值成功
         * @param id
         *
         */
        public function onChargeSuccess(id:String):void
        {
            if (!isStart)
                return;

        }

        /**
         * 购买物品
         * @param id    道具 ID 或名称
         * @param type  道具类型
         * @param count 购买的道具数量
         * @param cost  购买道具消耗的虚拟币数量
         * @param currencyType  虚拟币类型
         *
         */
        public function buyItem(id:String, cost:int, count:int=1, type:String="道具", currencyType:String="钻石"):void
        {
            if (!isStart)
                return;

        }

        /**
         * 使用道具
         * @param id     道具 ID 或名称
         * @param count  道具数量
         * @param type   道具类型
         * @param reason 使用道具的原因或用途
         *
         */
        public function useItem(id:String, count:int=1, reason:String="使用", type:String="道具"):void
        {
            if (!isStart)
                return;

        }

        public function beginTollgate(name:String):void
        {
            if (!isStart)
                return;

        }

        /**
         * 通过关卡
         * @param id
         * @param name
         *
         */
        public function completeTollgate(name:String):void
        {
            if (!isStart)
                return;

        }

        /**
         * 未通过关卡
         * @param id
         * @param name
         *
         */
        public function failTollgate(name:String, error:String):void
        {
            if (!isStart)
                return;

        }
    }
}
