package game.view.blacksmith.render {
    import com.langue.Langue;

    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.data.WidgetData;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.view.viewBase.BallPaneBase;

    import spriter.SpriterClip;

    import starling.events.Event;

    /**
     *宝珠镶嵌界面
     * @author Administrator
     */
    public class BallPane extends BallPaneBase {
        private var _selectedAnimation:SpriterClip;

        public function BallPane() {
            super();
        }

        override protected function show():void {
            title.text = Langue.getLangue("BAOZHU");
            cancelScale9Button.text = Langue.getLangue("Game_SELECED_EQUIP_TIPS"); //选择装备
            _selectedAnimation = AnimationCreator.instance.create("effect_012", AssetMgr.instance);
            createBallList();
            setBallListData();
        }

        //物品列表
        private function createBallList():void {
            const layout:TiledRowsLayout = new TiledRowsLayout();
            layout.paddingTop = 5;
            layout.useSquareTiles = false;
            layout.useVirtualLayout = true;
            layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_ball.layout = layout;
            list_ball.itemRendererFactory = listItemRendererFactory;
        }

        private function listItemRendererFactory():BallRender {
            var itemRender:BallRender = new BallRender(_selectedAnimation);
            itemRender.setSize(100, 100);
            return itemRender;
        }

        private function onEquipListChange(e:Event):void {
            var wid:WidgetData = list_ball.selectedItem as WidgetData;
            dispatchEventWith("change", false, wid);
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            list_ball.addEventListener(Event.CHANGE, onEquipListChange);
            this.addViewListener(cancelScale9Button, Event.TRIGGERED, closeHdr);
        }

        private function closeHdr(e:Event):void {
            dispatchEventWith("close");
        }

        public function setBallListData():void {
            var equipDataList:Array = [];
            var widgetArr:Vector.<*> = WidgetData.hash.values();
            var i:int = 0;
            for each (var widget:WidgetData in widgetArr) {
                if (4 == widget.sort && 2 == widget.tab) //宝珠
                {
                    equipDataList[i] = widget;
                    i++;
                }
            }
            equipDataList.sortOn(["quality", "level", "type", "exp"], Array.NUMERIC | Array.DESCENDING);

            var len:int = (equipDataList.length - 9) >= 0 ? 0 : 9 - equipDataList.length;
            for (i = 0; i < len; i++) {
                equipDataList.push(new WidgetData);
            }
            list_ball.dataProvider = new ListCollection(equipDataList);
        }

        override public function dispose():void {
            _selectedAnimation && _selectedAnimation.dispose();
            super.dispose();
        }
    }
}
