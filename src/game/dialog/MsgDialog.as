package game.dialog {
    import game.data.Val;
    import game.net.message.ConnectMessage;
    import game.view.SystemSet.SystemSetDlg;
    import game.view.viewBase.MsgDlgBase;

    import sdk.AccountManager;

    import starling.events.Event;

    /**
         *游戏信息弹出对话框
         * @author Administrator
         *
         */
    public class MsgDialog extends MsgDlgBase {

        public function MsgDialog() {
            enableTween = true;
            ok_Scale9Button.text = Val.getlange("OK");
            //必须点击确认
//			clickBackroundClose();
        }

        override protected function show():void {
            if (contentTxt.text == Val.getlange("ServerClose") || contentTxt.text == Val.getlange("elsewhereLogin")) {
                return;
            }
            text = String(_parameter);
            setToCenter();
        }

        public function set text(value:String):void {
            contentTxt.text = value;
            ok_Scale9Button.visible = value != Val.getlange("connect_tips");
        }

        public function get text():String {
            return contentTxt.text;
        }

        override protected function addListenerHandler():void {
            this.addViewListener(ok_Scale9Button, Event.TRIGGERED, onOkHdr);
        }

        private function onOkHdr(e:Event):void {
            switch (contentTxt.text) {
                case Val.getlange("connect_again"):
//                    if (ConnectMessage.isAutoLogin) {
                        ConnectMessage.connect(connectOk);
                        text = Val.getlange("connect_tips");
//                    } else {
//                        close();
//                    }

                    function connectOk():void {
                        ShowLoader.remove();
                        addTips("connect_ok");
                    }
                    return;
                    break;
                case Val.getlange("ServerClose"):
                    SystemSetDlg.logout();
                    return;
                    break;
                case Val.getlange("elsewhereLogin"):
                    //如果缓存有保存用户文件，则删除该文件   , 清除缓存文件
                    SystemSetDlg.logout();
                    break;
                case Val.getlange("update_data"):
                    AccountManager.instance.exitApp();
                    break;
                default:
                    break;
            }
            onOkBtn();
        }

        override public function getViewGuideDisplay(name:String):* {
            return ok_Scale9Button;
        }
    }
}
