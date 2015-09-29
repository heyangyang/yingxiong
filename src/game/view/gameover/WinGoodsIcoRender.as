package game.view.gameover {
    import game.data.Goods;
    import game.view.uitils.Res;
    import game.view.viewBase.WinGoodsIcoRenderBase;

    public class WinGoodsIcoRender extends WinGoodsIcoRenderBase {
        public function WinGoodsIcoRender() {
            super();
            setSize(134, 130);
        }

        override public function set data(value:Object):void {
            super.data = value;
            var goods:Goods = value as Goods;

            if (goods == null) {
                return;
            }
            icon.texture = Res.instance.getGoodIconTexture(goods.type);
            if (goods.type < 100 && goods.type != 5) {
                icon_quality.texture = Res.instance.getQualityToolTexture(goods.quality);
            } else {
                icon_quality.texture = Res.instance.getQualityToolTexture(goods.quality);
            }
            goodsName.text = goods.name + "";
        }
    }
}
