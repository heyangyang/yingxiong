package game.view.blacksmith {
    import com.langue.Langue;
    import com.view.base.event.EventType;
    
    import feathers.data.ListCollection;
    
    import game.data.WidgetData;
    import game.view.blacksmith.view.InsetView;
    import game.view.blacksmith.view.StrengthenView;
    import game.view.dispark.DisparkControl;
    import game.view.dispark.data.ConfigDisparkStep;
    import game.view.viewBase.BlacksmithDialogBase;
    
    import starling.display.DisplayObjectContainer;
    import starling.events.Event;

    /**
     * 铁匠铺
     * @author Samuel
     */
    public class BlacksmithDialog extends BlacksmithDialogBase {
        private var curPage:int = 0;
        private var _currentWidgetData:WidgetData;

        public function BlacksmithDialog() {
            super();
        }

        /**初始化*/
        override protected function init():void {
            _closeButton = btn_close;
            bgImage.alpha = 0.5;
            configDisparkStep();
            //选中标签页
            this.addContextListener(EventType.SELECTTAB, onSelectTab);
        }

        /**列出按钮*/
        override protected function listTabButton():Array {
            var arr:Array = Langue.getLans("blacksmith");
            tab_1.text = arr[0];
            tab_2.text = arr[1];
            return [tab_1, tab_2];
        }

        /**列出引用的类名*/
        override protected function listTabReference():Array {
            return [StrengthenView, InsetView];
        }

        /**选中标签页*/
        private function onSelectTab(evt:Event = null, index:int = 0):void {
            switch (index) {
                case 0:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep1)) {
                        select(curPage);
                        return;
                    }
                    curPage = 0;
                    DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep1);

                    if (_currentWidgetData) {
                        currentPanel.data = _currentWidgetData;
                        _currentWidgetData = null;
                    }
                    break;
                case 1:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep17)) {
                        select(curPage);
                        return;
                    }
                    curPage = 1;
                    DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep17);

                    if (_currentWidgetData) {
                        currentPanel.data = _currentWidgetData;
                        _currentWidgetData = null;
                    }
                    break;
            }
        }

        /*  参数说明：
           null : 不传值
           基础对象：{tab:标签页,data:具体数据}
         */
        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            if (parameter) {
                defaultSelect = parameter.tab as int;
                if (parameter.data) {
                    _currentWidgetData = parameter.data;
                }
            }
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
        }

        /**配置功能开放*/
        protected function configDisparkStep():void {
            //功能开放引导
            DisparkControl.dicDisplay["equintment_table_1"] = tab_1;
            DisparkControl.dicDisplay["equintment_table_2"] = tab_2;

            //智能判断是否添加功能开放提示图标（装备强化）
            DisparkControl.instance.addDisparkHandler(ConfigDisparkStep.DisparkStep1);
            //智能判断是否添加功能开放提示图标（装备镶嵌）
            DisparkControl.instance.addDisparkHandler(ConfigDisparkStep.DisparkStep17);
        }
		
		override public function set visible(value:Boolean):void
		{
			super.visible = value;
			if(value)
			{
				if(defaultSelect==0){
					currentPanel.refresh();//购买刷新
				}
			}
		}
    }
}
