package game.view.luckyStar {
    import com.mvc.interfaces.INotification;
    import com.view.View;

    import feathers.controls.List;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.net.GameSocket;
    import game.net.data.IData;
    import game.net.data.c.CLuck_rank;
    import game.net.data.s.SLuck_rank;

    public class RichList extends View {
        private var _type:int;
        private var _list:List;

        public function RichList() {
            super();
            createList();
            send(1);
        }

        private function send(type:int = 0):void {
            var cmd:CLuck_rank = new CLuck_rank;
            cmd.type = type;
            _type = type;
            GameSocket.instance.sendData(cmd);
//            ShowLoader.add();
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
            _list.y = 109;
            _list.width = 504;
            _list.height = 179;
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
            var renderer:RichItemRender = new RichItemRender();
            return renderer;
        }

        override public function handleNotification(_arg1:INotification):void {
            var ran:SLuck_rank = _arg1 as SLuck_rank;
            restItemRender(ran.recent);
//            ShowLoader.remove();
        }

        override public function listNotificationName():Vector.<String> {
            var vect:Vector.<String> = new Vector.<String>;
            vect.push(SLuck_rank.CMD);
            return vect;
        }

        override public function dispose():void {
            _list && _list.dispose();
            super.dispose();
        }

    }
}
