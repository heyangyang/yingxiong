package game.view.magicShop {
    import com.langue.Langue;
    import com.view.base.event.EventType;

    import game.view.dispark.DisparkControl;
    import game.view.dispark.data.ConfigDisparkStep;
    import game.view.magicShop.view.MagicObrGetView;
    import game.view.magicShop.view.MagicSwallowView;
    import game.view.viewBase.MagicOrbDiaBase;

    import starling.display.DisplayObjectContainer;
    import starling.events.Event;

    public class MagicOrbDia extends MagicOrbDiaBase {
        public static const FOUSE:int = 0;
        public static const TUSHI:int = 1;
        private var curPage:int = 0;

        public function MagicOrbDia() {
            super();
            _closeButton = btn_close;
        }

        /**初始化*/
        override protected function init():void {
            configDisparkStep();
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            //选中标签页
            this.addContextListener(EventType.SELECTTAB, onSelectTab);
        }

        /**选中标签页*/
        private function onSelectTab(evt:Event = null, index:int = 0):void {
            switch (index) {
                case 0:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep14)) {
                        select(curPage);
                        return;
                    }
                    curPage = 0;
                    DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep14);
                    break;
                case 1:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep18)) {
                        select(curPage);
                        return;
                    }
                    curPage = 1;
                    DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep18);
                    break;
            }
            currentPanel.updata();
        }

        /**配置功能开放*/
        protected function configDisparkStep():void {
            //功能开放引导
            DisparkControl.dicDisplay["magic_table_1"] = tab_1;
            DisparkControl.dicDisplay["magic_table_2"] = tab_2;

            //智能判断是否添加功能开放提示图标（抽取）
            DisparkControl.instance.addDisparkHandler(ConfigDisparkStep.DisparkStep14);
            //智能判断是否添加功能开放提示图标（吞噬）
            DisparkControl.instance.addDisparkHandler(ConfigDisparkStep.DisparkStep18);
        }


        /**列出按钮*/
        override protected function listTabButton():Array {
            var arr:Array = Langue.getLans("magicEquipSynthesis");
            tab_1.text = arr[0];
            tab_2.text = arr[2];
            return [tab_1, tab_2];
        }

        /**列出引用的类名*/
        override protected function listTabReference():Array {
            return [game.view.magicShop.view.MagicObrGetView, game.view.magicShop.view.MagicSwallowView];
        }

        /**大开窗口*/
        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            if (parameter && parameter is int) {
                defaultSelect = parameter as int;
            }
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
        }
    }
}
