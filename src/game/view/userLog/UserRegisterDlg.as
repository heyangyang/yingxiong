package game.view.userLog {
    import com.components.RollTips;
    import com.langue.Langue;
    import com.utils.StringUtil;

    import flash.system.Capabilities;
    import flash.text.ReturnKeyLabel;
    import flash.text.SoftKeyboardType;

    import feathers.controls.TextInput;
    import feathers.controls.text.StageTextTextEditor;
    import feathers.core.ITextEditor;
    import feathers.events.FeathersEventType;

    import game.data.FontJFData;
    import game.net.message.ConnectMessage;
    import game.utils.Config;
    import game.view.viewBase.UserRegisterDlgBase;

    import starling.events.Event;

    /**
     * 注册
     * @author hyy
     */
    public class UserRegisterDlg extends UserRegisterDlgBase {
        private const inputTextArr:Array = ["input_user", "input_pwd1", "input_pwd2"];
        private var defaultUserTips:String = "inputUser0";
        private var canRegister:Boolean = false;
        private var regex:RegExp = new RegExp("^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$");
        private const MaxChars:int = 16; //最大几个字符

        public function UserRegisterDlg() {
            super();
        }

        override protected function init():void {
            bgImage0.alpha = bgImage1.alpha = bgImage2.alpha = 0.5;
            userRegistTitle.text = Langue.getLangue("Register"); //用户注册
            ok_Scale9Button.text = Langue.getLangue("Game_SignUp"); //注册
            cancel_Scale9Button.text = Langue.getLangue("CANCEL"); //返回

            if (Config.device == Config.google_ft || Config.device == Config.google_en) {
                defaultUserTips = "inputMail"; //点击输入邮箱
                txt_tip.text = getLangue("userRule1"); //推荐使用Email作为游戏帐号!
            } else {
                defaultUserTips = "inputUser0"; //点击输入用户名
                txt_tip.text = "";
            }

            input_user.textEditorFactory = function factory():ITextEditor {
                var editor:StageTextTextEditor = new StageTextTextEditor;
                editor.maxChars = MaxChars;
                editor.returnKeyLabel = ReturnKeyLabel.NEXT;
                return editor;
            }

            input_user.addEventListener("enter", onUserName)
            function onUserName(e:Event):void {
                input_pwd1.setFocus();
            }

            input_pwd1.textEditorFactory = function factory():ITextEditor {
                var editor:StageTextTextEditor = new StageTextTextEditor;
                editor.maxChars = MaxChars;
                editor.returnKeyLabel = ReturnKeyLabel.NEXT;
                return editor;
            }

            input_pwd1.addEventListener("enter", onInput_pwd1)
            function onInput_pwd1(e:Event):void {
                input_pwd2.setFocus();
            }

            input_pwd2.addEventListener("enter", onOkClick)

            input_pwd2.textEditorFactory = function factory():ITextEditor {
                var editor:StageTextTextEditor = new StageTextTextEditor;
                editor.maxChars = MaxChars;
                editor.returnKeyLabel = ReturnKeyLabel.GO;
                return editor;
            }

            input_user.softKeyboardType = SoftKeyboardType.CONTACT;
            input_pwd1.softKeyboardType = input_pwd2.softKeyboardType = SoftKeyboardType.NUMBER;

            input_pwd2.restrict = input_pwd1.restrict = input_user.restrict = "0-9a-zA-Z@."
            input_pwd2.maxChars = input_pwd1.maxChars = input_user.maxChars = 30;
            input_user.text = getLangue(defaultUserTips);
            input_pwd1.text = getLangue("inputUser1");
            input_pwd2.text = getLangue("inputUser2");

        /* if (Constants.isFontFt) {
             input_user.text = FontJFData.changeJ2F(input_user.text);
             input_pwd1.text = FontJFData.changeJ2F(input_pwd1.text);
             input_pwd2.text = FontJFData.changeJ2F(input_pwd2.text);
         }*/
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();

            this.addViewListener(input_user, FeathersEventType.FOCUS_IN, onGetFocusIn);
            this.addViewListener(input_pwd1, FeathersEventType.FOCUS_IN, onGetFocusIn);
            this.addViewListener(input_pwd2, FeathersEventType.FOCUS_IN, onGetFocusIn);
            this.addViewListener(input_user, FeathersEventType.FOCUS_OUT, onGetFocusIn);
            this.addViewListener(input_pwd1, FeathersEventType.FOCUS_OUT, onGetFocusIn);
            this.addViewListener(input_pwd2, FeathersEventType.FOCUS_OUT, onGetFocusIn);
            this.addViewListener(input_user, Event.CHANGE, onInputChange);
            this.addViewListener(input_pwd1, Event.CHANGE, onInputChange);
            this.addViewListener(input_pwd2, Event.CHANGE, onInputChange);
            this.addViewListener(ok_Scale9Button, Event.TRIGGERED, onOkClick);
            this.addViewListener(cancel_Scale9Button, Event.TRIGGERED, onCancelClick);
        }

        private function onCancelClick():void {
            close();
        }

        override protected function show():void {
            setToCenter();
            onInputChange();
        }

        /**
         * 文本获得焦点
         * @param evt
         */
        private function onGetFocusIn(evt:Event):void {
            var inputText:String;
            var input:TextInput = evt.target as TextInput;

            switch (evt.target) {
                case input_user:
                    inputText = getLangue(defaultUserTips);
                    break;
                case input_pwd1:
                    inputText = getLangue("inputUser1");
                    break;
                case input_pwd2:
                    inputText = getLangue("inputUser2");
                    break;
            }

            if (evt.type == FeathersEventType.FOCUS_IN) {
                if (input.text == inputText) {
                    input.text = "";
                }
                input.selectRange(0, input.text.length);
                input.setFocus();
            } else if (evt.type == FeathersEventType.FOCUS_OUT && input.text == "") {
                input.text = inputText;
            }
        }

        /**
         * 文本改变
         *
         */
        private function onInputChange():String {
            var input:TextInput;
            var tips:String = "";
            canRegister = true;

            for (var i:int = 0; i < 3; i++) {
                input = this[inputTextArr[i]];
                input.text = StringUtil.trim(input.text);

                if (!Capabilities.isDebugger && input.text.length < 6) {
                    tips = getLangue("passwordRule");
                }
                this["tag" + i].visible = input.text != getLangue("inputUser" + i);
                this["tag" + i].texture = assetMgr.getTexture("ui_kexuanzhuangtai" + (tips ? 1 : 2));
            }

            if (tips == "") {
                if (input_pwd1.text != FontJFData.changeJ2F(getLangue("inputUser1")) || input_pwd2.text != FontJFData.changeJ2F(getLangue("inputUser2"))) {
                    if (input_pwd1.text != input_pwd2.text) {
                        tips = getLangue("passwordNoMatch");
                    }
                    this["tag2"].texture = this["tag1"].texture = assetMgr.getTexture("ui_kexuanzhuangtai" + (tips ? 1 : 2));
                } else {
                    canRegister = false;
                }
            }

            //验证邮箱
            if (Config.device == Config.google_ft && input_user.text != FontJFData.changeJ2F(getLangue(defaultUserTips)) && !regex.test(input_user.text)) {
                tips = getLangue("notinputMail");
            }

            //帐号 密码空注册的时候
            if (tips == "") {
                if (input_user.text == Langue.getLangue("inputUser0") || input_pwd1.text == Langue.getLangue("inputUser1") || input_user.text == "" || input_pwd1.text == "") {
                    tips = Langue.getLangue("userNotNull") + "    " + Langue.getLangue("passwordNotNull");
                }
            }

            if (tips != "") {
                canRegister = false;
            }
            txt_error.text = tips;
            return tips;
        }

        /**
         * 注册
         */
        private function onOkClick(evt:Event):void {
            var tips:String = onInputChange();
            if (!canRegister) {
                RollTips.add(tips);
                return;
            }

            var account:String = input_user.text.toLocaleLowerCase();
            var password:String = input_pwd1.text.toLocaleLowerCase();
            ConnectMessage.sendRegisterHandler(account, password);
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}
