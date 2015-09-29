package game.view.arena.view {
    import com.dialog.DialogMgr;
    
    import feathers.controls.List;
    import feathers.controls.Scroller;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;
    
    import game.common.JTGlobalDef;
    import game.data.Convert;
    import game.data.Goods;
    import game.data.WidgetData;
    import game.manager.GameMgr;
    import game.managers.JTFunctionManager;
    import game.managers.JTPvpInfoManager;
    import game.managers.JTSingleManager;
    import game.view.arena.ArenaDialog;
    import game.view.arena.ConvertPropsDlg;
    import game.view.arena.render.ConvertItemView;
    import game.view.viewBase.ConvertViewBase;
    
    import starling.events.Event;

    public class ConvertView extends ConvertViewBase {
        /**竞技场数据*/
        private var pvpInfoManager:JTPvpInfoManager;

        public function ConvertView() {
            super();
        }

        override protected function init():void {
            const layout:TiledRowsLayout = new TiledRowsLayout();
            layout.useSquareTiles = false;
            layout.useVirtualLayout = true;
            layout.paddingTop = 10;
            layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            layout.paging = TiledRowsLayout.PAGING_HORIZONTAL;
            list_hero.layout = layout;
            list_hero.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_hero.horizontalScrollPolicy = Scroller.SCROLL_POLICY_ON;
            list_hero.itemRendererFactory = tileListItemRendererFactory;
            list_hero.addEventListener(Event.CHANGE, onSelect);
			JTFunctionManager.registerFunction(JTGlobalDef.PVP_REFRHES_HONOR,updataHonor);
        }

        private function tileListItemRendererFactory():ConvertItemView {
            var itemRender:ConvertItemView = new ConvertItemView();
            itemRender.setSize(175, 205);
            return itemRender;
        }
		
		private function updataHonor(result:Object):void{
			pvpInfoManager = JTSingleManager.instance.pvpInfoManager;
			pvpInfoManager.hornor = GameMgr.instance.honor;
			txtfigthNum.text = pvpInfoManager.hornor.toString();
		}

		override protected function show():void {
            var vect:Vector.<*> = Convert.hash.values();
            var widget:WidgetData;
			
            var list:Array = [];
            for (var i:int = 0; i < vect.length; i++) {
                widget = new WidgetData(Goods.goods.getValue((vect[i] as Convert).id));
                list.push({widget: widget, price: (vect[i] as Convert).price});
            }
            list.sortOn(["price"], Array.NUMERIC);
            list_hero.dataProvider = new ListCollection(list);
            pvpInfoManager = JTSingleManager.instance.pvpInfoManager;
            txtfigthNum.text = pvpInfoManager.hornor.toString();
        }
		

        //兑换物品
        private function onSelect(e:Event):void {
            if (List(e.currentTarget).selectedIndex == -1)
                return;
            (this.parent as ArenaDialog).isVisible = true;
            DialogMgr.instance.open(ConvertPropsDlg, {widget: List(e.currentTarget).selectedItem.widget, money: List(e.currentTarget).selectedItem.price});
            List(e.currentTarget).selectedIndex = -1;
        }
		
		override public function dispose():void{
			JTFunctionManager.removeFunction(JTGlobalDef.PVP_REFRHES_HONOR,updataHonor);
			list_hero.removeFromParent(true);
			super.dispose();
		}
    }
}
