package game.view.shop {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.utils.Constants;
    import com.view.base.event.EventType;

    import feathers.controls.Scroller;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledColumnsLayout;
    import feathers.layout.TiledRowsLayout;

    import game.data.ShopData;
    import game.manager.GameMgr;
    import game.net.message.GoodsMessage;
    import game.utils.Config;
    import game.view.dispark.DisparkControl;
    import game.view.dispark.data.ConfigDisparkStep;
    import game.view.viewBase.ShopDialogBase;
    import game.view.vip.VipDlg;

    import starling.display.DisplayObjectContainer;
    import starling.events.Event;

    /**
     * 商城
     * @author Administrator
     */
    public class ShopDlg extends ShopDialogBase {
        public function ShopDlg() {
            super();
        }

        /**列出按钮*/
        override protected function listTabButton():Array {
            tab_1.text = Langue.getLangue("shop_all");
            tab_2.text = Langue.getLangue("STRENTHEN_STONE");
            tab_3.text = Langue.getLangue("OTHERS");
            return [tab_1, tab_2, tab_3];
        }

        override protected function init():void {
            _closeButton = btn_close;
            if (Config.Device_Lan == Constants.FT) {
                changeScale9Button.text = Langue.getLangue("Recharge"); //储值
            } else {
                changeScale9Button.text = Langue.getLangue("shop_Recharge"); //充值
            }

            const listLayout:TiledRowsLayout = new TiledRowsLayout();
            listLayout.paddingTop = 5;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.verticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listLayout.paging = TiledColumnsLayout.PAGING_HORIZONTAL; //自动排列			
            list_shop.horizontalScrollPolicy = Scroller.SCROLL_POLICY_ON; //横向滚动 
            list_shop.layout = listLayout;
            list_shop.itemRendererFactory = tileListItemRendererFactory;
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            changeScale9Button.addEventListener(Event.TRIGGERED, onChargeButtonClick);
            //选中标签页
            this.addContextListener(EventType.SELECTTAB, onSelectTab);
            list_shop.addEventListener(Event.CHANGE, onSelected);
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
        }

        override public function close():void {
            //智能判断是否删除功能开放提示图标（商城）
            DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep11);
            super.close();
        }

        /**选中标签页*/
        private function onSelectTab(evt:Event = null, index:int = 0):void {
            onTabMenu(index);
        }

        protected function tileListItemRendererFactory():IListItemRenderer {
            var item:ShopItemRender = new ShopItemRender();
            return item as IListItemRenderer;
        }

        private function onSelected(e:Event):void {
            if (list_shop.selectedIndex == -1) {
                return;
            }
            var shop:ShopData = list_shop.selectedItem as ShopData;
            if (GameMgr.instance.diamond < Math.ceil(shop.count * shop.cost)) {
                RollTips.add(Langue.getLangue("diamendNotEnough"));
                list_shop.selectedIndex = -1;
                return;
            }
            GoodsMessage.onSendBuyItem(list_shop.selectedItem.id);
            list_shop.selectedIndex = -1;
        }

        private function onTabMenu(type:int):void {
            if (list_shop == null) {
                return;
            }
            if (type == 0) {
                list_shop.dataProvider = new ListCollection(ShopData.getShopVector(1));
                return;
            }
            if (type == 2)
                type = 3;
            var vector:Vector.<ShopData> = ShopData.getShopVector(1);
            var tmpArr:Vector.<ShopData> = new <ShopData>[];
            var len:int = vector.length;
            var k:int = 0;
            for (var i:int = 0; i < len; i++) {
                var shopData:ShopData = vector[i] as ShopData;
                if (shopData.shopType == (type)) {
                    tmpArr[k++] = shopData;
                }
            }
            const collection:ListCollection = new ListCollection(tmpArr);
            list_shop.dataProvider = collection;
        }

        private function onChargeButtonClick(e:Event):void {
            DialogMgr.instance.open(VipDlg, VipDlg.CHARGE);
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}
