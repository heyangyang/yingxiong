package game.dialog {
    import com.langue.Langue;

    import game.view.viewBase.ResignDlgBase;

    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;

    import starling.events.Event;

    /**
     * 购买疲劳
     * @author hyy
     */
    public class ResignDlg extends ResignDlgBase {
        public var onResign:ISignal;
        public var onClose:ISignal;
        private static var _resignDiamondCost:int = 0;

        public function ResignDlg() {
            super();
            enableTween = true;
            onResign = new Signal();
            onClose = new Signal();

            clickBackroundClose();

            initText();
            initOKButtonEvent();
        }

        public function set text(value:String):void {
            txt_info.text = value;
        }

        override protected function show():void {
            setToCenter();
        }

        private function initText():void {
            close_Scale9Button.text = Langue.getLangue("signRewardResignMsgCloseText"); //返回
            ok_Scale9Button.text = Langue.getLangue("signRewardResignMsgOKText"); //确定
            txt_info.text = Langue.getLangue("signRewardResignMsgInfoText").replace("cost", String(_resignDiamondCost)); //操作描述
        }

        private function initOKButtonEvent():void {
            ok_Scale9Button.addEventListener(Event.TRIGGERED, onOKButtonClick);
            close_Scale9Button.addEventListener(Event.TRIGGERED, onCloseButtonClick);
        }

        protected function onOKButtonClick(e:Event):void {
            onResign.dispatch();
            close();
        }

        protected function onCloseButtonClick(e:Event):void {
            onClose.dispatch();
            close();
        }

        override public function dispose():void {
            onResign.removeAll();
            onClose.removeAll();
            super.dispose();
        }
    }
}
