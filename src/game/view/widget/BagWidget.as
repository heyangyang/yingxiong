package game.view.widget {
    import game.data.Goods;
    import game.data.HeroData;
    import game.data.WidgetData;
    import game.manager.AssetMgr;
    import game.view.comm.GraphicsNumber;
    import game.view.uitils.Res;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.textures.Texture;

    /**
     * 物品图标
     * @author Michael
     */
    public class BagWidget extends Widget {
        public var _textFontNumber:TextField;
        private var _num:int;
        private var _textNumber:Sprite;
        private var _widget:WidgetData;
        private var _qualityImage:Image;

        public function BagWidget(widgetData:WidgetData = null, dragable:Boolean = true) {
            _widget = widgetData;
            if (_widget) {
                inits(AssetMgr.instance.getTexture(widgetData.picture), dragable);
            }
        }

        override public function inits(texture:Texture, dragable:Boolean = true):void {
            if (texture) {
                super.inits(texture, dragable);
            }
        }

        public function get widget():WidgetData {
            return _widget;
        }

        public function showQuality():void {
            var texture:Texture = Res.instance.getQualityToolTexture(_widget.quality);
            if (_qualityImage) {
                _qualityImage.texture = texture;
            } else {
                _qualityImage = new Image(texture);
                addChild(_qualityImage);
            }
        }

        //GraphicsNumber的位图数字
        public function setWidgetData(widgetData:Goods):void {
            _widget = widgetData as WidgetData;
            if (widgetData.type > 30000 && widgetData.type < 40000) {
                var hero:HeroData = HeroData.hero.getValue(widgetData.type) as HeroData;
                inits(Res.instance.getHeroIconTexture(hero.show), false);
            } else {
                inits(AssetMgr.instance.getTexture(widgetData.picture), false);
            }

        }

        //文本
        public function WidgetNumber(num:int, x:int = 0, y:int = 0, textureFirstName:String = "ui_shuzi"):void {
            if (_num == num) {
                return;
            }

            _num = num;
            if (_textNumber == null) {
                _textNumber = GraphicsNumber.instance().getNumber(num + 1, textureFirstName);
                parent.addChild(_textNumber);
                _textNumber.x = x;
                _textNumber.y = y;
            }
        }

        public function WidgetNumberToTextField(num:int, x:int = 0, y:int = 0, fontName:String = "myFont", ago:String = "",
                                                size:int = 21, hAlign = "center"):void {
            _num = num;
            if (!_textFontNumber) {
                _textFontNumber = new TextField(85, 32, ago + num, fontName, size, 0xffffff);
                parent.addChild(_textFontNumber);
                _textFontNumber.hAlign = hAlign;
                _textFontNumber.x = x;
                _textFontNumber.y = y;
                _textFontNumber.touchable = false;
            }
        }
    }
}
