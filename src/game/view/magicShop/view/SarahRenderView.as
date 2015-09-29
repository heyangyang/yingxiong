package game.view.magicShop.view {
    import game.manager.AssetMgr;
    import game.view.uitils.Res;
    import game.view.viewBase.SarahRenderBase;

    public class SarahRenderView extends SarahRenderBase {

        public function SarahRenderView() {
            super();

            btn_bg.container.addQuiackChild(Icon);
            btn_bg.container.addQuiackChild(goodsValue);
            btn_bg.container.addQuiackChild(Chips);

            _data = new Object();
        }

        override public function get data():Object {
            return _data;
        }

        /**
         * @param value = {icon:{str},moeny:{int},moneyType:{1,2}}
         */
        override public function set data(value:Object):void {
            _data = value;
            if (data == null) {

            } else {
                Icon.texture = AssetMgr.instance.getTexture(_data.icon);
                goodsValue.text = _data.moeny + "";
                Chips.texture = Res.instance.getCommTexture(_data.moneyType);
            }
        }

    }
}
