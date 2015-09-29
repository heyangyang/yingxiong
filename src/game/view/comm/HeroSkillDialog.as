package game.view.comm {
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    
    import flash.geom.Point;
    
    import game.data.HeroData;
    import game.data.SkillData;
    import game.manager.AssetMgr;
    import game.view.heroHall.SkillDesDialog;
    import game.view.uitils.Res;
    import game.view.viewBase.HeroSkillsBase;
    
    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;

    public class HeroSkillDialog extends HeroSkillsBase {
        private var heroData:HeroData = null;

        public function HeroSkillDialog() {
            super();
        }

        override protected function init():void {
            enableTween = true;
            clickBackroundClose();
        }

        /**打开*/
        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            super.open(container, parameter, okFun, cancelFun);
            heroData = parameter as HeroData;
            creatUI(heroData);
            setToCenter();
        }

        private function creatUI(heroData:HeroData):void {
            heroIcon.texture = Res.instance.getHeroIconTexture(heroData.show);
            text_heroName.text = heroData.name;
            text_expert.text = Langue.getLangue("Expert_Location"); //擅长位置
            text_expertValue.text = Langue.getLans("hero_job")[heroData.job - 1];
            text_HabitWeapon.text = Langue.getLangue("Usual_Weapons"); //惯用武器
            text_HabitWeaponValue.text = Langue.getLans("Equip_type")[heroData.weapon - 1];
            text_heroInfo.text = heroData.des;

            var skillData:SkillData;
            var icon:Button = null;
            var textSkill:TextField;
            var arr:Array = [];
            var arrSkill:Array = [];
            for (var i:int = 0; i < 3; i++) {
                skillData = SkillData.getSkill(heroData["skill" + (i + 1)]);
                icon = this["heroSkill_" + i] as Button;
                textSkill = this["textSkill_" + i] as TextField;
                icon.touchable = true;
                if (skillData) {
                    icon.visible = true;
                    icon.upState = AssetMgr.instance.getTexture(skillData.skillIcon);
                    textSkill.text = skillData.name;
                    icon.addEventListener(TouchEvent.TOUCH, touchHandler);
                    quality.texture = Res.instance.getQualityHeroTexture(heroData.quality);
                    jobIcon.texture = Res.instance.getJobIconTexture(heroData.job);
                    arr.push(icon);
                    arrSkill.push(textSkill);
                } else {
                    icon.visible = false;
                }
            }

            if (arr.length == 1) {
                icon = arr[0] as Button;
                textSkill = arrSkill[0] as TextField;
                icon.y = 178;
                textSkill.y = 185;
            } else if (arr.length == 2) {
                icon = arr[0] as Button;
                textSkill = arrSkill[0] as TextField;
                icon.y = 143;
                textSkill.y = 150;
                icon = arr[1] as Button;
                textSkill = arrSkill[1] as TextField;
                icon.y = 211;
                textSkill.y = 218;
            } else if (arr.length == 3) {
                icon = arr[0] as Button;
                textSkill = arrSkill[0] as TextField;
                icon.y = 129;
                textSkill.y = 136;
                icon = arr[1] as Button;
                textSkill = arrSkill[1] as TextField;
                icon.y = 178;
                textSkill.y = 185;
                icon = arr[2] as Button;
                textSkill = arrSkill[2] as TextField;
                icon.y = 227;
                textSkill.y = 234;
            }
        }

        /**
         *点击英雄的技能 查看信息
         * @param e TouchEvent
         */
        private function touchHandler(e:TouchEvent):void {
            var index:uint = uint((e.currentTarget as DisplayObject).name.split("_")[1]) + 1;
            var touch:Touch = e.getTouch(this);
            if (touch == null) {
                return;
            }
            var skillData:SkillData = SkillData.getSkill(heroData["skill" + index]);
            var p:Point = touch.getLocation(this);
            p = new Point(p.x, p.y);
            switch (touch && touch.phase) {
                case TouchPhase.BEGAN:
                    isVisible = true;
                    DialogMgr.instance.open(SkillDesDialog, {data: skillData, point: p});
                    break;
                case TouchPhase.ENDED:
                    DialogMgr.instance.closeDialog(SkillDesDialog);
                    break;
                default:
                    break;
            }
        }

        /**销毁*/
        override public function dispose():void {
            for (var i:int = 0; i < 3; ++i) {
                this["heroSkill_" + i].removeEventListener(TouchEvent.TOUCH, touchHandler);
            }

            while (this.numChildren > 0) {
                this.getChildAt(0).removeFromParent(true);
            }

            heroData = null;
        }
    }
}
