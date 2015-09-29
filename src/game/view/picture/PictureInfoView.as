package game.view.picture {
    import com.langue.Langue;

    import game.data.HeroData;
    import game.data.SkillData;
    import game.manager.AssetMgr;
    import game.view.heroHall.render.HeroCardShow;
    import game.view.viewBase.PictureInfoViewBase;

    import starling.display.Image;
    import starling.text.TextField;

    /**
     * 英雄详细信息
     * @author hyy
     */
    public class PictureInfoView extends PictureInfoViewBase {
        public var heroData:HeroData;
        private var heroShow:HeroCardShow = null;

        public function PictureInfoView() {
            super();
        }

        override protected function init():void {
            enableTween = true;
            //子对象不可点击
            setTouchState(this);
            this.touchable = true;
            //点击关闭界面
            clickBackroundClose();
        }

        override protected function show():void {
            heroData = _parameter as HeroData;
            setToCenter();
        }

        override protected function openTweenComplete():void {
            if (heroShow == null) {
                heroShow = new HeroCardShow();
                heroShow.x = 65;
                heroShow.y = 64;
                this.addQuiackChild(heroShow);
            }
            udpateView();
            heroShow.updata(heroData);
        }

        override public function close():void {
            background.removeFromParent(true);
            super.close();
        }

        private function udpateView():void {
            if (heroData == null) {
                warn("图鉴缺少英雄数据", this);
                return;
            }
            txt_weapon.text = Langue.getLans("Equip_type")[heroData.weapon - 1];
            txt_pos.text = Langue.getLans("hero_job")[heroData.job - 1];
            txt_des.text = heroData.des;
            txt_des1.text = Langue.getLangue("Expert_Location"); //擅长位置
            txt_des2.text = Langue.getLangue("Usual_Weapons"); //惯用武器

            var skillData:SkillData;
            var arr:Array = [];
            for (var i:int = 0; i < 3; i++) {
                skillData = SkillData.getSkill(heroData["skill" + (i + 1)]);
                if (skillData) {
                    arr.push(skillData);
                }
            }

            var image:Image = null;
            var text:TextField = null;
            for (var j:int = 0; j < 3; j++) {
                if (arr[j]) {
                    (this["skill_" + j] as Image).touchable = true;
                    this["txtSkill_" + j].text = arr[j].desc;
                    (this["skill_" + j] as Image).visible = true;
                    (this["skill_" + j] as Image).texture = AssetMgr.instance.getTexture(arr[j].skillIcon);
                } else {
                    (this["skill_" + j] as Image).touchable = false;
                    this["txtSkill_" + j].text = "";
                    (this["skill_" + j] as Image).visible = false;
                }
            }
        }


        /**销毁*/
        override public function dispose():void {
            super.dispose();
            heroData = null;
        }
    }
}
