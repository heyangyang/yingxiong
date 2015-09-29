package game.view.userLog {
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.utils.Constants;
    import com.utils.StringUtil;

    import flash.text.ReturnKeyLabel;
    import flash.text.SoftKeyboardType;

    import game.data.Val;

    import game.dialog.MsgDialog;
    import game.dialog.ShowLoader;
    import game.net.GameSocket;
    import game.net.data.s.SXYLMLogin;
    import game.net.message.ConnectMessage;
    import game.utils.Config;
    import game.utils.LocalShareManager;
    import game.view.viewBase.UserLoginDlgBase;

    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.events.Event;

    /**
     * 登录
     * @author hyy
     */
    public class UserLoginDlg extends UserLoginDlgBase {
        public static var isAutoLogin:Boolean = false;
        private var inputUser:Input;
        private var inputPsw1:Input;

        public function UserLoginDlg() {
            super();
        }

        override protected function init():void {
            userImage.alpha = passwordImage.alpha = 0.5;
            userTitleTxt.text = Langue.getLangue("userLoginTitle");
            back_Scale9Button.text = Langue.getLangue("CANCEL"); //取消
            ok_Scale9Button.text = Langue.getLangue("Game_Login"); //登录

            if (Config.device == Config.google_ft || Config.device == Config.google_en) {
                text_des.text = Langue.getLangue("userRule_game_number");
            } else {
                text_des.text = "";
            }

            inputUser = new Input();
            inputPsw1 = new Input();

            inputUser.isPassword = false;
            inputUser.passMatch = false;
            inputUser.defaultText = Langue.getLangue("inputUser0");
            inputUser.input = userInput;
            inputUser.showDefaultText = true;
            inputUser.StartFactory(ReturnKeyLabel.NEXT, function():void {
                inputPsw1.setFocus()
            });

            inputPsw1.isPassword = false;
            inputPsw1.defaultText = Langue.getLangue("inputUser1");
            inputPsw1.input = psw1Input;
            inputPsw1.showDefaultText = true;
            inputPsw1.StartFactory(ReturnKeyLabel.GO, onLogin);

            var gap:int = 5;
            psw1Input.paddingLeft = gap;
            psw1Input.paddingTop = gap;

            //设置输入文本的位置
            setPostion(userInput, userImage);
            setPostion(psw1Input, passwordImage);

            userInput.softKeyboardType = SoftKeyboardType.CONTACT;
            psw1Input.softKeyboardType = SoftKeyboardType.NUMBER;

            var str:String = LocalShareManager.getInstance().get(LocalShareManager.USER_PWD);
            if (str != null) {
                var arr:Array = str.split(":");
                var user:String = arr[0];
                var password:String = arr[1];
                userInput.text = user;
                psw1Input.text = password;
            }
            psw1Input.textEditorProperties.displayAsPassword = true;

            if (isAutoLogin) {
                isAutoLogin = false;
                onLogin(null);
            }
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            //选中标签页
            this.addContextListener(SXYLMLogin.CMD + "", mesaageNotification);
            back_Scale9Button.addEventListener(Event.TRIGGERED, onBack);
            ok_Scale9Button.addEventListener(Event.TRIGGERED, onLogin);
//            lostPasswordButton.addEventListener(Event.TRIGGERED, onLostPassWord); //忘记密码
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
        }

        private function mesaageNotification(evt:Event, info:SXYLMLogin):void {
            switch (info.status) {
                //21=帐号不存在
                case 21:
                    userTipTxt.text = getLangue("securityCodeNoAcount");
                    userTipTxt.color = 0xff0000;
                    ShowLoader.remove();
                    break;
                //22=帐号或密码不正确
                case 22:
                    userTipTxt.text = Langue.getLangue("pswUserError");
                    userTipTxt.color = 0xff0000;
                    ShowLoader.remove();
                    break;
            }
        }

        private function setPostion(current:DisplayObject, target:DisplayObject):void {
            current.x = target.x;
            current.y = target.y;
        }

        private function onLogin(e:Event = null):void {
            if (!(inputUser.findText())) {
                userTipTxt.text = Langue.getLangue("userNotNull");
                userTipTxt.color = 0xff0000;
                return;
            } else if (!(inputPsw1.findText())) {
                userTipTxt.text = Langue.getLangue("passwordNotNull");
                userTipTxt.color = 0xff0000;
                return;
            }

            //点击登录，没有连接服务器的话重新连接
            if (!GameSocket.instance.connected) {
                DialogMgr.instance.open(MsgDialog, Val.getlange("connect_again"));
                return;
            }

            Constants.username = StringUtil.trim(userInput.text.toLocaleLowerCase());
            Constants.password = StringUtil.trim(psw1Input.text.toLocaleLowerCase());

            //连接趣玩服务器  用平台的密码结构
//            if (Config.device == Config.android_Fun_ft) {
//                ConnectMessage.isDeviceLogin = true;
//                DAndroidHttpServer.getInstance().login_count = 0;
//                DAndroidHttpServer.getInstance().login(Constants.username, Constants.password, onReturnHandler);
//
//                function onReturnHandler():void {
//                    ConnectMessage.sendRegisterHandler(Constants.username, Constants.password);
//                }
//            } else {
            ConnectMessage.login();
//            }
        }

        private function onBack(e:Event):void {
            close();
            DialogMgr.instance.open(SelectServerDlg, null, null, null, "translucence", 0x000000, 0);
        }
    }
}
