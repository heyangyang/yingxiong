package game.view.magicShop.render {
    import game.data.Goods;
    import game.manager.AssetMgr;
    import game.view.magicShop.data.GetMagicOrbs;
    import game.view.magicShop.data.RockTween;
    import game.view.uitils.Res;
    import game.view.viewBase.MagicRenderBase;

    import starling.core.Starling;
    import starling.events.Event;

    public class MagicRender extends MagicRenderBase {
        private var _rockTween:RockTween;
        protected var getMagicOrbs:GetMagicOrbs;

        public function MagicRender() {
            super();

            init();
        }

        private function init():void {
            _picture.visible = false;
            _selectedImage.visible = false;
            but_bg.container.addChild(_picture);
            but_bg.container.addChild(_quality);
            but_bg.container.addChild(_selectedImage);
            but_bg.container.addChild(txt_Lv);
            but_bg.addEventListener(Event.TRIGGERED, selected);
        }

        override public function set data(value:Object):void {
            super.data = value;
            _selectedImage.visible = false;
            _picture.visible = false;
            if (value == null) {
                return;
            }
            getMagicOrbs = value as GetMagicOrbs;
            if (getMagicOrbs.type == 0) {
                _quality.texture = Res.instance.getQualityToolTexture(0);
                txt_Lv.text = "";
            } else {
                var goods:Goods = Goods.goods.getValue(getMagicOrbs.type);
                _picture.texture = AssetMgr.instance.getTexture(goods.picture);
                _quality.texture = Res.instance.getQualityToolTexture(goods.quality); //背景框品质颜色
                txt_Lv.text = "Lv " + getMagicOrbs.level;
                _picture.visible = true;
            }
            if (getMagicOrbs.rock) {
                startRock();
            } else {
                stopRock();
            }
            _selectedImage.visible = getMagicOrbs.selected;
        }

        protected function selected(e:Event):void {
            if (!owner.isScrolling && getMagicOrbs.type > 0) {
                getMagicOrbs.selected = !getMagicOrbs.selected;
                _selectedImage.visible = getMagicOrbs.selected;
            }
        }

        public function startRock():void {
            if (!_rockTween) {
                _rockTween = new RockTween(but_bg, false);
            }
            Starling.juggler.removeTweens(but_bg);
            _rockTween.rightRotation();
        }

        public function stopRock():void {
            if (_rockTween) {
                _rockTween.stop();
            }
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}

