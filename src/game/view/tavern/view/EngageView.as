package game.view.tavern.view {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.sound.SoundManager;
    import com.view.base.event.EventType;

    import flash.geom.Point;

    import game.data.HeroData;
    import game.data.IconData;
    import game.data.MercenaryData;
    import game.data.RoleShow;
    import game.data.SkillData;
    import game.dialog.ShowLoader;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.net.data.c.CHeroBuy;
    import game.net.data.c.CIsHeroBuy;
    import game.net.data.s.SHeroBuy;
    import game.net.data.s.SIsHeroBuy;
    import game.net.data.vo.GateHero;
    import game.net.message.base.Message;
    import game.view.comm.GetGoodsAwardEffectDia;
    import game.view.heroHall.SkillDesDialog;
    import game.view.heroHall.render.HeroCardShow;
    import game.view.heroHall.render.StarBarRender;
    import game.view.tavern.TavernDialog;
    import game.view.tavern.data.TavernData;
    import game.view.tavern.render.MercenaryIconRender;
    import game.view.tavern.render.MercenaryListRender;
    import game.view.uitils.Res;
    import game.view.viewBase.EngageViewBase;

    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.MovieClip;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;

    /**
     *雇佣兵界面
     * @author lfr
     *
     */
    public class EngageView extends EngageViewBase {
        /**佣兵列表*/
        private var _mercenaryList:MercenaryListRender = null;
        /**声音*/
        private var _sound:String;
        /**当前佣兵数据*/
        private var _mercenaryData:MercenaryData = null;
        /**英雄模型显示*/
        private var _heroAvatar:HeroCardShow = null;
        /**星星*/
        private var _starBar:StarBarRender = null;
        /**动画图标*/
        private var _mcImage:MovieClip = null;
        /**当前操作服务端数据*/
        private var _gateHero:GateHero = null;
        private var iconData:IconData = null
        private var dataVector:Vector.<IconData> = null;

        public function EngageView() {
            super();
        }

        override protected function init():void {
            //英雄模型
            _heroAvatar = new HeroCardShow();
            _heroAvatar.x = 190;
            _heroAvatar.y = 100;
            addQuiackChild(_heroAvatar);

//            _starBar = new StarBarRender();
//            _starBar.x = 245;
//            _starBar.y = 110;
//            addQuiackChild(_starBar);

            _mercenaryList = new MercenaryListRender();
            _mercenaryList.x = 187;
            _mercenaryList.y = 440;
            _mercenaryList.setSize(720, 100);
            addQuiackChild(_mercenaryList);

            diamond_Scale9Button.text = "";
            diamond_Scale9Button.touchable = false;

            var names:Array = Langue.getLans("gyb_des_nametype");
            text_expert.text = names[0];
            text_HabitWeapon.text = names[1];
        }

        /**初始化监听*/
        override protected function addListenerHandler():void {
            super.addListenerHandler();
            //收到服务端数据列表
            this.addContextListener(SIsHeroBuy.CMD.toString(), onHeroBuyList);
            //购买成功
            this.addContextListener(SHeroBuy.CMD.toString(), onHeroBuyHandler);
            //佣兵选择
            this.addContextListener(EventType.NOTIFY_MERCENARY_SELECT, onMercenarySelected);
            //购买    s
            this.diamond_Scale9Button.addEventListener(Event.TRIGGERED, buyMercenaryHandler);
        }

        override protected function show():void {
            Message.sendMessage(new CIsHeroBuy()); //关卡会变化所以大开都要刷新
        }

        /**接收到服务端购状态列表*/
        private function onHeroBuyList(event:Event, info:SIsHeroBuy):void {
            ShowLoader.remove();
            //服务端数据
            TavernData.instance.MercenaryList = info.heroes;
            _mercenaryList.updateMercenaryList(TavernData.instance.MercenaryList);
            _mercenaryList.selectedIndex = _mercenaryList._selectedIndex;
        }

        /**接收到服务端购买数据*/
        private function onHeroBuyHandler(event:Event, info:SHeroBuy):void {
            var sheroBuy:SHeroBuy = info;
            switch (info.state) {
                case 0: //购买成功 
                    var merIconItem:MercenaryIconRender = _mercenaryList.getChildItem(_mercenaryList.selectedIndex) as MercenaryIconRender;
                    _gateHero.state = 2;
                    merIconItem.data = _gateHero;
                    TavernData.instance.GetMercenarDataById(_gateHero.id).state = 2;
                    diaIcon.visible = false;
                    diamond_Scale9Button.text = Langue.getLangue("Already_Buy");
                    diamond_Scale9Button.touchable = false;
//                    addTips("buySuccess");
                    DialogMgr.instance.isVisibleDialogs(true);
                    var effectData:Object = {vector: dataVector, effectPoint: null, effectName: "effect_037", effectSound: "baoxiangkaiqihuode",
                            effectFrame: 854};
                    DialogMgr.instance.open(GetGoodsAwardEffectDia, effectData, null, null, "translucence", 0x000000, 0.5);
                    break;
                case 1: //金币不足
                    addTips("notEnoughCoin");
                    break;
                case 2: //未达到关卡数
                    RollTips.add(Langue.getLangue("Not_Reached_Points"));
                    break;
                case 3: //已经购买
                    RollTips.add(Langue.getLangue("Already_Buy"));
                    break;
                case 4: //配置表错误
                    RollTips.add(Langue.getLangue("Configuration_ERR"));
                    break;
                case 5: //背包格子不足
                    RollTips.add(Langue.getLangue("MaxHero"));
                    break;
                case 6: //钻石不足
                    RollTips.add(Langue.getLangue("diamendNotEnough"));
                    break;
                default: //程序异常
                    RollTips.add(Langue.getLangue(getLangue("codeError") + ",code:" + info.state));
                    break;
            }
            ShowLoader.remove();
        }

        /**选中佣兵 mercenary {id:佣兵id,state:状态}*/
        private function onMercenarySelected(e:Event, mercenary:GateHero):void {
            if (mercenary == null) {
                return;
            }
            _gateHero = mercenary;
            _mercenaryData = MercenaryData.hash.getValue(_gateHero.id);
            updata();
        }

        /**根据选中的佣兵英雄数据更新UI*/
        public function updata():void {
            if (visible && _gateHero != null && _mercenaryData != null) {
                var arr:Array = Langue.getLans("Mercenary_Icon_Value");
                switch (_gateHero.state) {
                    case 0: //可以购买 
                        diaIcon.visible = true;
                        diamond_Scale9Button.text = _mercenaryData.sellPrice.toString();
                        diaIcon.texture = Res.instance.getCommTexture(_mercenaryData.payType);
                        diamond_Scale9Button.touchable = true;
                        break;
                    case 1: //未解锁
                        diaIcon.visible = false;
                        diamond_Scale9Button.text = Langue.getLangue("Not_Unlock");
                        diamond_Scale9Button.touchable = false;
                        break;
                    case 2: //已经购买
                        diaIcon.visible = false;
                        diamond_Scale9Button.text = Langue.getLangue("Already_Buy");
                        diamond_Scale9Button.touchable = false;
                        break;
                    default:
                        diaIcon.visible = false;
                        diamond_Scale9Button.text = Langue.getLangue("Already_Buy");
                        diamond_Scale9Button.touchable = false;
                        break;
                }

                /**-----------------------------------------------------------------------------*/
                var heroData:HeroData = HeroData.hero.getValue(_mercenaryData.heroID);
                heroData.foster = _mercenaryData.star;
                heroData.quality = _mercenaryData.quality;
                _mercenaryList.stopAllSound();
                if (_sound != heroData.sound) {
                    _sound = heroData.sound;
                    SoundManager.instance.playSound(heroData.sound, true, 1, 1);
                }
                _heroAvatar.updata(heroData);
                _heroAvatar.updataStar(heroData.foster);
//                _starBar.updataStar(heroData.foster, 0.8, 3);
                text_heroInfo.text = heroData.des;
                text_expertValue.text = Langue.getLans("hero_job")[heroData.job - 1];
                text_HabitWeaponValue.text = Langue.getLans("Equip_type")[heroData.weapon - 1];
                showHeroSkill(heroData);

                dataVector = new Vector.<IconData>;
                iconData = new IconData();
                iconData.IconId = heroData.id;
                iconData.IconTrue = (RoleShow.hash.getValue(heroData.show) as RoleShow).photo;
                iconData.QualityTrue = Res.instance.getQualityHeroTextures(_mercenaryData.quality);
                iconData.Num = "Lv " + _mercenaryData.level;
                iconData.IconType = heroData.type;
                iconData.Name = heroData.name;
                iconData.hunModel = false;
                dataVector.push(iconData);
            }
        }

        private function buyMercenaryHandler(e:Event):void {
            if (_mercenaryData) {
                //金币不足
                if (_mercenaryData.payType == 1 && GameMgr.instance.coin < _mercenaryData.sellPrice) {
                    addTips("notEnoughCoin");
                    return;
                }
                //钻石不足
                if (_mercenaryData.payType == 2 && GameMgr.instance.diamond < _mercenaryData.sellPrice) {
                    addTips("diamendNotEnough");
                    return;
                }
                var cmd:CHeroBuy = new CHeroBuy();
                cmd.id = _mercenaryData.id
                Message.sendMessage(cmd);
            }
        }

        /**
         * 英雄技能
         * @param heroData
         */
        private function showHeroSkill(heroData:HeroData):void {

            var skillData:SkillData;
            var image:Button = null;
            var text:TextField;
            var arr:Array = [];
            var arrTxt:Array = [];
            for (var i:int = 0; i < 3; i++) {
                skillData = SkillData.getSkill(heroData["skill" + (i + 1)]);
                image = this["skill_" + i] as Button;
                text = this["textSkill_" + i] as TextField;
                image.touchable = true;
                if (skillData) {
                    image.visible = true;
                    image.upState = AssetMgr.instance.getTexture(skillData.skillIcon);
                    text.text = skillData.name;
                    image.addEventListener(TouchEvent.TOUCH, thochHandler);
                    arr.push(image);
                    arrTxt.push(text);
                } else {
                    text.text = "";
                    image.visible = false;
                }
            }

            if (arr.length == 1) {
                image = arr[0] as Button;
                text = arrTxt[0] as TextField;
                image.y = 311;
                text.y = 319;
            } else if (arr.length == 2) {
                image = arr[0] as Button;
                text = arrTxt[0] as TextField;
                image.y = 321;
                text.y = 329;
                image = arr[1] as Button;
                text = arrTxt[1] as TextField;
                image.y = 350;
                text.y = 358;
            } else if (arr.length == 3) {
                image = arr[0] as Button;
                text = arrTxt[0] as TextField;
                image.y = 262;
                text.y = 269;
                image = arr[1] as Button;
                text = arrTxt[1] as TextField;
                image.y = 311;
                text.y = 319;
                image = arr[2] as Button;
                text = arrTxt[2] as TextField;
                image.y = 360;
                text.y = 368;
            }
        }

        private function thochHandler(e:TouchEvent):void {
            if (_mercenaryData == null) {
                return;
            }
            var index:uint = uint((e.currentTarget as DisplayObject).name.split("_")[1]) + 1;
            var heroData:HeroData = HeroData.hero.getValue(_mercenaryData.heroID);
            var touch:Touch = e.getTouch(this);
            if (touch == null) {
                return;
            }
            var skillData:SkillData = SkillData.getSkill(heroData["skill" + index]);
            var p:Point = touch.getLocation(this);
            p = new Point(p.x, p.y);
            switch (touch && touch.phase) {
                case TouchPhase.BEGAN:
                    (parent as TavernDialog).isVisible = true;
                    DialogMgr.instance.open(SkillDesDialog, {data: skillData, point: p});
                    break;
                case TouchPhase.ENDED:
                    DialogMgr.instance.closeDialog(SkillDesDialog);
                    break;
            }
        }

        /**销毁*/
        override public function dispose():void {
            while (this.numChildren > 0) {
                this.getChildAt(0).removeFromParent(true);
            }

            super.dispose();
            _mercenaryList = null;
            _sound = null;
            _heroAvatar = null;
//            _starBar = null;
            _mcImage = null;
        }
    }
}
