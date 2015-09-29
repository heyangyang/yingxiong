package game.view.heroHall {
    import com.langue.Langue;

    import game.data.SkillData;
    import game.manager.AssetMgr;
    import game.view.viewBase.SkillDesDialogBase;

    import starling.display.DisplayObjectContainer;

    public class SkillDesDialog extends SkillDesDialogBase {

        public function SkillDesDialog() {
            super();
        }

        override protected function init():void {
            enableTween = false;
            skillTypeTitle.text = Langue.getLangue("skillInfo_Type"); //技能类型
            skillDesTitle.text = Langue.getLangue("DISC"); //描述
            clickBackroundClose();
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            creatUI(parameter.data as SkillData);
            super.open(container, parameter, okFun, cancelFun);
            this.x = parameter.point.x - this.width + 40;
            this.y = parameter.point.y - this.height + 250;
        }

        protected function creatUI(skill:SkillData):void {
            skilName.text = skill.name;
            skillType.text = skill.skillTypeName;
            icon.upState = AssetMgr.instance.getTexture(skill.skillIcon);
            skillDes.text = skill.desc;
        }

        override public function dispose():void {
            super.dispose();
            while (this.numChildren > 0) {
                this.getChildAt(0).removeFromParent(true);
            }

        }
    }
}
