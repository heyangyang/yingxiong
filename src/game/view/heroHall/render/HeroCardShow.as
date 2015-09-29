package game.view.heroHall.render {
    import game.data.HeroData;
    import game.manager.AssetMgr;
    import game.view.hero.HeroShow;
    import game.view.uitils.Res;
    import game.view.viewBase.HeroCardShowBase;

    import starling.display.Image;

    /**
     * 英雄展示卡
     * @author Samuel
     *
     */
    public class HeroCardShow extends HeroCardShowBase {
        private var _heroData:HeroData = null;
        private var _hero:HeroShow = null;
        private var _showLook:Boolean = false;
        public var setHeroX:int; //用于放特效在英雄的脚下
        public var setHeroY:int;

        public function HeroCardShow(look:Boolean = false) {
            _showLook = look;
            super();
        }

        public function get hero():HeroShow {
            return _hero;
        }

        public function set hero(value:HeroShow):void {
            _hero = value;
        }

        override protected function init():void {
            heroCard.texture = AssetMgr.instance.getTexture("ui_renwukapai_01");
            heroCard.touchable = true;
            _hero = new HeroShow();
            setHeroX = _hero.x = 106;
            setHeroY = _hero.y = 210;
            addQuiackChild(_hero);
        }

        public function updataStar(value:uint, scale:Number = 1):void {
            var star:Image = null;
            var i:int = 0;
            for (i = 0; i < 5; i++) {
                star = this["star_" + i] as Image;
                if (i < value && value != 0) {
                    star.texture = AssetMgr.instance.getTexture("ui_xingyunxing01_tubiao");
                } else {
                    star.texture = AssetMgr.instance.getTexture("ui_xingyunxing02_tubiao");
                }
            }
        }

        public function updata(heroData:HeroData):void {
            if (heroData == null) {
                heroCard.texture = AssetMgr.instance.getTexture("ui_renwukapai_01");
                _hero.updateHero(null);
                star_0.visible = star_1.visible = star_2.visible = star_3.visible = star_4.visible = false;
                heroName.text = "";
                job.visible = false;
            } else {
                _heroData = heroData;
                _hero.updateHero(heroData, _showLook);
                heroCard.texture = Res.instance.getCardIconTexture(heroData.quality);
                var jie:int = getCardjie(heroData);
                var str:String = "";
                if (jie > 0) {
                    str = '<font  fac = "myFont" color="#FFFFFF">' + _heroData.name + "</font>" + '<font color="#FF00FF"> +' + jie + '</font>';
                } else {
                    str = '<font  fac = "myFont" color="#FFFFFF">' + _heroData.name + "</font>";
                }
                heroName.htmlText = str;
                job.visible = true;
                job.texture = Res.instance.getJobIconTexture(heroData.job);
                star_0.visible = star_1.visible = star_2.visible = star_3.visible = star_4.visible = true;
            }
        }

        public static function getCardjie(heroData:HeroData):int {
            var jie:int = 0;
            if (heroData && heroData.quality > 0) {
                if (heroData.quality >= 11) {
                    jie = heroData.quality - 11;
                } else if (heroData.quality >= 7) {
                    jie = heroData.quality - 7;
                } else if (heroData.quality >= 4) {
                    jie = heroData.quality - 4;
                } else if (heroData.quality >= 2) {
                    jie = heroData.quality - 2;
                } else if (heroData.quality >= 1) {
                    jie = heroData.quality - 1;
                }
            }
            return jie;
        }


        override public function dispose():void {
            _heroData = null;
            _hero.removeFromParent(true);
            _hero = null;
            super.dispose();
        }
    }
}
