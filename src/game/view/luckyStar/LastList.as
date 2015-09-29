package game.view.luckyStar {
    import com.mvc.interfaces.INotification;
    import com.view.View;

    import flash.utils.getTimer;

    import feathers.controls.List;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.net.GameSocket;
    import game.net.data.IData;
    import game.net.data.c.CLuck_rebate;
    import game.net.data.s.SLuck_rebate;

    import starling.core.Starling;

    public class LastList extends View {
        private static var time:int = 0;
        private static var quitTime:int;
        private static var list:Vector.<IData>;
        private var _list:List;
        private var isUpdate:Boolean;

        public function LastList() {
            super();
            createList();
            send();
        }

        private function send():void {
            var cmd:CLuck_rebate = new CLuck_rebate;
            GameSocket.instance.sendData(cmd);
//            ShowLoader.add();
        }

        private function update():void {
            if (isUpdate) {
                return;
            }
            time--;
            if (time > 0) {
                Starling.juggler.delayCall(update, 1);
            }
//			else send();
        }

        override public function handleNotification(_arg1:INotification):void {
            var rebate:SLuck_rebate = _arg1 as SLuck_rebate;
//			time = 3000;
            list = rebate.recent;
            restItemRender(rebate.recent);
//            ShowLoader.remove();
//			update();
        }

        private function createList():void {
            const listLayout:TiledRowsLayout = new TiledRowsLayout();
            listLayout.gap = 1;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;

            listLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            _list = new List;
            _list.x = 48;
            _list.y = 370;
            _list.width = 504;
            _list.height = 180;
            _list.layout = listLayout;
            _list.paddingTop = 1;
            /*_list.addEventListener(Event.CHANGE,onSelect);*/
            _list.itemRendererFactory = tileListItemRendererFactory;
            addChild(_list);
        }

        private function restItemRender(dataList:Vector.<IData>):void {
            const collection:ListCollection = new ListCollection(dataList);
            _list.dataProvider = collection;
        }

        private function tileListItemRendererFactory():IListItemRenderer {
            var renderer:LastItemRender = new LastItemRender();
            return renderer;
        }

        override public function listNotificationName():Vector.<String> {
            var vect:Vector.<String> = new Vector.<String>;
            vect.push(SLuck_rebate.CMD);
            return vect;
        }

        override public function dispose():void {
            isUpdate = true;
            quitTime = getTimer();
            super.dispose();
        }

    }
}
