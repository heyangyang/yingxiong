package game.view.heroHall.view
{
    import game.data.HeroData;
    import game.view.heroHall.HeroDialog;

    /**
     * 经验药水
     * @author Samuel
     *
     */
    public class ExperienceView extends EquimentView
    {

        public function ExperienceView()
        {
            super();
        }

        override protected function init():void
        {
            super.init();
            list_equip.visible=false;
            list_exp.visible=true;
            btn_equip.visible=false;
            cion_equip.visible=false;
        }

        override protected function onAutoEquip():void
        {
            super.onAutoEquip();
            (this.mParent as HeroDialog).select(HeroDialog.HERO);
        }

        /**选中更新英雄信息*/
        override public function updata(heroData:HeroData):void
        {
            super.updata(heroData);
        }

    }
}


