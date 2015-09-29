package game.net.message {
    import com.adobe.utils.crypto.MD5;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.mobileLib.utils.DeviceType;
    import com.scene.SceneMgr;
    import com.utils.Constants;
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

import game.data.Val;

import game.dialog.MsgDialog;
    import game.dialog.ShowLoader;
    import game.manager.GameMgr;
    import game.net.GameSocket;
    import game.net.data.c.CGivehero;
    import game.net.data.c.CPingSocket;
    import game.net.data.c.CXYLMLogin;
    import game.net.data.s.SGivehero;
    import game.net.data.s.SMsgCode;
    import game.net.data.s.SXYLMLogin;
    import game.net.message.base.Message;
    import game.scene.BattleScene;
    import game.scene.GameLoadingScene;
    import game.scene.LoginScene;
    import game.utils.Config;
    import game.utils.LocalShareManager;
    import game.view.msg.MsgTipsDlg;
    import game.view.new2Guide.NewGuide2Manager;

    import sdk.DataEyeManger;

    import starling.core.Starling;

    /**
     * 用户登陆连接处理
     * @author hyy
     *
     */
    public class ConnectMessage extends Message {
        private static var isPingOk:Boolean = true;
        public static var isAutoLogin:Boolean = false;
        public static var isDeviceLogin:Boolean = false;

        public function ConnectMessage() {
            super();
        }

        override protected function addListenerHandler():void {
            this.addHandler(SXYLMLogin.CMD, loginNotification);
            this.addHandler(SMsgCode.CMD, messageCodeNocification);
            this.addHandler(SGivehero.CMD, createCodeNocification);
            this.addHandler(CPingSocket.CMD, onPingNotify);
            this.addHandler(EventType.CONNNECT, onConnected);
        }

        private function onConnected():void {
            isPingOk = true;
        }

        /**
         * 提交游戏服务器，注册账号
         *  跟平台账号登陆不一样，平台登陆在这之前，平台登陆返回后要调用本接口
         * @param account
         * @param password
         *
         */
        public static function sendRegisterHandler(account:String, password:String):void {
            Constants.username = account;
            Constants.password = password;

            //平台登录
            if (isDeviceLogin) {
                //避免ID重复
                if (DeviceType.isIOS()) {
                    password = "123456";
                    //保存gamecenter账号
                    LocalShareManager.getInstance().save(LocalShareManager.USER_PWD, account + ":" + password);
                } else {
                    password = MD5.hash(Config.device + account);
                    password = password.substring(0, 8);
                }
            }

            var date:Date = new Date();
            var rand:int = date.time / 1000;
            var cmd:CXYLMLogin = new CXYLMLogin();
            cmd.platform = Config.device;
            cmd.password = password;
            cmd.account = cmd.account = Config.isAccountPreName ? Config.device + account : account;
            cmd.rand = rand;
            cmd.sid = Constants.SID;
            cmd.type = 1;
            var key:String = "23d7f859778d2093";
            var md:String = cmd.sid + "" + rand + "" + key + "" + cmd.account;
            cmd.signature = MD5.hash(md);
            sendMessage(cmd);
        }

        /**
         * 消息代码
         * @param evt
         * @param info
         *
         */

        private function messageCodeNocification(info:SMsgCode):void {
            if (SceneMgr.instance.getCurScene() is BattleScene)
                return;
            MsgTipsDlg.instance.tips(info.code);
        }

        private function loginNotification(info:SXYLMLogin):void {
            Constants.UID = GameMgr.instance.uid = info.id;

            switch (info.status) {
                //注册成功
                case 10:
                    saveUserPwd();
                    NewGuide2Manager.updateServerStep(1);
                    if (info.progress == 1) {
                        sendCreateRole();
                    }
                    break;
                case 11:
                    if (ConnectMessage.isDeviceLogin)
                        ConnectMessage.login();
                    else
                        addTips("userExist"); //角色己存在
                    break;
                //登陆成功		
                case 20:
                    saveUserPwd();
                    NewGuide2Manager.updateServerStep(info.progress - 1);
                    //1=已经创建角色
                    //2=已经选择英雄
                    if (info.progress == 1) {
                        sendCreateRole();
                    }

                    if (SceneMgr.instance.getCurScene() is LoginScene) {
                        SceneMgr.instance.changeScene(GameLoadingScene);
                    }
                    break;
                case 21:
                    addTips("securityCodeNoAcount"); //帐号不存在
                    break;
                case 22:
                    addTips("pwdError"); //密码错误
                    break;
                case 23:
                    addTips("passwordNotNull"); //密码不能为空
                    break;
                case 127:
                    addTips("loginError"); //  登陆失败
                    break;
                default:
                    break;
            }
        }

        //如果不是平台账号登陆，保存密码（不是GameCtener 要加密密码注册时,或者GameCtener登陆不成功）
        private function saveUserPwd():void {
            //用户名字和密码的MD5值
            Constants.userPwdMd5 = MD5.hash(Constants.username + "," + Constants.password + "," + Constants.SID);
            if (!isDeviceLogin)
            {
                    LocalShareManager.getInstance().save(LocalShareManager.USER_PWD, Constants.username + ":" + Constants.password);
            }
        }

        public static function login():void {
            var password:String = Constants.password;

            if (password == null || Constants.username == null || password == "" || Constants.username == "") {
                addTips("userPwdNotNull");
                return;
            }
            ShowLoader.add(Langue.getLangue("login"));
            DataEyeManger.instance.login();

            //平台登录
            if (isDeviceLogin) {
                if (DeviceType.isIOS()) {
                    password = "123456";
                } else {
                    password = Config.device + Constants.username;
                    password = MD5.hash(password);
                    password = password.substring(0, 8);
                }
            }

            var date:Date = new Date();
            var rand:int = date.time / 1000;
            var cmd:CXYLMLogin = new CXYLMLogin();
            cmd.password = password;
            cmd.account = Config.isAccountPreName ? Config.device + Constants.username : Constants.username;
            cmd.platform = Config.device;
            cmd.rand = rand;
            cmd.sid = 1;
            cmd.type = 2;
            var key:String = "23d7f859778d2093";
            var md:String = cmd.sid + "" + rand + "" + key + "" + cmd.account;
            cmd.signature = MD5.hash(md);
            sendMessage(cmd, false);
        }

        public static function sendCreateRole(pos:int = 1):void {
            var cmd:CGivehero = new CGivehero;
            cmd.id = 30005;
            sendMessage(cmd);
        }

        private function createCodeNocification(info:SGivehero):void {
            if (info.code == 0) {
                SceneMgr.instance.changeScene(GameLoadingScene);
                DialogMgr.instance.closeAllDialog();
            } else {
                warin("创建角色:" + info);
            }
        }

        public static function ping():void {
            if (GameSocket.instance.connected) {
                isPingOk = false;
                sendMessage(new CPingSocket(), false);
                Starling.juggler.delayCall(checkPing, 5);
            }
        }

        private static function checkPing():void {
            if (!isPingOk) {
                DialogMgr.instance.open(MsgDialog, Val.getlange("connect_again"));
            }
        }

        private function onPingNotify():void {
            isPingOk = true;
            trace("连接正常!");
        }

        public static function connect(socketConnected:Function = null):void {
//			if (GameSocket.instance.connected)
//			{
//				JTLogger.warn("服务器已经连接上");
//				DialogMgr.instance.deleteDlgByClass(MsgDialog);
//				return;
//			}

            GameSocket.instance.connect(Constants.IP, Constants.PORT);

            if (socketConnected != null)
                GameSocket.instance.socketConnected.addOnce(socketConnected);

            if (isAutoLogin)
                GameSocket.instance.socketConnected.addOnce(autoLogin);

            function autoLogin():void {
                login();
                ViewDispatcher.dispatch(EventType.CONNNECT);
                DialogMgr.instance.deleteDlgByClass(MsgDialog);
            }
        }
    }
}
