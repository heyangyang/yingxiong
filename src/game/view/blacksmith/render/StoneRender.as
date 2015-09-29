/**
 * Created by Administrator on 2014/10/8 0008.
 */
package game.view.blacksmith.render {
    import game.data.Goods;
    import game.manager.AssetMgr;
    import game.view.uitils.Res;
    import game.view.viewBase.StoneRenderBase;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.events.Event;
    import starling.textures.Texture;

    public class StoneRender extends StoneRenderBase {

        private var selectedAnimation:SpriterClip;
        private var goods:Goods;

        public function StoneRender(sp:SpriterClip) {
            selectedAnimation = sp;
            super();
            init();
        }

        protected function init():void {
            btn_bg.container.addQuiackChild(icon);
            btn_bg.container.addQuiackChild(quality);
            btn_bg.container.addQuiackChild(count);
            btn_bg.addEventListener(Event.TRIGGERED, onTri);
        }

        private function onTri(event:Event):void {
            event.stopImmediatePropagation();
            owner.dispatchEventWith(Event.SELECT, true, data);
        }

        override public function set isSelected(value:Boolean):void {
            super.isSelected = value;
            if (!_isSelected || data == null || (owner && owner.isScrolling))
                return;
            if (_isSelected) {
                if (!this.contains(selectedAnimation)) {
                    selectedAnimation.play("effect_012");
                    selectedAnimation.animation.looping = true;
                    Starling.juggler.add(selectedAnimation);
                    selectedAnimation.x = quality.width / 2;
                    selectedAnimation.y = quality.height / 2;
                    addQuiackChild(selectedAnimation);
                }
            } else {
                if (this.contains(selectedAnimation)) {
                    removeQuickChild(selectedAnimation)
                }
            }
        }

        override public function set data(value:Object):void {
            super.data = value;
            goods = value as Goods;
            selectedAnimation.removeFromParent();
            var texture:Texture;
            if (!goods) {
                texture = Res.instance.getQualityToolTexture(0);
            } else {
                texture = Res.instance.getQualityToolTexture(goods.quality);
            }
            quality.texture = texture;

            var lvStr:String = "";
            if (goods) {
                texture = AssetMgr.instance.getTexture(goods.picture);
                icon.texture = texture;
                lvStr = "×" + goods.pile;
                if (goods.pile == 0) {
                    count.color = 0xff0000;
                } else {
                    count.color = 0x00ff00;
                }
            }
            count.text = lvStr;
        }
    }
}
