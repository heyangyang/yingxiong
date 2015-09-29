/**
 * Created by Administrator on 2014/9/17 0017.
 */
package game.view.blacksmith.render {
    import com.langue.Langue;

    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.data.Goods;
    import game.data.StrenthenRateData;
    import game.data.WidgetData;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.view.viewBase.StonePaneBase;

    import spriter.SpriterClip;

    import starling.display.Button;
    import starling.events.Event;

    /**
     *强化石界面
     * @author Administrator
     *
     */
    public class StonePane extends StonePaneBase {
        private var stoneList:Array;
        private var _selectedAnimation:SpriterClip;

        public function StonePane() {
            super();
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            list_stone.addEventListener(Event.CHANGE, onEquipListChange);
            this.addViewListener(cancelScale9Button, Event.TRIGGERED, closeHdr);
        }

        //物品列表
        private function createBallList():void {
            const layout:TiledRowsLayout = new TiledRowsLayout();
            layout.paddingTop = 5;
            layout.horizontalGap = 5;
            layout.useSquareTiles = false;
            layout.useVirtualLayout = true;
            layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_stone.layout = layout;
            list_stone.itemRendererFactory = listItemRendererFactory;
        }

        override protected function addToStageHandler(evt:Event):void {
            super.addToStageHandler(evt);
            this.addViewListener(cancelScale9Button, Event.TRIGGERED, closeHdr);
        }

        private function listItemRendererFactory():StoneRender {
            var itemRender:StoneRender = new StoneRender(_selectedAnimation);
            itemRender.setSize(100, 100);
            return itemRender;
        }

        override protected function show():void {
            title.text = Langue.getLangue("BAOZHU");
            cancelScale9Button.text = Langue.getLangue("Game_SELECED_EQUIP_TIPS"); //选择装备
            title.text = Langue.getLangue("STRENTHEN_STONE");
            _selectedAnimation = AnimationCreator.instance.create("effect_012", AssetMgr.instance);
            updata();
        }

        public function updata():void {
            createBallList();
            stoneList = getBalls();
            list_stone.dataProvider = new ListCollection(stoneList);
        }

        private function onSelectedStone(event:Event):void {
            dispatchEventWith("selectedStone", false, stoneList[int((event.currentTarget as Button).name)])
        }

        private function getBalls():Array {
            var stoneList:Vector.<StrenthenRateData> = StrenthenRateData.stoneList
            var len:int = stoneList.length;
            var return_list:Array = [];
            var strengthenData:StrenthenRateData;
            var goods:Goods;

            for (var i:int = 0; i < len; i++) {
                strengthenData = stoneList[i];
                goods = Goods.goods.getValue(strengthenData.stone);
                if (goods == null) {
                    warn("强化界面找不到物品", strengthenData.stone);
                    continue;
                }
                goods = goods.clone() as Goods;
                goods.pile = WidgetData.pileByType(goods.type);
                return_list.push(goods);
            }
            return return_list;
        }

        private function onEquipListChange(e:Event):void {
            var goods:Goods = list_stone.selectedItem as Goods;
            dispatchEventWith("change", goods);
        }

        private function closeHdr(e:Event):void {
            dispatchEventWith("closeStonePane");
        }

        override public function dispose():void {
            _selectedAnimation && _selectedAnimation.dispose();
            super.dispose();
        }
    }
}
