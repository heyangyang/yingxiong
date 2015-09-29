package game.view.pack {
    import com.utils.ObjectUtil;

    import game.base.SelectIcon;
    import game.data.WidgetData;
    import game.manager.AssetMgr;
    import game.view.uitils.Res;
    import game.view.widget.BagWidget;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;

    public class PackGrid extends Sprite {
        private var Icon:BagWidget;
        private var quaityBg:Image;
        private var quaity:Button;
        private var _isOff:Boolean;
        private var _data:Object;
        private var _isSelect:Boolean;
        private var selectIcon:SelectIcon;
        private var hun:Image;

        public function PackGrid(upState:Texture, text:String = "", downState:Texture = null) {
            quaityBg = new Image(AssetMgr.instance.getTexture('ui_daojukuangdi'));
            addQuiackChild(quaityBg);

            Icon = new BagWidget();
            Icon.touchable = false;
            selectIcon = new SelectIcon();
            selectIcon.touchable = false;
            addChild(Icon);

            quaity = new Button(upState, text, downState);
            quaity.downState = null;
            addQuiackChild(quaity);
        }

        public function set data(data:Object):void {
            _data = data;
            hun && hun.removeFromParent(true);
            quaity.downState = null;
            addIcon();
        }

        private function addIcon():void {
            if (Icon._textFontNumber && Icon._textFontNumber.parent) {
                Icon._textFontNumber.removeFromParent();
                Icon._textFontNumber = null;
            }

            if (selectIcon) {
                selectIcon.removeFromParent();
            }

            _isOff = false;
            var widget:WidgetData = _data as WidgetData;
            if (!widget) //如果该物品无数据为空,恢复默认
            {
                while (Icon.numChildren) {
                    Icon.removeChildAt(0);
                }
                quaity.upState = Res.instance.getQualityToolTexture(0);
                return;
            }

            if (widget.type > 30000 && widget.type < 40000 || widget.type < 100 && widget.type != 5) {
                quaity.upState = Res.instance.getQualityToolTexture(0);
            } else {
                quaity.upState = Res.instance.getQualityToolTexture(widget.quality);
            }
            Icon.setWidgetData(widget);

            if (widget.pile != 0 && widget.tab != 5) {
                if (widget.tab == 2 && widget.sort == 4) // 过滤宝珠
                {
                    Icon.WidgetNumberToTextField(widget.level, 10, 60, "", "Lv ", 24, "left");
                } else {
                    Icon.WidgetNumberToTextField(widget.pile, 10, 60, "", "x ", 24, "left");
                    if (widget.type > 30000 && widget.type < 40000) {
                        hun = new Image(AssetMgr.instance.getTexture("ui_yingxionghun_tubiao_02"));
                        Icon.addQuiackChild(hun);
                        hun.x = 57;
                        hun.y = 10;
                        hun.name = "hun";
                        hun.touchable = false;
                    }
                }
            } else if (widget.level > 0) {
                Icon.WidgetNumberToTextField(widget.level, 10, 60, "", "+ ", 24, "left");
            }
            Icon.x = (quaityBg.width - Icon.width) >> 1;
            Icon.y = (quaityBg.height - Icon.height) >> 1;

            if (widget.pile == 0 || widget.tab == 5) {
                ObjectUtil.setToCenter(this.getChildAt(0), Icon);
            }
        }

        public function off():void {
            _isOff = true;
            while (Icon.numChildren) {
                Icon.removeChildAt(0);
            }
            if (Icon._textFontNumber && Icon._textFontNumber.parent) {
                Icon._textFontNumber.removeFromParent();
                Icon._textFontNumber = null;
            }
            quaity.upState = AssetMgr.instance.getTexture("ui_daojukuangsuo"); //没解锁的图片
            ObjectUtil.setToCenter(this.getChildAt(0), Icon);
            quaity.downState = null;
            _data = null;
        }

        public function get data():Object {
            return _data;
        }

        public function get isOff():Boolean {
            return _isOff;
        }

        public function select():void {
            if (!_isSelect) {
                addSelect();
                _isSelect = true;
            } else {
                selectIcon.removeFromParent();
                _isSelect = false;
            }
        }

        public function onSelect():void {
            selectIcon.removeFromParent();
            _isSelect = false;
        }

        private function addSelect():void {
            addChild(selectIcon);
            ObjectUtil.setToCenter(this.getChildAt(0), selectIcon);
        }

        public function get isSelect():Boolean {
            return _isSelect;
        }
    }
}
