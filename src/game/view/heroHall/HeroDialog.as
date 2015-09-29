package game.view.heroHall {
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.sound.SoundManager;
    import com.utils.Constants;
    import com.view.base.event.EventType;

    import flash.geom.Point;

    import game.data.ExpData;
    import game.data.Goods;
    import game.data.HeroData;
    import game.data.HeroPriceData;
    import game.data.IconData;
    import game.data.WidgetData;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.net.message.GoodsMessage;
    import game.view.comm.GetGoodsAwardEffectDia;
    import game.view.dispark.DisparkControl;
    import game.view.dispark.data.ConfigDisparkStep;
    import game.view.goodsGuide.EquipInfoDlg;
    import game.view.heroHall.render.HeroListRender;
    import game.view.heroHall.view.AdvanceView;
    import game.view.heroHall.view.EquimentView;
    import game.view.heroHall.view.ExperienceView;
    import game.view.heroHall.view.HeroRisingStarView;
    import game.view.uitils.FunManager;
    import game.view.uitils.Res;
    import game.view.viewBase.HeroDialogBase;
    import game.view.widget.BagEquipDlg;
    import game.view.widget.EquipDlg;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.display.DisplayObjectContainer;
    import starling.events.Event;

    /**
     * 英雄模块
     * @author Samuel
     *
     */
    public class HeroDialog extends HeroDialogBase {
        public static const HERO:int = 0;
        public static const JINHUA:int = 1;
        public static const EXP:int = 2;
        private var curPage:int = 0;

        private var _heroListPanle:HeroListRender = null;
        private var _currData:HeroData = null;
        private var sound:String

        public function HeroDialog() {
            super();
            _closeButton = btn_close;
        }

        /**列出按钮*/
        override protected function listTabButton():Array {
            var arr:Array = Langue.getLans("heroLableName");
            tab_1.text = arr[0];
            tab_2.text = arr[1];
            tab_3.text = arr[3];
            tab_4.text = arr[2];
            return [tab_1, tab_2, tab_3, tab_4];
        }

        /**列出引用的类名*/
        override protected function listTabReference():Array {
            return [game.view.heroHall.view.EquimentView, game.view.heroHall.view.AdvanceView, game.view.heroHall.view.HeroRisingStarView,
                    game.view.heroHall.view.ExperienceView];
        }

        /**初始化*/
        override protected function init():void {
            _heroListPanle = new HeroListRender();
            _heroListPanle.setSize(704, 100);
            _heroListPanle.move(194, 440);
            addChild(_heroListPanle);

            configDisparkStep();
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            //更新英雄列表 
            this.addContextListener(EventType.UPDATE_HERO_INDEX, updateHeroList);
            //使用经验药水
            this.addContextListener(EventType.USE_EXP, onUseExpHandler);
            //更新自动换装
            this.addContextListener(EventType.NOTIFY_HERO_EQUIP, updateAtuoEquipHander);
            //玩家身上装备选中
            this.addContextListener(EventType.UPDATE_BODYEQUIP_SELECTED, onHeroEquipClick);
            //英雄进化
            this.addContextListener(EventType.NOTIFY_HERO_PURGE, updateHeroPurge);
            //升星成功
            this.addContextListener(EventType.NOTIFY_HERO_STAR, updateHeroStar);
            //解雇英雄
            this.addContextListener(EventType.REMOVE_HERO, onHeroRemoveNotify);
            //装备数据更新
            this.addContextListener(EventType.UPDATE_HERO_EQUIP, onUpdateHeroEquip);
            //更新英雄信息加了经验
            this.addContextListener(EventType.UPDATE_HERO_INFO, updateHeroInfo);
            //更新英雄信息加了经验升级了
            this.addContextListener(EventType.PLAY_HERO_ANIMATION, playHeroAnimation);
            //英雄选择
            this.addContextListener(EventType.UPDATE_HERO_SELECTED, onHeroSelected);
            //选中标签页
            this.addContextListener(EventType.SELECTTAB, onSelectTab);
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            if (parameter && parameter is int) {
                defaultSelect = parameter as int;
            }
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
        }

        /**选中标签页*/
        private function onSelectTab(evt:Event = null, index:int = 0):void {
            switch (index) {
                case 1:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep12)) {
                        select(curPage);
                        return;
                    }
                    curPage = defaultSelect;
                    DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep12);
                    break;
                case 2:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep13)) {
                        select(curPage);
                        return;
                    }
                    curPage = defaultSelect;
                    DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep13);
                    break;
                case 3:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep19)) {
                        select(curPage);
                        return;
                    }
                    curPage = defaultSelect;
                    DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep19);
                    break;
            }

            if (_currData) {
                this.currentPanel.updata(_currData);
            }
        }

        /**
         * 更新英雄列表
         *
         */
        private function updateHeroList(evt:Event = null, index:int = -1):void {
            var position:Number = _heroListPanle.list_hero.verticalScrollPosition;
            _heroListPanle.selectedIndex = index == -1 ? _heroListPanle.list_hero.selectedIndex : index;
            _heroListPanle.updateHeroList(null);
            _heroListPanle.selectedIndex = _heroListPanle.selectedIndex;
            _heroListPanle.list_hero.verticalScrollPosition = position;
        }

        /**
         * 使用经验药水
         * @param evt
         * @param goods
         */
        private function onUseExpHandler(evt:Event, goods:Goods):void {
            var useGoods:WidgetData = WidgetData.getWidgetByType(goods.type);
            if (useGoods == null) {
                goods.isPack = false;
                DialogMgr.instance.isVisibleDialogs(true);
                DialogMgr.instance.open(EquipInfoDlg, goods);
                return;
            }

            if (_currData.id != 0) {
                GoodsMessage.onSendUseExp(_currData.id, useGoods.id);
            }
        }

        /**返回更新英雄数据播放技能特效*/
        private function updateHeroInfo():void {
            var upgradeAnimation:SpriterClip = AnimationCreator.instance.create("skill_111", AssetMgr.instance);
            Starling.juggler.add(upgradeAnimation);
            upgradeAnimation.play("skill_111");
            upgradeAnimation.animation.looping = true;
            upgradeAnimation.animationComplete.addOnce(aniComplete);
            addChild(upgradeAnimation);
            upgradeAnimation.x = equimentView._heroAvatar.x + 120;
            upgradeAnimation.y = equimentView._heroAvatar.y + 210;
            function aniComplete(obj:Object = null):void {
                upgradeAnimation.removeFromParent(true);
            }
            equimentView.list_exp.dataViewPort.dataProvider_refreshItemHandler();
            _heroListPanle.updateItem(_currData);
            if (_currData) {
                this.currentPanel.updata(_currData);
            }
        }

        /**返回更新英雄数据播放特效*/
        private function playHeroAnimation(e:Event, info:Object):void {
            var upgradeAnimation:SpriterClip = AnimationCreator.instance.create("effect_52004", AssetMgr.instance);
            Starling.juggler.add(upgradeAnimation);
            upgradeAnimation.play("effect_52004");
            upgradeAnimation.animation.looping = true;
            upgradeAnimation.animationComplete.addOnce(aniComplete);
            addChild(upgradeAnimation);
            upgradeAnimation.x = equimentView._heroAvatar.x + 120;
            upgradeAnimation.y = equimentView._heroAvatar.y + 210;
            function aniComplete(obj:Object = null):void {
                upgradeAnimation.removeFromParent(true);
            }
            _currData.level = info as int;
            _heroListPanle.updateItem(_currData);
        }

        /**
         * 自动换装
         * @param evt
         * @param heroData
         *
         */
        private function updateAtuoEquipHander(evt:Event, heroData:HeroData):void {
            _currData = heroData;
            _heroListPanle.updateItem(_currData);
            this.currentPanel.updata(_currData);
        }

        /**
         * 英雄装备点击
         *
         */
        private function onHeroEquipClick(evt:Event, widgetData:WidgetData):void {
            isVisible = false;
            var data:Object = {wid: widgetData, hero: _currData}
            if (widgetData.id > 0) {
                DialogMgr.instance.open(EquipDlg, data);
            } else {
                DialogMgr.instance.open(BagEquipDlg, data);
            }
        }

        /**
         *  英雄进化
         *
         */
        private function updateHeroPurge(evt:Event, heroData:HeroData):void {
            AnimationCreator.instance.createSecneEffect("effect_016", advanceView.currHeroRender.x + 50, advanceView.currHeroRender.y + 75,
                                                        this, AssetMgr.instance);
            onHeroSelected(null, heroData);
            _heroListPanle.updateItem(_currData);
        }


        /**
         *  英雄升星成功
         *
         */
        private function updateHeroStar(evt:Event, heroData:HeroData):void {
            AnimationCreator.instance.createSecneEffect("effect_037", equimentView._heroAvatar.x + 140, equimentView._heroAvatar.x + 150,
                                                        this, AssetMgr.instance);
            onHeroSelected(null, heroData);
            _heroListPanle.updateItem(_currData);
        }

        /**返回解散信息*/
        private function onHeroRemoveNotify(evt:Event, heroData:HeroData):void {
            if (heroData != null) {
                _currData = heroData;
                _heroListPanle._selectedIndex = _heroListPanle.selectedIndex - 1;
                if (_heroListPanle._selectedIndex < 0) {
                    _heroListPanle._selectedIndex = 0;
                }
                _heroListPanle.updateHeroList(null);
                _heroListPanle.selectedIndex = _heroListPanle.selectedIndex;
                equimentView.list_exp.dataViewPort.dataProvider_refreshItemHandler();
                addTips("heroDismissal");
            } else {
                var heroPriceData:HeroPriceData = HeroPriceData.hash.getValue((_currData.rarity == 0 ? 1 : _currData.rarity) + "" + _currData.quality) as HeroPriceData;
                var tmp_arr:Array = _currData.items.match(/\d+/gs);
                var dataVector:Vector.<IconData> = new Vector.<IconData>;
                var iconData:IconData = null;
                var dominonNum:uint = FunManager.hero_dismissal(heroPriceData.price, _currData.level);
                if (dominonNum > 0) { //奖励钻石
                    iconData = new IconData();
                    iconData.QualityTrue = Res.instance.getQualityToolTextures(0);
                    iconData.IconTrue = Res.instance.getCommTextures(11);
                    iconData.Num = "x " + dominonNum;
                    iconData.IconType = 2;
                    iconData.IconId = 2;
                    iconData.Name = iconData.Name = Langue.getLangue("buyDiamond"); //"钻石";
                    dataVector.push(iconData);
                }

                var goods:Array = ExpData.getGoodsList(_currData.level);
                var goodsLen:int = goods.length;
                var itemData:Goods = null;
                for (var i:int = 0; i < goodsLen; i++) {
                    itemData = goods[i].data as Goods;
                    iconData = new IconData();
                    iconData.QualityTrue = Res.instance.getQualityToolTextures(0);
                    iconData.IconTrue = itemData.picture;
                    iconData.Num = "x " + goods[i].num;
                    iconData.IconId = itemData.type;
                    iconData.IconType = itemData.type;
                    iconData.Name = String(itemData.name);
                    dataVector.push(iconData);
                }
                var effectData:Object = {vector: dataVector, effectPoint: new Point(Constants.virtualWidth >> 1, (Constants.virtualHeight >> 1) - 50),
                        effectName: "effect_037", effectSound: "effect_037", effectFrame: 854};
                DialogMgr.instance.open(GetGoodsAwardEffectDia, effectData, null, null, "translucence", 0x000000, 0.5);
            }
        }

        /**
         * 装备数据更新
         *
         */
        private function onUpdateHeroEquip(evt:Event, widget:WidgetData):void {
            equimentView.list_equip.dataViewPort.dataProvider_refreshItemHandler();

        }


        /**
         * 英雄列表选择
         * @param view
         * @param heroData
         *
         */
        private function onHeroSelected(e:Event, heroData:HeroData):void {
            if (heroData == null) {
                return;
            }
            _currData = heroData;
            _heroListPanle.stopAllSound();
            if (sound != _currData.sound) {
                sound = _currData.sound;
                SoundManager.instance.playSound(_currData.sound, true, 1, 1);
            }
            currentPanel.updata(_currData);
        }

        /**配置*/
        protected function configDisparkStep():void {
            //功能开放引导
            DisparkControl.dicDisplay["hero_table_2"] = tab_2;
            DisparkControl.dicDisplay["hero_table_3"] = tab_3;
            DisparkControl.dicDisplay["hero_table_4"] = tab_4;
            //智能判断是否添加功能开放提示图标（进化）
            DisparkControl.instance.addDisparkHandler(ConfigDisparkStep.DisparkStep12);
            //智能判断是否添加功能开放提示图标（英雄升星）
            DisparkControl.instance.addDisparkHandler(ConfigDisparkStep.DisparkStep13);
            //智能判断是否添加功能开放提示图标（经验药水）
            DisparkControl.instance.addDisparkHandler(ConfigDisparkStep.DisparkStep19);
        }

        public function get equimentView():EquimentView {
            return getPanel(HERO) as EquimentView;
        }

        public function get advanceView():AdvanceView {
            return getPanel(JINHUA) as AdvanceView;
        }

        public function get experienceView():ExperienceView {
            return getPanel(EXP) as ExperienceView;
        }

        override public function dispose():void {
            _heroListPanle.removeFromParent(true);
            super.dispose();
        }

    }
}
