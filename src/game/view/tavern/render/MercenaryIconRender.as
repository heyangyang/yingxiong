package game.view.tavern.render {
    import com.langue.Langue;

    import feathers.dragDrop.IDragSource;

    import game.common.JTLogger;
    import game.data.HeroData;
    import game.data.MercenaryData;
    import game.view.heroHall.render.StarBarRender;
    import game.view.uitils.Res;
    import game.view.viewBase.MercenaryIconBase;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.display.Sprite;

    /**
     * 佣兵头像render
     * @author Samuel
     */
    public class MercenaryIconRender extends MercenaryIconBase implements IDragSource {
        private var img_level:Sprite;
        private var selectedAnimation:SpriterClip;
        private var star:StarBarRender;

        public function MercenaryIconRender(animation:SpriterClip = null) {
            super();
            selectedAnimation = animation;
        }

        /**设置data数据，生成UI*/
        override public function set data(value:Object):void {
            super.data = MercenaryData.hash.getValue(value.id) as MercenaryData;
            var arr:Array = Langue.getLans("Mercenary_Icon_Value");
            switch (value.state) {
                case 0: //可以购买 
                    txt_1.visible = false;
                    txt_2.text = arr[0];
                    txt_2.color = 0x30D8F1;
                    lockImage.visible = false;
                    break;
                case 1: //未解锁
                    txt_1.visible = true;
                    txt_2.visible = false;
                    lockImage.visible = true;
                    break;
                case 2: //已经购买
                    txt_1.visible = false;
                    txt_2.text = arr[1];
                    txt_2.color = 0x00FF00;
                    lockImage.visible = false;
                    break;
                default:
                    txt_1.visible = false;
                    txt_2.visible = true;
                    lockImage.visible = true;
                    JTLogger.debug("程序异常");
                    break;
            }
            txt_1.text = data.pointID + arr[2];
            txt_3.visible = false;
            var heroData:HeroData = HeroData.hero.getValue(data.heroID);
            imageIcon.texture = Res.instance.getHeroIconTexture(heroData.show);
            qualitybg.texture = Res.instance.getQualityHeroTexture(data.quality);

            but_bg.container.addChild(imageIcon);
            but_bg.container.addChild(qualitybg);
            but_bg.container.addChild(lockImage);
            but_bg.container.addChild(txt_1);
            but_bg.container.addChild(txt_2);
            but_bg.container.addChild(txt_3);

            if (data.star > 0) {
                if (star == null) {
                    star = new StarBarRender();
                    star.updataStar(data.star, 0.9);
                    addQuiackChild(star);
                    star.x = (qualitybg.width - star.width) >> 1;
                    star.y = qualitybg.height - star.height - 6;
                } else {
                    star.updataStar(data.star, 0.9);
                    star.x = (qualitybg.width - star.width) >> 1;
                    star.y = qualitybg.height - star.height - 6;
                }
                but_bg.container.addQuiackChild(star);
            }
        }

        /**选中*/
        override public function set isSelected(value:Boolean):void {
            super.isSelected = value;
            if (!value || data == null || data.id == 0 || (owner && owner.isScrolling))
                return;

            if (data.id > 0) {
                selectedAnimation.play("effect_012");
                selectedAnimation.animation.looping = true;
                Starling.juggler.add(selectedAnimation);
                selectedAnimation.x = this.qualitybg.width >> 1;
                selectedAnimation.y = this.qualitybg.height >> 1;
                addChild(selectedAnimation);
            } else {
                isSelected = false;
            }
        }

        /**销毁*/
        override public function dispose():void {
            super.dispose();
            img_level && img_level.dispose();
            star && star.removeFromParent(true);
            img_level = null;
            star = null;
            selectedAnimation = null;
        }
    }
}



