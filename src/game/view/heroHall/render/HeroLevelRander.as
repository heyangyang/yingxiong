package game.view.heroHall.render {
    import game.manager.AssetMgr;
    import game.view.comm.GraphicsNumber;

    import starling.display.Image;
    import starling.display.Sprite;

    /**
     * 英雄等级显示
     * @author Samuel
     *
     */
    public class HeroLevelRander extends Sprite {
        private var _level:uint = 0;
        private var _titleNum:Image = null;
        private var _lvNum:Sprite = null;

        public function HeroLevelRander() {
            super();
            _titleNum = new Image(AssetMgr.instance.getTexture("ui_dengjishuzi_LV"));
            addChild(_titleNum);
        }

        public function updata(lv:uint):void {
            if (_level == lv) {
                return;
            } else {
                _level = lv;
                if (_lvNum) {
                    _lvNum.removeFromParent(true);
                }
                _lvNum = GraphicsNumber.instance().getNumber(_level + 1, "ui_dengjishuzi_");
                _lvNum.x = _titleNum.width;
                addQuiackChild(_lvNum);
            }
        }

        override public function dispose():void {
            _level = 0;
            _titleNum && _titleNum.dispose();
            _lvNum && _lvNum.dispose();
            super.dispose();
        }
    }
}
