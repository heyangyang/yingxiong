package game.view.comm {
    import com.dialog.DialogMgr;
    import com.langue.Langue;

    import game.data.HeroData;
    import game.view.heroHall.HeroDialog;
    import game.view.uitils.Res;
    import game.view.viewBase.HeroPriceDialogBase;

    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.text.TextField;

    public class HeroPriceDialog extends HeroPriceDialogBase {
        private var heroData:HeroData = null;
        private var heroType:int = 0; //0 是英雄当前的装备属性值 

        public function HeroPriceDialog() {
            super();
        }

        override protected function init():void {
            enableTween = false;
            clickBackroundClose();
            bgImage0.alpha = bgImage1.alpha = bgImage2.alpha = 0.5;
            var arr:Array = Langue.getLans("ENCHANTING_TYPE");
            defend.text = arr[2];
            hit.text = arr[4];
            crit.text = arr[6];
            anitCrit.text = arr[8];
            puncture.text = arr[3];
            dodge.text = arr[5];
            critPercentage.text = arr[7];
            toughness.text = arr[9];

            (view_evo.getChildByName("text_Title") as TextField).text = Langue.getLangue("advanced_Success");
//            (view_intr.getChildByName("text_expert") as TextField).text = Langue.getLangue("Expert_Location"); //擅长位置
//            (view_intr.getChildByName("text_HabitWeapon") as TextField).text = Langue.getLangue("Usual_Weapons"); //惯用武器
        }

        /**打开*/
        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            super.open(container, parameter, okFun, cancelFun);
            heroData = parameter as HeroData;
            creatUI(heroData);
            setToCenter();
        }

        private function creatUI(heroData:HeroData):void {
//            (view_intr.getChildByName("skillDes") as TextField).text = heroData.des; //英雄的简介
//            (view_intr.getChildByName("text_expertValue") as TextField).text = Langue.getLans("hero_job")[heroData.job - 1];
//            (view_intr.getChildByName("text_HabitWeaponValue") as TextField).text = Langue.getLans("Equip_type")[heroData.weapon - 1];
//            (view_intr.getChildByName("joy") as Image).texture = Res.instance.getJobIconTexture(heroData.job);
            showHeroInfomation();
        }

        /**
         * 英雄属性
         */
        private function showHeroInfomation():void {
            var diag:HeroDialog = DialogMgr.instance.getDlg(HeroDialog) as HeroDialog;
            heroType = diag.currentSelect;
            var tmpArray:Array = heroData.getAttributes();
            //下一品质属性值
            var nextArray:Array = heroData.getNextPurgePropertys(heroData.getUpQuality());
            var len:int = tmpArray.length;
            var txt:TextField;
            var key:String;
            var currValue:uint = 0;
            var nextValue:uint = 0;
            var isUpQuality:Boolean = heroData.isUpQuality();

            for (var i:int = 0; i < len; i++) {
                key = tmpArray[i];
                //当前品质属性值
                currValue = heroData[key];
                nextValue = nextArray[i];
                txt = this[key + "Value"] as TextField;
                txt.text = currValue.toString();
                txt = this[key + "AddValue"] as TextField;
                if (!heroType) {
//                    view_intr.visible = true;
                    view_evo.visible = false;
                    this["add_" + (i + 1)].visible = false;
                    txt.text = "";
                } else {
                    view_evo.visible = true;
//                    view_intr.visible = false;
                    (view_evo.getChildByName("icon") as Image).texture = Res.instance.getHeroIconTexture(heroData.show);
                    (view_evo.getChildByName("icon1") as Image).texture = Res.instance.getHeroIconTexture(heroData.show);

                    if (heroData.isUpQuality()) {
                        (view_evo.getChildByName("quality") as Image).texture = Res.instance.getQualityHeroTexture(heroData.quality);
                        (view_evo.getChildByName("quality1") as Image).texture = Res.instance.getQualityHeroTexture((heroData.quality + 1));
                    }
                    this["add_" + (i + 1)].visible = true;
                    txt.text = "" + nextValue;
                }
            }

        }

    }
}
