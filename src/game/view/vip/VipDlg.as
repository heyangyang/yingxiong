package game.view.vip {
    import com.langue.Langue;
    import com.mobileLib.utils.DeviceType;
    import com.utils.Constants;
    import com.view.base.event.EventType;

    import feathers.controls.Scroller;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledColumnsLayout;
    import feathers.layout.TiledRowsLayout;

    import game.data.DiamondShopData;
    import game.data.FontJFData;
    import game.data.VipData;
    import game.manager.GameMgr;
    import game.utils.Config;
    import game.view.viewBase.VipDlgBase;

    import starling.display.DisplayObjectContainer;
    import starling.events.Event;

    /**
     * VIP界面
     * @author hyy
     */
    public class VipDlg extends VipDlgBase {
        public static const VIP:int = 0;
        public static const CHARGE:int = 1;
        public static var VipChargeViewClass:Class;

        public function VipDlg() {
            super();
        }

        override protected function init():void {
            _closeButton = btn_close;

            if (Config.Device_Lan == Constants.FT) {
                text_addRecharge.text = Langue.getLans("VIP_add_recharge")[1];
            } else {
                text_addRecharge.text = Langue.getLans("VIP_add_recharge")[0];
            }
            text_Canbecome.text = Langue.getLangue("VIP_Can_become");

            const listLayout:TiledColumnsLayout = new TiledColumnsLayout();
            if (DeviceType.isIOS()) {
                listLayout.gap = 10;
				listLayout.verticalGap = 10;
            } else {
                listLayout.gap = 6;
            }
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            listLayout.paging = TiledColumnsLayout.PAGING_HORIZONTAL; //自动排列
            list_charge.layout = listLayout;
            list_charge.snapToPages = true;
            list_charge.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_charge.itemRendererFactory = itemRendererFactory;

            var arr:Array = [];
            var ta:Array = DiamondShopData.list;
            var len:int = ta.length;
            var j:int = 0;
            for (var i:int = 0; i < len; i++) {
                var diamondShopData:DiamondShopData = ta[i];
                arr[j++] = diamondShopData;
            }
            list_charge.dataProvider = new ListCollection(arr);

            updateVip(null, GameMgr.instance.vipData);
        }

        private function itemRendererFactory():IListItemRenderer {
            const renderer:ChargeRender = new ChargeRender();
            renderer.setSize(284, 109);
            return renderer;
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            if (parameter == VIP) {
                btn_look_Scale9Button.text = FontJFData.changeJtFont(getLangue("look_charge"));
                vipInfo.visible = !(list_charge.visible = false);
            } else {
                btn_look_Scale9Button.text = FontJFData.changeJtFont(getLangue("look_vip"));
                vipInfo.visible = !(list_charge.visible = true);
            }
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            addViewListener(btn_look_Scale9Button, Event.TRIGGERED, onLookClick);
            addContextListener(EventType.UPDATE_VIP, updateVip);
        }

        /**
         * 查看VIP或者充值
         * @param evt
         *
         */
        private function onLookClick():void {
            var isLookVip:Boolean = btn_look_Scale9Button.text == FontJFData.changeJtFont(getLangue("look_charge"));
            if (isLookVip) {
                btn_look_Scale9Button.text = FontJFData.changeJtFont(getLangue("look_vip"));
                vipInfo.visible = !(list_charge.visible = true);
            } else {
                btn_look_Scale9Button.text = FontJFData.changeJtFont(getLangue("look_charge"));
                vipInfo.visible = !(list_charge.visible = false);
            }
        }

        /**
         * 更新VIP等级
         * @param vipLevel
         */
        private function updateVip(evt:Event, vipData:VipData):void {
            var nextVipData:VipData = VipData.list[vipData.id + 1];
            var currVipData:VipData = vipData.baseVip;
            var free:int = vipData.free >= currVipData.free ? currVipData.free : vipData.free;
            diamand.text = nextVipData ? (nextVipData.diamond - vipData.diamond - free) + "" : "N/A";
            txt_currlv.text = vipData.id.toString();
            txt_nextlv.text = nextVipData ? (nextVipData.id).toString() : "";
            exp_curr.width = nextVipData ? (vipData.diamond / nextVipData.diamond * bg.width) : 0;
            exp_curr_txt.text = nextVipData ? vipData.diamond + "/" + nextVipData.diamond : "N/A";
            exp_curr.height = 33;
            if (exp_curr.width > bg.width) {
                exp_curr.width = bg.width;
            }
        }
    }
}
