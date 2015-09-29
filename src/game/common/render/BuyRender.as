package game.common.render {
    import game.view.viewBase.BuyRenderBase;

    public class BuyRender extends BuyRenderBase {
        public function BuyRender() {
            super();
            bg.container.addChild(icon);
            bg.container.addChild(quality);
            _data = new Object();
        }

        override public function get data():Object {
            return _data;
        }

        /**
         * @param value = {moeny:{int},moneyType:{1,2,3}}
         */
        override public function set data(value:Object):void {
            _data = value;
            if (data == null) {

            } else {
                icon.texture = _data.picture;
            }
        }
    }
}
