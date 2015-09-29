package com.dialog {
    import com.components.GroupSelect;
    import com.utils.Constants;
    import com.view.base.event.EventType;

    import flash.utils.Dictionary;

    import starling.events.Event;

    /**
     * 标签页窗体
     * @author Samuel
     *
     */
    public class TabDialog extends Dialog {

        private var tabButtons:Array;
        private var referens:Array;
        private var groupSelect:GroupSelect;
        private var groupTabBtn:GroupSelect;
        protected var defaultSelect:int;
        public var panels:Dictionary = null;

        public function TabDialog(isAutoInit:Boolean = false) {
            super(isAutoInit);
        }


        //列出引用的类名
        protected function listTabReference():Array {
            return [];
        }

        //列出按钮
        protected function listTabButton():Array {
            return [];
        }

        /**
         * 放到屏幕中间
         * @param _arg1
         */
        override public function setToCenter(x:int = 0, _y:int = Constants.TITLE_GAP):void {
            this.x = (Constants.virtualWidth - this.width + x) * .5;
            this.y = (Constants.virtualHeight - this.height + _y) * .5;
        }

        override protected function initComponent():void {
            super.initComponent();
            if (tabButtons != null || referens != null) {
                throw new Error('don`t call init method again!');
            }
            panels = new Dictionary();
            tabButtons = listTabButton();
            referens = listTabReference();
            for (var i:int = 0, j:int = tabButtons.length; i < j; i++) {
                if (tabButtons[i] == null) {
                    throw new Error('can`t find ' + tabButtons[i]);
                }
                tabButtons[i].addEventListener(Event.TRIGGERED, tabHandler);
            }

            groupSelect = new GroupSelect(referens, function(o:Object):void {
                if (o is Class) {
                    var index:int = referens.indexOf(o);
                    referens[index] = new o;
                    referens[index].name = tabButtons[index];
                    addChild(referens[index]);
                    referens[index].visible = true;
                    panels[index] = referens[index];
                } else {
                    o.visible = true;
                }
            }, function(o:Object):void {
                if (!(o is Class)) {
                    o.visible = false;
                }
            });
            groupTabBtn = new GroupSelect(tabButtons, function(o:Object):void {
                o.selected = true;
            }, function(o:Object):void {
                o.selected = false;
            });
            select(defaultSelect);
        }

        private function tabHandler(evt:Event):void {
            select(tabButtons.indexOf(evt.currentTarget));
        }


        public function select(index:int):void {
            groupTabBtn.select(index);
            groupSelect.select(index);
            defaultSelect = index;

            dispatch(EventType.SELECTTAB, index);
        }

        public function get currentSelect():int {
            return defaultSelect;
        }

        public function get currentPanel():Object {
            return panels[defaultSelect] as Object;
        }

        public function getPanel(index:int):Object {
            return panels[index];
        }

        override public function dispose():void {
            groupSelect && groupSelect.dispose();
            groupTabBtn && groupTabBtn.dispose();

            tabButtons = null;
            referens = null;

            groupSelect = null;
            groupTabBtn = null;

            panels = null;

            super.dispose();
        }


    }
}
