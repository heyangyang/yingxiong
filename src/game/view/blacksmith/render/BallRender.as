package game.view.blacksmith.render {
    import game.data.Goods;
    import game.manager.AssetMgr;
    import game.view.uitils.Res;
    import game.view.viewBase.BallRenderBase;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.events.Event;

    public class BallRender extends BallRenderBase {
        private var selectedAnimation:SpriterClip;
        private var goods:Goods;

        public function BallRender(sp:SpriterClip) {
            selectedAnimation = sp;
            super();
            init();
        }

        protected function init():void {
            bgBut.container.addQuiackChild(icon);
            bgBut.container.addQuiackChild(quality);
            bgBut.container.addQuiackChild(lv);
            bgBut.addEventListener(Event.TRIGGERED, onTri)
        }

        private function onTri(event:Event):void {
            event.stopImmediatePropagation();
            owner.dispatchEventWith(Event.SELECT, true, data);
        }

        override public function set isSelected(value:Boolean):void {

            if (!value || data == null || data.id == 0 || (owner && owner.isScrolling))
                return;
            if (data.id > 0) {
                if (!this.contains(selectedAnimation)) {
                    selectedAnimation.play("effect_012");
                    selectedAnimation.animation.looping = true;
                    Starling.juggler.add(selectedAnimation);
                    selectedAnimation.x = quality.width / 2;
                    selectedAnimation.y = quality.height / 2;
                    addQuiackChild(selectedAnimation);
                }
            } else {
                removeQuickChild(selectedAnimation);
            }

            this._isSelected = value;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            this.dispatchEventWith(Event.CHANGE);
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (!data) {
                return;
            }
            goods = value as Goods;
            selectedAnimation.removeFromParent();

            if (goods.type < 100 && goods.type != 5) {
                quality.texture = Res.instance.getQualityToolTexture(0);
            } else {
                quality.texture = Res.instance.getQualityToolTexture(goods.quality);
            }

            var lvStr:String = "";
            if (goods.id > 0) {
                icon.texture = AssetMgr.instance.getTexture(goods.picture);
                lvStr = "Lv." + goods.level;
            }
            icon.visible = Boolean(goods.id)
            lv.text = lvStr;
        }
    }
}
