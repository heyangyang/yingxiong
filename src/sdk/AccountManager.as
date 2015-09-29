package sdk {
    import com.freshplanet.ane.AirAlert.AirAlert;
    import com.utils.Constants;

    import flash.desktop.NativeApplication;
    import flash.utils.Dictionary;

    import game.data.Val;
    import game.utils.Config;

    import sdk.base.IPhoneDevice;

    /**
     * 账号管理
     * @author hyy
     *
     */
    public class AccountManager {
        private static var _instance:AccountManager;
        public static var curr_device_class:Class;
        protected var dic:Dictionary = new Dictionary();
        private var curr_device:IPhoneDevice;

        public static function get instance():AccountManager {
            if (_instance == null) {
                _instance = new AccountManager();
            }
            return _instance;
        }

        public function init():void {
            dic[Config.ios] = "t";
            dic[Config.ios_FT] = "v";
            dic[Config.ios_EN] = "w";

            dic[Config.google_ft] = "r";
            dic[Config.google_en] = "x";

            dic[Config.android_turbo] = "p";
            dic[Config.android_turbo1] = "p";
            dic[Config.android_turbo2] = "p";
            dic[Config.android_turbo3] = "p";
            dic[Config.android_tencent] = "q";

            var type:String = Config.device;
            var class_type:Class = curr_device_class;

            if (class_type != null && !Constants.WINDOWS) {
                curr_device = new class_type(type);
                curr_device && curr_device.init();
            }
        }

        /**
         * 平台标识－服务器ID－角色ID－时间（带毫秒）
         * @return
         *
         */
        public function createTag(product_id:String):String {
            var date:Date = new Date();
            return product_id + "-" + Constants.SID + "-" + dic[Config.device] + Constants.UID + "-" + int(date.time / 1000);
        }

        /**
         * 提示框
         * @param msg
         * @param onAlertClosed
         *
         */
        public function showAlert(msg:String, onAlertOk:Function = null, okLable:String = null, onAlertClosed:Function = null,
                                  cancleLable:String = ""):void {
            if (okLable == null) {
                okLable = Val.getlange("OK");
            }
            AirAlert.getInstance().showAlert(Val.getlange("tips_title"), msg, okLable, onAlertOk, cancleLable, onAlertClosed);
        }

        /**
         * 退出程序
         *
         */
//		private var exit_data : Array = [];

        public function exitApp():void {
            if (Constants.ANDROID) {
                NativeApplication.nativeApplication.exit();
            } else {

            }
        }

        /**
         * 登陆
         * @param onSuccess  成功
         * @param onFail     账号
         *
         */
        public function login(onSuccess:Function, onFail:Function):void {
            //ShowLoader.add(Langue.getLangue("login"));
            trace(this, "login curr_device ", curr_device);
            curr_device && curr_device.login(onSuccess, onFail);
        }

        /**
         * 登出
         *
         */
        public function loginOut():void {
            curr_device && curr_device.loginOut();
        }

        public function showBar():void {
            curr_device && curr_device.showBar();
        }

        public function hideBar():void {
            curr_device && curr_device.hideBar();
        }

        public function exitPay():void {
            curr_device && curr_device.exitPay();
        }

        public function exit():void {
            curr_device && curr_device.exit();
        }

        /**
         * 获得平台登陆账号
         * @return
         *
         */
        public function get accountId():String {
            return curr_device ? curr_device.accountId : "";
        }

        /**
         * 购买物品
         * @param id
         *
         */
        public function pay(productId:String, productName:String, productPrice:int, productCount:int, diamond:int):void {
            //        [object AccountManager] [object DGameCenter] 6 com.mstft.diamond_5376 448 1 6-301-undefined1-1410867690
//            trace(this,curr_device,productId, productName, productPrice, productCount, createTag(productId));
            curr_device && curr_device.pay(productId, productName, productPrice, productCount, createTag(productId), diamond);
        }

    }
}
