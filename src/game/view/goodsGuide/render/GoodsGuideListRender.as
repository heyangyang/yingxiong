package game.view.goodsGuide.render {
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

    import game.data.ForgeData;
    import game.data.Goods;
    import game.data.HeroData;
    import game.data.ShopData;
    import game.data.Val;
    import game.data.WidgetData;
    import game.dialog.ResignDlg;
    import game.manager.AssetMgr;
    import game.net.message.GoodsMessage;
    import game.view.goodsGuide.GoodsEquipOrForgeDlg;
    import game.view.uitils.Res;
    import game.view.viewBase.GoodsGuideListRenderBase;

    import starling.events.Event;
    import starling.filters.ColorMatrixFilter;

    /**
     *掉落物品信息
     * @author Administrator
     */
    public class GoodsGuideListRender extends GoodsGuideListRenderBase {
        public var isDrak:Boolean = true;

        public function GoodsGuideListRender() {
            super();
            ico_equip.visible = hun.visible = tag_selected.visible = diaIcon.visible = btnbuy_Scale9Button.visible = false;
        }

        override public function set data(value:Object):void {
            super.data = value;

            if (value == null) {
                return;
            }
            var goods:Goods = value as Goods;
            var drop_type:String;
            var shopData:ShopData = ShopData.getShopDataByGoodsId(goods.type);
            if (shopData && shopData.buyType == 2) {
                if (!goods.isPack) {
                    diaIcon.visible = btnbuy_Scale9Button.visible = true;
                    btnbuy_Scale9Button.text = int(shopData.cost).toString();
                    btnbuy_Scale9Button.addEventListener(Event.TRIGGERED, buyHandler);
                } else {
                    diaIcon.visible = btnbuy_Scale9Button.visible = false;
                }
            } else {
                diaIcon.visible = btnbuy_Scale9Button.visible = false;
            }

            txt_name.text = goods.name;
            if (goods.sort) {
                txt_sort.text = Langue.getLans("sort")[goods.sort];
            }

            var forgeData:ForgeData = ForgeData.hash.getValue(goods.type);
            if (forgeData) {
                drop_type = "forgeGoods";
            } else if (goods.drop_location == Val.DROP_PVP || goods.drop_location == Val.DROP_PVP_GET) {
                drop_type = "pvp";
            } else if (goods.drop_location) {
                var isFb:Boolean;
                var tmpArr:Array = goods.drop_location.split(",");

                for (var i:int = 0, len:int = tmpArr.length; i < len; i++) {
                    if (int(tmpArr[i]) > 1000)
                        isFb = true;
                }
                drop_type = isFb ? "fb" : "mainLine";
            } else {
                drop_type = "system";
            }

            if (goods.limitLevel > 0) {
                txt_level.text = goods.limitLevel + Langue.getLangue("level");
            }

            if (goods.type > 30000 && goods.type < 40000) {
                var hero:HeroData = HeroData.hero.getValue(goods.type) as HeroData;
                ico_equip.texture = Res.instance.getHeroIconTexture(hero.show);
                hun.visible = true;
            } else {
                ico_equip.texture = AssetMgr.instance.getTexture(goods.picture);
                hun.visible = false;
            }
            ico_equip.visible = true;
            ico_equip.x = ico_quality.x + ((ico_quality.width - ico_equip.width) >> 1);
            ico_equip.y = ico_quality.y + ((ico_quality.height - ico_equip.height) >> 1);


            if (goods.type < 100 && goods.type != 5 || goods.type > 30000 && goods.type < 40000) {
                ico_quality.texture = Res.instance.getQualityToolTexture(0);
                txt_sort.text = "";
            } else {
                ico_quality.texture = Res.instance.getQualityToolTexture(goods.quality);
            }

            if (GoodsEquipOrForgeDlg.curr_hero) {
                txt_level.color = GoodsEquipOrForgeDlg.curr_hero.level >= goods.limitLevel ? 0x00ff00 : 0xff0000;
                var curr_equip:WidgetData = WidgetData.hash.getValue(GoodsEquipOrForgeDlg.curr_hero.seat5);

                if (curr_equip && curr_equip.type == goods.type) {
                    filter = null;
                } else if (isDrak && WidgetData.getCanEquipWidgetByType(goods.type) == null) {
                    filter = new ColorMatrixFilter(Val.filter);
                } else {
                    filter = null;
                }
            }

            if (goods is WidgetData && goods.tab == 5) {
                txt_strengthen.text = goods.level > 0 ? "+" + goods.level : "";
            } else {
                txt_strengthen.text = "";
            }
        }

        private function buyHandler(e:Event):void {
            var tips:ResignDlg = DialogMgr.instance.open(ResignDlg) as ResignDlg;
            var shop:ShopData = ShopData.getShopDataByGoodsId(data.type);
            tips.text = Langue.getLangue("buyshopequip").replace("{0}", shop.cost).replace("{1}", data.name);
            tips.ok_Scale9Button.text = Langue.getLangue("buy");
            tips.close_Scale9Button.text = Langue.getLangue("getup");
            tips.onResign.addOnce(function():void {
                GoodsMessage.onSendBuyItem(shop.id);
            });
        }

        override public function set isSelected(value:Boolean):void {
            super.isSelected = value;
            if (!bg.visible) {
                tag_selected.visible = false;
            } else {
                tag_selected.visible = value;
            }
            if (value) {
                ViewDispatcher.dispatch(EventType.SELECTED_TITLE_GOODS_GUIDE, data);
            }
        }

    }
}
