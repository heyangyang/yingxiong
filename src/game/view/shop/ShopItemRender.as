package game.view.shop {
    import com.langue.Langue;

    import game.data.ShopData;
    import game.manager.AssetMgr;
    import game.view.uitils.Res;
    import game.view.viewBase.ShopItemBase;

    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;

    import starling.events.Event;

    public class ShopItemRender extends ShopItemBase {
        public var onBuy:ISignal = new Signal(ShopData);
        private var _shopData:ShopData;

        public function ShopItemRender() {
            super();
            buy_Scale9Button.text = Langue.getLangue("buy");
            setSize(246, 421);
            icon.visible = false;
        }

        override public function set data(value:Object):void {
            _shopData = value as ShopData;
            if (!_shopData) {
                return;
            }

            goodsName.text = _shopData.name;
            var num:int = Math.ceil(_shopData.count * _shopData.cost);
            costValue.text = num + "";
            icon.visible = true;
            icon.texture = AssetMgr.instance.getTexture(_shopData.picture);
//            var quality:int = _shopData.quality - 1;
//            quality < 0 ? quality = 1 : quality;
            if (_shopData.type > 30000 && _shopData.type < 40000 || _shopData.type < 100 && _shopData.type != 5) {
                goods_quality.texture = Res.instance.getQualityToolTexture(0);
            } else {
                goods_quality.texture = Res.instance.getQualityToolTexture(_shopData.quality);
            }

            count.text = "× " + _shopData.count;
            super.data = value;
        }

        override public function dispose():void {
            onBuy.removeAll();
            super.dispose();
        }

        private function onBuyButton(event:Event):void {
            onBuy.dispatch(_shopData);
        }
    }
}
