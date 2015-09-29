package game.common {
    import com.langue.Langue;
    import com.utils.StringUtil;

    import flash.utils.Dictionary;

    import game.common.render.BuyRender;
    import game.data.Goods;
    import game.data.ShopData;
    import game.manager.AssetMgr;
    import game.net.message.GoodsMessage;
    import game.view.viewBase.JTUIFastBuyBase;

    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;

    /**
     * 快速购买通用框
     * @author CabbageWrom
     *
     */
    public class JTFastBuyComponent extends JTUIFastBuyBase {
        public static const FAST_BUY_MONEY:int = 1;
        public static const FAST_BUY_STAR:int = 3;
        public static const FAST_BUY_HORN:int = 8; //喇叭
        public static const FAST_BUY_SWEEP:int = 12; //扫荡卡
        private var buy_type:int = 0;
        private var _conten:Sprite = null;

        public function JTFastBuyComponent() {
            super();
            clickBackroundClose();
            enableTween = true;
            isVisible = false;
        }

        override protected function init():void {
            var titles:Array = Langue.getLans("starBuyTitle")
            title.text = titles[buy_type - 1];
            back_Scale9Button.text = Langue.getLangue("Next_Time"); //下次再来
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            back_Scale9Button.addEventListener(Event.TRIGGERED, close);
        }

        override protected function show():void {
            setItemProperty(int(_parameter));
            setToCenter();
        }

        private function setItemProperty(type:int):void {
            buy_type = type;
            var i:int = 0;
            var shopHashMap:Dictionary = ShopData.hash.getMap();

            for each (var shopData:ShopData in shopHashMap) {
                if (shopData.type != type) {
                    continue;
                }
                i++;
                var txt_caption:TextField = this["caption_" + i] as TextField;
                var txt_price:TextField = this["price_" + i] as TextField;
                txt_caption.text = (type == FAST_BUY_MONEY ? Langue.getLangue("buyMoney") : Langue.getLangue("buyNumber")) + ": " + StringUtil.changePrice(shopData.count);
                txt_price.text = shopData.count * shopData.cost + "";

                var itemData:Goods = Goods.goods.getValue(type) as Goods;
                if (!itemData.picture) {
                    JTLogger.error("[JTFastBuyComponent.show]Can't Find The Type" + type + "Icon!");
                }
                var texture:Texture = AssetMgr.instance.getTexture(itemData.picture);
                var buyRender:BuyRender;
                _conten = new Sprite();
                addChild(_conten);
                var datas:Array = [{picture: texture}, {picture: texture}, {picture: texture}];
                buyRender = new BuyRender();
                _conten.addQuiackChild(buyRender);
                buyRender.name = "buyRender_" + shopData.id;
                buyRender.x = -76 + (i * 150);
                buyRender.y = 76;
                buyRender.data = datas[i - 1];
                buyRender.addEventListener(Event.TRIGGERED, onSendBuyItem);
            }
        }

        private function onSendBuyItem(e:Event):void {
            var index:int = (e.currentTarget as DisplayObject).name.split("_")[1];
            GoodsMessage.onSendBuyItem(index);
        }

    }
}
