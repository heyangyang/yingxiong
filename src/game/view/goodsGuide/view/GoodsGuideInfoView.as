package game.view.goodsGuide.view {
    import com.dialog.DialogMgr;
    import com.langue.Langue;

    import game.data.Goods;
    import game.data.HeroData;
    import game.data.Val;
    import game.data.WidgetData;
    import game.view.magicShop.MagicOrbDia;
    import game.view.viewBase.GoodsGuideInfoViewBase;

    import starling.events.Event;
    import starling.text.TextField;

    /**
     * 物品引导详细信息
     * @author hyy
     *
     */
    public class GoodsGuideInfoView extends GoodsGuideInfoViewBase {
        private var _data:Goods;
        public var curr_data:HeroData;

        public function GoodsGuideInfoView() {
            super();
            bgImage.alpha = 0.5;
            grid.bg.visible = false;
            btnSwallow_Scale9Button.text = Langue.getLans("magicEquipSynthesis")[2];
            btnSwallow_Scale9Button.addEventListener(Event.TRIGGERED, opSwallow);
        }

        public function set data(goods:Goods):void {
            _data = goods;
            grid.isDrak = false;
            grid.data = goods;

            txt_get.text = Langue.getLangue("get_way") + ":  " + Langue.getLangue("checkpoint");
            var tmpArray:Array = Val.MAGICBALL;
            var len:int = tmpArray.length;
            var txt:TextField;
            var key:String;
            var currValue:uint = 0;
            var tmplang:Array = Langue.getLans("ENCHANTING_TYPE");
            var title:TextField;

            for (var i:int = 0; i < len; i++) {
                key = tmpArray[i];
                if (i >= 2) {
                    title = view_equip.getChildByName(key) as TextField;
                    title.text = tmplang[i];
                }
                //当前品质属性值
                currValue = _data[key];
                txt = view_equip.getChildByName("txt_" + key) as TextField;
                txt.text = currValue.toString();
            }

            view_equip.visible = goods.tab == 5;
            txt_des.visible = !view_equip.visible;
            txt_des.text = goods.desc;
            updateBtnStatus();
        }

        public function updateBtnStatus():void {
            if (curr_data) {
                var equip:WidgetData = WidgetData.getCanEquipWidgetByType(_data.type);
                var curr_equip:WidgetData = WidgetData.hash.getValue(curr_data.seat5);
                var btnText:String;

                //背包里面没有此装备
                if ((equip == null && (curr_equip && _data.type != curr_equip.type)) || (equip == null && curr_equip == null)) {
                    btnText = "forge";
                }
                //当前英雄没有装备称号，并且有可以装备的物品
                else if (curr_data.seat5 == 0 && equip && equip.equip == 0) {
                    btnText = "EQUIP";
                        //当前英雄装备了称号，并且有其他称号可以装备
                } else if (curr_data.seat5 > 0 && equip && equip.equip == 0 && equip.type != curr_equip.type) {
                    btnText = "replace";
                } else if (curr_data.seat5 > 0) {
                    btnText = "noreplceNull";
                }
                btnok_Scale9Button.text = Langue.getLangue(btnText);
            } else {
                btnok_Scale9Button.text = Langue.getLangue("SELL");
            }

            if (_data.tab == 2 && _data.sort == 4) {
                btnok_Scale9Button.x = 47;
            } else {
                btnSwallow_Scale9Button.visible = false;
                btnok_Scale9Button.x = 130;
            }
        }

        /**
         *跳转吞噬界面
         * @author lfr
         */
        private function opSwallow():void {
            if (_data.tab == 2 && _data.sort == 4) {
                DialogMgr.instance.open(MagicOrbDia, MagicOrbDia.TUSHI); //宝珠吞噬
            }
        }

        public function get data():Goods {
            return _data;
        }

        override public function dispose():void {
            btnSwallow_Scale9Button.removeEventListener(Event.TRIGGERED, opSwallow);
            super.dispose();
            curr_data = null;
        }

    }
}
