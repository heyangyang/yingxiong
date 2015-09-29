package game.view.tavern.view {
    import com.components.RollTips;
    import com.components.Scale9Button;
    import com.data.HashMap;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.mvc.interfaces.INotification;

    import game.data.ConfigData;
    import game.data.HeroData;
    import game.data.HeroPriceData;
    import game.data.IconData;
    import game.data.RoleShow;
    import game.data.Val;
    import game.dialog.ResignDlg;
    import game.dialog.ShowLoader;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.manager.HeroDataMgr;
    import game.net.data.IData;
    import game.net.data.c.CBuyhero;
    import game.net.data.c.CSearchhero;
    import game.net.data.s.SBuyhero;
    import game.net.data.s.SSearchhero;
    import game.net.data.vo.TavernHeroVo;
    import game.net.message.base.Message;
    import game.view.comm.GetGoodsAwardEffectDia;
    import game.view.comm.HeroSkillDialog;
    import game.view.heroHall.render.HeroCardShow;
    import game.view.heroHall.render.StarBarRender;
    import game.view.tavern.TavernDialog;
    import game.view.tavern.data.TavernData;
    import game.view.uitils.Res;
    import game.view.viewBase.ExtractViewBase;

    import sdk.DataEyeManger;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.filters.ColorMatrixFilter;

    /**
     *酒馆界面
     * @author lfr
     *
     */
    public class ExtractView extends ExtractViewBase {
        private var data:TavernData = TavernData.instance; //酒馆数据
        private var buy_hero_money:int; //刷新英雄请求
        private var qualtiy:uint = 0;
        private var heroVotype:TavernHeroVo = null;
        private var index:uint = 0;
        private var effs:HashMap = new HashMap();

        public function ExtractView() {
            super();
        }

        override protected function show():void {
            createHero();
            data.fushData1.startTime();
            if (!data.fushData1.isSend) { //如果没有请求过
                var cmd:CSearchhero = new CSearchhero();
                cmd.type = 0;
                Message.sendMessage(cmd);
            } else { //请求过，直接显示 
                Starling.juggler.delayCall(updata, 0.5);
                cdTime();
            }
        }

        private function createHero():void {
            var heroShow:HeroCardShow = null;
//            var starBar:StarBarRender = null;
            for (var i:int = 0; i < 3; i++) {
                heroShow = new HeroCardShow(false);
                heroShow.name = "heroShow_" + i;
                heroShow.x = 258 * i + 187;
                heroShow.y = 90;
                addQuiackChild(heroShow);

//                starBar = new StarBarRender();
//                starBar.name = "starBar_" + i;
//                starBar.x = 258 * i + 235;
//                starBar.y = 100;
//                starBar.updataStar(0, 0.8, 3);
//                addChild(starBar);
            }
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            btn_Refresh.addEventListener(Event.TRIGGERED, onRefresh);
        }

        /**刷新*/
        private function onRefresh(e:Event = null):void {
            if (data.fushData1.time > 0) {
                (this.parent as TavernDialog).isVisible = true;
                var tip:ResignDlg = DialogMgr.instance.open(ResignDlg) as ResignDlg;
                buy_hero_money = Math.ceil((data.fushData1.time / 60) * ConfigData.instance.diamond_per_min);
                tip.text = Langue.getLangue("tavernBuy").replace("*", buy_hero_money);
                tip.ok_Scale9Button.addEventListener(Event.TRIGGERED, function():void {
                    if (GameMgr.instance.diamond < Math.ceil((data.fushData1.time / 60) * ConfigData.instance.diamond_per_min)) {
                        RollTips.add(Langue.getLangue("diamendNotEnough")); //钻石不足
                    } else {
                        var cmd:CSearchhero = new CSearchhero();
                        cmd.type = 1;
                        Message.sendMessage(cmd);
                    }
                });
            } else {
                var cmd:CSearchhero = new CSearchhero();
                cmd.type = 1;
                Message.sendMessage(cmd);
            }
        }

        override public function listNotificationName():Vector.<String> {
            var vect:Vector.<String> = new Vector.<String>;
            vect.push(SSearchhero.CMD, SBuyhero.CMD);
            return vect;
        }

        /**刷新返回数据*/
        override public function handleNotification(_arg1:INotification):void {
            //刷新酒馆
            if (_arg1.getName() == String(SSearchhero.CMD)) {
                var searchhero:SSearchhero = _arg1 as SSearchhero;
                if (searchhero.code == 0 || searchhero.code == 3) //刷新英雄成功
                {
                    DataEyeManger.instance.buyItem(DataEyeManger.FLUSH_HERO, buy_hero_money, 1, DataEyeManger.FLUSH_HERO);
                    data.fushData1.time = searchhero.cd;
                    data.heroList = searchhero.heroes;
                    data.fushData1.isSend = true;
                    updata();
                    cdTime();
                } else if (searchhero.code == 1) {
                    RollTips.add(Langue.getLangue("notEnoughCoin")); //金币不足
                } else if (searchhero.code == 2) {
                    RollTips.add(Langue.getLangue("diamendNotEnough")); //钻石不足
                }
            } else if (_arg1.getName() == String(SBuyhero.CMD)) {
                var sbuyhero:SBuyhero = _arg1 as SBuyhero;
                var dataVector:Vector.<IconData> = new Vector.<IconData>;
                var iconData:IconData = null;
                var heroData:HeroData = HeroData.hero.getValue(heroVotype.type);
                if (0 == sbuyhero.code) {
                    iconData = new IconData();
                    iconData.QualityTrue = Res.instance.getQualityHeroTextures(heroVotype.quality);
                    iconData.IconTrue = (RoleShow.hash.getValue(heroData.show) as RoleShow).photo;
                    iconData.Num = "Lv " + 1;
                    iconData.IconType = heroData.type;
                    iconData.IconId = heroData.type;
                    iconData.Name = heroData.name;
                    iconData.hunModel = false;
                    dataVector.push(iconData);
                    DialogMgr.instance.isVisibleDialogs(true);
                    var effectData:Object = {vector: dataVector, effectPoint: null, effectName: "effect_037", effectSound: "effect_037",
                            effectFrame: 854};
                    DialogMgr.instance.open(GetGoodsAwardEffectDia, effectData, null, null, "translucence", 0x000000, 0.5);
//                    RollTips.add(Langue.getLangue("buySuccess")); //购买成功 

                    //购买到的英雄就删除其下对应的数组下标
                    var arr:Vector.<IData> = data.heroList;
                    var len:uint = arr == null ? 0 : arr.length;
                    var info:TavernHeroVo = null;
                    for (var i:int = 0; i < len; i++) {
                        info = arr[i] as TavernHeroVo;
                        if (info.id == heroVotype.id) {
                            arr.splice(i, 1);
                            break;
                        }
                    }
                    updata();
                } else if (1 == sbuyhero.code) {
                    RollTips.add(Langue.getLangue("notEnoughCoin")); //金币不足 
                } else if (2 == sbuyhero.code) {
                    RollTips.add(Langue.getLangue("diamendNotEnough")); //钻石不足
                } else if (3 == sbuyhero.code) {
                    RollTips.add(Langue.getLangue("MaxHero")); //英雄格子数不足
                } else if (127 == sbuyhero.code) {
                    RollTips.add(Langue.getLangue("alreadyBuy"));
                }
            }
            ShowLoader.remove();
        }

        //显示英雄
        public function updata():void {
            var info:TavernHeroVo = null;
            var heroPriceData:HeroPriceData = null;
            var heroData:HeroData = null;
            var heroShow:HeroCardShow = null;
            var starBar:StarBarRender = null;
            var arr:Vector.<IData> = data.heroList;
            var len:int = arr.length;
            var cindex:uint = 0;
            var buyBtn:Scale9Button = null;
            var diaIcon:Image = null;
            for (var i:int = 0; i < 3; i++) {
                heroShow = getChildByName("heroShow_" + i) as HeroCardShow;
//                starBar = getChildByName("starBar_" + i) as StarBarRender;
                buyBtn = this["buyHero" + i + "_Scale9Button"] as Scale9Button;
                buyBtn.name = "buyHero_" + i;
                diaIcon = this["diaIcon_" + i] as Image;
                info = getTavneInfoByIndex(arr, i + 1);
                if (info != null) {
                    cindex++;

                    heroData = HeroData.hero.getValue(info.type);
                    heroData.quality = info.quality;
                    heroData.level = 1;
                    heroShow.visible = true;
                    heroShow.updata(heroData);
                    heroShow.updataStar(info.star);
                    trace(this, "英雄的星阶--111---= " + info.star);

                    qualtiy = info.quality - 1;
                    heroPriceData = HeroPriceData.hash.getValue(info.ravity + "" + info.quality);
                    if (buyBtn) {
                        buyBtn.text = (TavernData.AddPrice[info.star] + heroPriceData.price).toString();
                    } else {
                        buyBtn.text = "";
                    }
                    buyBtn.touchable = true;
                    buyBtn.addEventListener(Event.TRIGGERED, onBuy); //请求购买英雄的按钮

                    diaIcon.visible = true;
                    if (heroPriceData.type == 2) {
                        diaIcon.texture = AssetMgr.instance.getTexture("ui_zuanshi01_tubiao");
                    } else {
                        diaIcon.texture = AssetMgr.instance.getTexture("ui_jinbi01_tubiao");
                    }
                    effectCahe(i, heroShow);
                    heroShow.addEventListener(TouchEvent.TOUCH, onSkill); //英雄信息
                    heroShow.touchable = true;
                    buyBtn.filter = heroShow.filter = null;
                } else {
                    buyBtn.filter = heroShow.filter = new ColorMatrixFilter(Val.filter);
                    heroShow.updata(null);
                    heroShow.updataStar(0, 1);
                    heroShow.touchable = false;
                    buyBtn.touchable = false;
                    buyBtn.text = Langue.getLangue("alreadyBuy");
                    diaIcon.visible = false;
                }
            }
        }


        private function effectCahe(index:int, heroShow:HeroCardShow):void {
            var action:SpriterClip = null;
            if (!effs.containsKey("effect_" + index)) {
                action = AnimationCreator.instance.create("effect_017", AssetMgr.instance);
                effs.put("effect_" + index, action);
            } else {
                action = effs.getValue("effect_" + index) as SpriterClip;
            }
            action.play("effect_017");
            action.x = heroShow.setHeroX;
            action.y = heroShow.setHeroY;
            action.touchable = false;
            Starling.juggler.add(action);
            heroShow.addQuiackChild(action);
            action.animationComplete.addOnce(removeEffect);

        }

        //取到英雄的ID对应数组的下标
        public function getTavneInfoByIndex(arr:Vector.<IData>, j:uint):TavernHeroVo {
            var info:TavernHeroVo = null;
            var _length:int = arr.length
            for (var i:int = 0; i < _length; i++) {
                info = arr[i] as TavernHeroVo;
                if (info && j == info.id) {
                    return info;
                }
            }
            return null;
        }

        private function removeEffect(effect:SpriterClip):void {
            effect && effect.removeFromParent();
        }

        /**刷新*/
        private function cdTime():void {
            data.fushData1.cdTime(text_time); //免费倒计时
            if (data.fushData1.time > 0) {
                textfree.text = Langue.getLangue("USING_DIAMOND") + ":";
                freetipTxt.text = "";
            } else {
                text_time.text = textfree.text = "";
                freetipTxt.text = Langue.getLangue("REFRESH_ONE");
            }
            data.fushData1.onTimeEnd.addOnce(function():void {
                text_time.text = textfree.text = "";
                freetipTxt.text = Langue.getLangue("REFRESH_ONE");
            });
        }

        /**查看人物信息*/
        private function onSkill(e:TouchEvent):void {
            var touch:Touch = e.getTouch(stage);
            (this.parent as TavernDialog).isVisible = true;
            switch (touch && touch.phase) {
                case TouchPhase.BEGAN:
                    var sp:HeroCardShow = e.currentTarget as HeroCardShow;
                    index = uint(sp.name.split("_")[1]);
                    heroVotype = getTavneInfoByIndex(data.heroList, index + 1);
                    e.stopPropagation();
                    if (heroVotype) {
                        var heroData:HeroData = HeroData.hero.getValue(heroVotype.type);
                        DialogMgr.instance.open(HeroSkillDialog, heroData);
                    }
                    break;
            }
        }

        /**购买英雄*/
        private function onBuy(e:Event):void {
            index = uint((e.currentTarget as Scale9Button).name.split("_")[1]);
            heroVotype = getTavneInfoByIndex(data.heroList, index + 1);
            if (heroVotype == null || heroVotype.id == 0) {
                RollTips.add(Langue.getLangue("notHero"));
                return;
            } else if (HeroDataMgr.instance.hash.keys().length >= GameMgr.instance.hero_gridCount) {
                RollTips.add(Langue.getLangue("MaxHero"));
                return;
            }

            if (GameMgr.instance.diamond < (HeroPriceData.hash.getValue(heroVotype.ravity + "" + heroVotype.quality) as HeroPriceData).price) //钻石小于价格
            {
                RollTips.add(Langue.getLangue("diamendNotEnough")); //钻石不足
            } else { //请求购买 英雄
                var cmd:CBuyhero = new CBuyhero();
                cmd.id = heroVotype.id;
                Message.sendMessage(cmd);
            }
        }

        /**销毁*/
        override public function dispose():void {
            var heroShow:HeroCardShow = null;
            for (var i:int = 0; i < 3; i++) {
                heroShow = this.getChildByName("heroShow_" + i) as HeroCardShow;
                heroShow && heroShow.removeFromParent(true);
            }
            for each (var action:SpriterClip in effs) {
                action.removeFromParent(true);
            }
            effs = null;
            buy_hero_money = 0; //刷新英雄请求
            qualtiy = 0;
            heroVotype = null;
            index = 0;
            super.dispose();
        }
    }
}
