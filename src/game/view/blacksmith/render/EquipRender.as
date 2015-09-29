package game.view.blacksmith.render {
    import feathers.controls.renderers.DefaultListItemRenderer;

    import game.data.Goods;
    import game.data.WidgetData;
    import game.manager.AssetMgr;
    import game.view.uitils.Res;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.Image;
    import starling.text.TextField;

    public class EquipRender extends DefaultListItemRenderer {
        private var bgBut:Button;
        private var ico_quality:Image;
        private var ico_equip:Image;
        private var goods:Goods;
        private var selectedAnimation:SpriterClip;
        private var txt:TextField;

        public function EquipRender(sp:SpriterClip) {
            selectedAnimation = sp;

            txt = new TextField(75, 28, '', '', 24, 0x00FF00, false);
            txt.touchable = false;
            txt.hAlign = 'right';
            txt.text = '';
            txt.x = 10;
            txt.y = 62;

            bgBut = new Button(AssetMgr.instance.getTexture("ui_daojukuangdi"));
            addQuiackChild(bgBut);
            ico_quality = new Image(Res.instance.getQualityToolTexture(0));
            addQuiackChild(ico_quality);
            ico_equip = new Image(Res.instance.getQualityToolTexture(0));
            ico_equip.touchable = false;
            ico_equip.width = ico_equip.height = 80;
            ico_equip.x = (bgBut.container.width - ico_equip.width) * 0.5;
            ico_equip.y = (bgBut.container.height - ico_equip.height) * 0.5;
            bgBut.container.addQuiackChild(ico_quality);
            bgBut.container.addQuiackChild(ico_equip);
            bgBut.container.addQuiackChild(txt);
        }

        override public function set isSelected(value:Boolean):void {
            super.isSelected = value;
            if (!value || data == null || data.id == 0 || (owner && owner.isScrolling)) {
                return;
            }

            if (data.id > 0) {
                if (!this.contains(selectedAnimation)) {
                    selectedAnimation.play("effect_012");
                    selectedAnimation.animation.looping = true;
                    Starling.juggler.add(selectedAnimation);
                    selectedAnimation.x = ico_quality.width / 2;
                    selectedAnimation.y = ico_quality.height / 2;
                    addQuiackChild(selectedAnimation);
                }
            } else {
                removeQuickChild(selectedAnimation);
                _isSelected = false;
            }
        }

        override public function set data(value:Object):void {
            super.data = value;
            goods = value as Goods;
            selectedAnimation.removeFromParent();
            if (goods) {
                if (goods.id == 0) {
                    ico_quality.texture = Res.instance.getQualityToolTexture(0);
                    ico_equip.visible = false;
                } else {
                    ico_equip.texture = AssetMgr.instance.getTexture(goods.picture);
                    ico_quality.texture = Res.instance.getQualityToolTexture(goods.quality);
                    ico_equip.visible = true;
					if (data.id > 0&&_isSelected) {
						if (!this.contains(selectedAnimation)) {
							selectedAnimation.play("effect_012");
							selectedAnimation.animation.looping = true;
							Starling.juggler.add(selectedAnimation);
							selectedAnimation.x = ico_quality.width / 2;
							selectedAnimation.y = ico_quality.height / 2;
							addQuiackChild(selectedAnimation);
						}
					}
                }
                if ((goods as WidgetData).level > 0) {
                    txt.text = "+" + (goods as WidgetData).level;
                } else {
                    txt.text = "";
                }
            } else {
                txt.text = "";
            }
        }
    }
}
