package game.scene {
    import com.data.Data;
    import com.dialog.Dialog;
    import com.dialog.DialogMgr;
    import com.scene.BaseScene;
    import com.scene.SceneMgr;
    import com.sound.SoundManager;
    import com.utils.Constants;
    import com.view.base.event.EventType;
    
    import flash.geom.Point;
    import flash.system.System;
    
    import game.common.JTGlobalDef;
    import game.common.JTSession;
    import game.data.Goods;
    import game.data.HeroData;
    import game.data.MainLineData;
    import game.data.StoryConfigData;
    import game.data.TollgateData;
    import game.data.WidgetData;
    import game.dialog.ShowLoader;
    import game.fight.Position;
    import game.hero.AnimationCreator;
    import game.hero.BattleDriver;
    import game.hero.Hero;
    import game.manager.AssetMgr;
    import game.manager.BattleAssets;
    import game.manager.BattleHeroMgr;
    import game.manager.CommandSet;
    import game.manager.GameMgr;
    import game.manager.HeroDataMgr;
    import game.managers.JTFunctionManager;
    import game.managers.JTPvpInfoManager;
    import game.managers.JTSingleManager;
    import game.net.data.IData;
    import game.net.data.c.CBattle;
    import game.net.data.s.SBattle;
    import game.net.data.s.SColiseumPrizeSend;
    import game.net.data.s.SVideoInfo;
    import game.net.data.vo.BattleTarget;
    import game.net.data.vo.BattleVo;
    import game.net.data.vo.EquipVOS;
    import game.net.data.vo.battleHeroesVo;
    import game.net.data.vo.videoDataInfo;
    import game.net.data.vo.videoHeroes;
    import game.net.data.vo.videoVo;
    import game.net.message.GameMessage;
    import game.view.arena.ArenaDareData;
    import game.view.arena.ArenaDialog;
    import game.view.battle.BattleUI;
    import game.view.battle.VSEntify;
    import game.view.city.CityFace;
    import game.view.embattle.EmBattleDlg;
    import game.view.fb.FbData;
    import game.view.gameover.WinView;
    
    import sdk.DataEyeManger;
    
    import spriter.SpriterClip;
    
    import starling.display.BlendMode;
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;

    /**
     * 战斗场景
     * @author Michael
     *
     */
    public class BattleScene extends BaseScene {
        /**
         *
         * @default
         */
        private var _driver:BattleDriver;
        private var _battleUI:BattleUI;
        private var _bgLayer:Sprite;
        private var _roleLayer:Sprite;
        private var _effectLayer:Sprite;
        private var _powerSkillLayer:Sprite;
        private var _uiLayerLayer:Sprite;
        /**
         * 0关卡2副本3PVP
         */
        private var tollgate_type:int;
        /**
         * 对手ID
         */
        private var enemy_id:int;

        /**
         * 关卡信息
         */
        private var tollgateData:TollgateData;
        private var isTweening:Boolean;
        private var isReturnMsg:Boolean;

//		public function get battleUI():BattleUI
//		{
//			return _battleUI;
//		}

        override public function set data(value:Object):void {
			if(!value)
				return;
            /* if (tollgate_type != 3)
               {
               var mainLineData:MainLineData=(MainLineData.getPoint(tollgateData.id) as MainLineData);
               SoundManager.instance.tweenVolumeSmall(mainLineData.bgm, 0.0, 1);
               }
               else if (tollgate_type == 3)
               {
               SoundManager.instance.tweenVolumeSmall("battle_bgm", 0.0, 1);
               }
               HeroDataMgr.instance.battleHeros.clear();
               BattleHeroMgr.instance.dispose();
               CommandSet.instance.onSkip.removeAll();
               GameMgr.instance.tollgateData=null;

             */
            BattleHeroMgr.instance.dispose();
//            CommandSet.instance.onSkip.removeAll();
//            HeroDataMgr.instance.battleHeros.clear();

            _bgLayer.clearChild()
            _roleLayer.clearChild()
            _effectLayer.clearChild()
            _uiLayerLayer.clearChild()
            _powerSkillLayer.clearChild()

            GameMgr.instance.reward_Battle = null;
            tollgateData = value.tollgate as TollgateData;
            tollgate_type = value.pos;
            enemy_id = value.id;

            if (_driver) {
                _driver.dispose();
            }
            _driver = new BattleDriver(this);
            _driver.freePowerSkill.add(freeSkill);

            //PVP
            if (tollgate_type == 3) {
                SoundManager.instance.playSound("battle_bgm", true, 0, 99999);
                SoundManager.instance.tweenVolume("battle_bgm", 0.75, 2);
                addBackground(_bgLayer, "map_013");
            }
            //关卡/副本
            else {
                var mainLineData:MainLineData = (MainLineData.getPoint(tollgateData.id) as MainLineData);
                addBackground(_bgLayer, mainLineData.scene);
                SoundManager.instance.playSound(mainLineData.bgm, true, 0, 99999);
                SoundManager.instance.tweenVolume(mainLineData.bgm, 0.75, 2);
                //进入关卡
                DataEyeManger.instance.beginTollgate(mainLineData.pointName);

                if (mainLineData && mainLineData.boss_level > 0) {
                    whichBoss(mainLineData);
                }
            }
            tweenOpen();
            startup();
        }

        private function freeSkill(heroData:HeroData):void {
            _battleUI.freeSkill(heroData);
        }

        /**
         *
         * @param container
         */
        override protected function init():void {
            _bgLayer = new Sprite();
            _roleLayer = new Sprite();
            _effectLayer = new Sprite();
            _uiLayerLayer = new Sprite();
            _powerSkillLayer = new Sprite();
            this.addQuiackChild(_bgLayer);
            this.addQuiackChild(_roleLayer);
            this.addQuiackChild(_powerSkillLayer);
            this.addChild(_uiLayerLayer);
            this.addQuiackChild(_effectLayer);

            //设置成不可点击
            _bgLayer.touchable = _roleLayer.touchable = _powerSkillLayer.touchable = _effectLayer.touchable = false;
        }

        override protected function show():void {

        }

        private function whichBoss(mainLineData:MainLineData):void {
            if (!_effectLayer)
                return;
            var point:Point = Position.instance.getPoint(mainLineData.boss_seat + 20);
            AnimationCreator.instance.createSecneEffect("effect_006", point.x, point.y - 20, _effectLayer, AssetMgr.instance);
            var bossAnimation:SpriterClip = AnimationCreator.instance.createSecneEffect(mainLineData.boss_level == 1 ? "effect_007" : "effect_008",
                                                                                        0, 0, JTSession.layerGlobal, AssetMgr.instance);
            bossAnimation.scaleX = bossAnimation.scaleY = Constants.isScaleWidth ? Constants.scale_x : Constants.scale;
            bossAnimation.x = (Constants.FullScreenWidth - changePosition(400, true)) * .5;
            bossAnimation.y = (Constants.FullScreenHeight - changePosition(400, true)) * .5;
        }

        private function addBackground(stage:Sprite, resName:String, x:Number = 0, y:Number = 0):void {

            var n:String = resName.replace("map", "map_1");
            var texture:Texture = BattleAssets.instance.getTexture(n);

            var bg:Image = new Image(texture);

            if (bg.width < Constants.virtualWidth) {
                bg.width = Constants.virtualWidth
            }
            bg.x = ((Constants.FullScreenWidth - bg.width * Constants.scale) * .5);
            bg.blendMode = BlendMode.NONE;
            stage.addQuiackChild(bg);
            _bgLayer.flatten();
        }

        /**自动开始战斗隐藏九宫格站位*/
        private function hidePosGrid(bool:Boolean = false):void {
            var gridBg:Image = null;

            if (_bgLayer != null) {
                gridBg = _bgLayer.getChildByName("ui_array_base_map_1") as Image;

                if (gridBg != null) {
                    gridBg.visible = bool;
                }
                gridBg = _bgLayer.getChildByName("ui_array_base_map_2") as Image;

                if (gridBg != null) {
                    gridBg.visible = bool;
                }
            }
            _bgLayer.flatten(); //再次更新属性
        }

        override public function get data():Object {
            return tollgateData;
        }

        private function tweenOpen():void {
            isTweening = false;
            isReturnMsg = false;
        }



        override protected function addListenerHandler():void {
            this.addContextListener(SBattle.CMD + "", messageNotification);
            this.addContextListener(SColiseumPrizeSend.CMD + "", getColiseumPrizeSend);
            this.addContextListener(SVideoInfo.CMD + "", messageVideoNotification);
            this.addContextListener(EventType.UPDATE_BATTLE_STATUS, updateViewStatus);
            this.addContextListener(EventType.RESET_GAME, onResetGameHanlder);
        }

        private function onResetGameHanlder():void {
            BattleHeroMgr.instance.dispose();
            hidePosGrid(true);
            show();
        }

        private function getColiseumPrizeSend(evt:Event, info:SColiseumPrizeSend):void {
            GameMgr.instance.reward_Battle = info;
        }

        protected function updateViewStatus(evt:Event, list:Array):void {
            ShowLoader.add();
            AnimationCreator.instance.loadMeSelfBattleHeros(list, BattleAssets.instance);
            BattleAssets.instance.loadQueue(onCreateMyHerosComplement);

            function onCreateMyHerosComplement(value:Number):void {
                if (value == 1) {
                    createHeroes(list);
                    isTweening = true;
                    gameStart();
                }
            }
        }

        /**
         *
         * @param evt
         * @param sBattle
         *
         */
        protected function messageNotification(evt:Event, sBattle:SBattle):void {
            //PVP
            if (tollgate_type == 3) {
                var pvpInfoManager:JTPvpInfoManager = JTSingleManager.instance.pvpInfoManager;
                pvpInfoManager.pvpCount -= 1;

                if (pvpInfoManager.pvpCount < 0) {
                    pvpInfoManager.pvpCount = 0;
                }
            }

            GameMgr.instance.sBattle = sBattle;
            GameMgr.instance.tired = sBattle.tried;
            HeroDataMgr.instance.battleHeros.clear();
            WinView.rewardData = [];
            createRewardList(sBattle.props, WinView.rewardData);
            createRewardList(sBattle.equip, WinView.rewardData);

            function createRewardList(tmp_list:Vector.<IData>, reward_list:Array):void {
                var len:int = tmp_list.length;
                var widgetData:WidgetData;
                var data:Object;
                for (var i:int = 0; i < len; i++) {
                    data = tmp_list[i];
                    widgetData = WidgetData.hash.getValue(data.type);
                    if (widgetData == null) {
                        widgetData = new WidgetData(Goods.goods.getValue(data.type));
                    }
                    widgetData = widgetData.clone() as WidgetData;
                    widgetData.copy(data);
                    var count:int = 0;
                    if (data is EquipVOS) {
                        count = 1;
                    } else {
                        count = data.pile - WidgetData.pileByType(data.type);
                    }
                    for (var j:int = 0; j < count; j++) {
                        if (count > 1) {
                            var wid:WidgetData = widgetData.clone() as WidgetData;
                            wid.pile = 1;
                            reward_list.push(wid);
                        } else {
                            widgetData.pile = 1;
                            reward_list.push(widgetData);
                        }
                    }
                }
            }
            WidgetData.createProps(sBattle.props);
            WidgetData.createEquip(sBattle.equip);

            HeroDataMgr.instance.hash.eachValue(eachValue);
            function eachValue(heroData:HeroData):void {
                if (heroData.seat > 0)
                    HeroDataMgr.instance.createHero(heroData);
            }

            // 同步战斗单位血
            var battleHeros:Vector.<IData> = sBattle.battleHeroes;

            for each (var vo:battleHeroesVo in battleHeros) {
                var heroData:HeroData = HeroDataMgr.instance.battleHeros.getValue(vo.pos);

                if (heroData) {
                    heroData.hp = vo.hp;
                    heroData.currenthp = heroData.hp;
                    heroData.power = vo.power;
                }
            }

            //关卡
            if (tollgateData)
                GameMgr.instance.isPass = tollgateData.type == 2 || sBattle.currentCheckPoint > tollgateData.id;
            GameMgr.instance.battle_type = tollgate_type;

            if (sBattle.success == 1) {
                if (tollgate_type == 0 && (tollgateData as TollgateData).id > 0 && (tollgateData as TollgateData).id == GameMgr.instance.tollgateID) {
                    GameMgr.instance.tollgateID = sBattle.currentCheckPoint + 1;
                }

                //请求噩梦难度评星
                if (tollgateData && tollgateData.nightmareData)
                    GameMessage.getFbNightmareInfo();
            }

            if (tollgateData) {
                var mainLineData:MainLineData = (MainLineData.getPoint(tollgateData.id) as MainLineData);

                if (sBattle.success == 1 && !GameMgr.instance.isPass)
                    DataEyeManger.instance.completeTollgate(mainLineData.pointName);
                else if (sBattle.success != 1)
                    DataEyeManger.instance.failTollgate(mainLineData.pointName, HeroDataMgr.instance.getPower() + "");
            }

            var battleCommands:Vector.<IData> = sBattle.battleCommands;
            battleCommands.push(null);
            CommandSet.instance.init(battleCommands);
            isReturnMsg = true;
            gameStart();

            //更新关卡礼包数据
            JTFunctionManager.executeFunction(JTGlobalDef.UPDATE_TOLLGATE_NOTICE);
        }

        /**
         * 战斗录像
         * @param evt
         * @param info
         *
         */
        private function messageVideoNotification(evt:Event, info:SVideoInfo):void {
            HeroDataMgr.instance.battleHeros.clear();
            GameMgr.instance.sBattle = null;
            GameMgr.instance.battle_type = -1;
            GameMgr.instance.isPass = true;
            var len:int, i:int;
            var heroData:HeroData;
            var curr_battle_heros:Array = [];
            var data:videoHeroes;

            var onBattleList:Array = HeroDataMgr.instance.getOnBattleHero();
            len = onBattleList.length;

            for (i = 0; i < len; i++) {
                BattleHeroMgr.instance.hash.remove(HeroData(onBattleList[i]).seat);
            }
            len = info.heroes.length;

            for (i = 0; i < len; i++) {
                data = info.heroes[i] as videoHeroes;
                heroData = HeroData.hero.getValue(data.type) as HeroData;
                heroData = heroData.clone() as HeroData;
                heroData.copy(data);
                heroData.heroPrototype = new HeroData();
                heroData.heroPrototype.copy(data);
                heroData.id = data.seat;
                heroData.currenthp = data.hp;
                heroData.team = HeroData.BLUE;
                curr_battle_heros.push(heroData);
            }
            updateViewStatus(null, curr_battle_heros);

            //数据转换
            var tmp_list:Vector.<IData> = videoDataInfo(info.videoData[0]).videoCommands;
            var battleCommands:Vector.<IData> = new Vector.<IData>();
            var battleVo:BattleVo;
            var tmp_videoVo:videoVo;
            len = tmp_list.length;

            for (i = 0; i < len; i++) {
                battleVo = new BattleVo();
                tmp_videoVo = tmp_list[i] as videoVo;
                battleVo.buffid = tmp_videoVo.buffid;
                battleVo.sponsor = tmp_videoVo.sponsor;
                var len2:int = tmp_videoVo.targets.length;
                var targets:Vector.<IData> = new Vector.<IData>();
                var battleTarget:BattleTarget;

                for (var j:int = 0; j < len2; j++) {
                    battleTarget = new BattleTarget();
                    Data.readObject(battleTarget, tmp_videoVo.targets[j]);
                    targets.push(battleTarget);
                }
                battleVo.targets = targets;
                battleVo.skill = tmp_videoVo.skill;
                battleCommands.push(battleVo);
            }
            battleCommands.push(null);
            CommandSet.instance.init(battleCommands);
            isReturnMsg = true;
            gameStart();
        }

        public function addToRoleLayer(sp:DisplayObject, x:int, y:int):void {
            _roleLayer.addChild(sp);
            sp.x = x;
            sp.y = y;
        }

        public function addToPowerSkillLayer(sp:DisplayObject, x:int, y:int):void {
            _powerSkillLayer.addChild(sp);
            sp.x = x;
            sp.y = y;
        }

        public function addEffect(sp:DisplayObject, x:int, y:int):void {
            _effectLayer.addChild(sp);
            sp.x = x;
            sp.y = y;
        }

        /**
         * 开始战斗
         */
        private function gameStart():void {
            if (!isTweening || !isReturnMsg) {
                hidePosGrid();
                ShowLoader.add();
                return;
            }
//			if (_battleUI == null)
            {
                _battleUI = new BattleUI();
                _battleUI.addEventListener(BattleUI.PASS, onSkip);
                _uiLayerLayer.addChild(_battleUI);
            }

            var storyData:StoryConfigData;

            if (tollgateData && GameMgr.instance.sBattle)
                storyData = StoryConfigData.getStory(tollgateData.id, 1);

            if (storyData)
                _uiLayerLayer.addChild(new NewBattleWords(storyData, saidComplete));
            else
                saidComplete();

            function saidComplete():void {
                _battleUI.showBattleView();
                var vs:VSEntify = new VSEntify(_effectLayer);
                vs.onComplete.addOnce(vsComplete);
            }

            function vsComplete(vs:VSEntify):void {
                var point:int = tollgateData ? tollgateData.id : 0;
                GameMgr.instance.isGameover = false;
                _driver.starup(point);
            }
            ShowLoader.remove();
        }

        private function createMonsters(data:HeroData):void {
            var heroAnimation:Hero;

            if (data.team != HeroData.BLUE) {
                heroAnimation = BattleHeroMgr.instance.createHero(data, true, BattleAssets.instance)
                _roleLayer.addChild(heroAnimation);
            }
        }

        private function createHeroes(list:Array):void {
            var tmp_list:Array = list;
            var len:int;
            var heroData:HeroData;
            var hero:Hero;
            var help_seats:Array = [];

            if (tollgateData) {
                len = tollgateData.helpHeroList.length;

                for (i = 0; i < len; i++) {
                    heroData = tollgateData.helpHeroList[i];
                    list.push(heroData);
                    help_seats.push(heroData.seat);
                }
            }

            len = tmp_list.length;

            for (var i:int = 0; i < len; i++) {
                heroData = tmp_list[i];

                if (heroData.id > 0 && help_seats.indexOf(heroData.seat) >= 0)
                    continue;
                hero = BattleHeroMgr.instance.createHero(heroData.clone() as HeroData, false, BattleAssets.instance);

                if (help_seats.indexOf(heroData.seat) >= 0)
                    HeroDataMgr.instance.createHero(heroData);
                hero.data.copy(heroData);
                hero.data.seat = heroData.seat;
                hero.data.currenthp = hero.data.hp;
                BattleHeroMgr.instance.put(heroData.seat, hero);
                hero.startAnimation();
                hero.reastPos();
                _roleLayer.addChild(hero);
            }
        }

        private function startup():void {
            CommandSet.instance.onSkip.addOnce(function():void {
                var data:ArenaDareData = ArenaDareData.instance.getData("dare") as ArenaDareData;

                if (tollgateData && tollgateData.id < GameMgr.instance.tollgateID && GameMgr.instance.game_type == GameMgr.MAIN_LINE)
                    _battleUI.skip = true;
                else if (!data && GameMgr.instance.game_type == GameMgr.FB)
                    _battleUI.skip = true;
            });


            HeroDataMgr.instance.battleHeros.eachValue(createMonsters);
            DialogMgr.instance.open(EmBattleDlg, tollgateData, okButton, cancelButton, Dialog.OPEN_MODE_NOTHING);
        }

        private function cancelButton(obj:Object = null):void {
//			if (GameMessage.gotoTollgateBack())
//				return;

            var game_type:int = GameMgr.instance.game_type;
            switch (game_type) {
                case GameMgr.MAIN_LINE:
                    DialogMgr.instance.closeAllDialog();
                    SceneMgr.instance.changeScene(CityFace);
                    DialogMgr.instance.open(MainMapDialog);
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    break;
                case GameMgr.FB:
                    DialogMgr.instance.closeAllDialog();
                    SceneMgr.instance.changeScene(CityFace);
                    DialogMgr.instance.open(FBMapDialog);
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    break;
                case GameMgr.Arena:
                    DialogMgr.instance.closeAllDialog();
                    SceneMgr.instance.changeScene(CityFace);
                    DialogMgr.instance.open(ArenaDialog);
                    break;
                default:
                    break;
            }
        }

        /**
         * 通知服务器开始战斗
         *
         */
        private function okButton(obj:Object = null):void {
            var battle:CBattle = new CBattle();
            JTSession.isPvped = true;

            if (tollgateData) {
                switch (tollgate_type) {
                    case 0: //主线
                        battle.type = 1;
                        battle.currentCheckPoint = tollgateData.id;
                        break;
                    case 2: //副本
                        battle.type = 2;
                        battle.currentCheckPoint = tollgateData.id;
                        battle.pos = tollgate_type;
                        if (FbData.instance.number > 0) //副本剩余次数
                            FbData.instance.number--; //如果是副本战斗，副本剩余次数递减
                        break;
                }

                if (tollgateData.id > 20000)
                    battle.type = 5;

            } else if (tollgate_type == 3) {
                battle.type = 3;
                battle.currentCheckPoint = enemy_id;
            }
            battle && sendMessage(battle);
            ShowLoader.add();
        }

        private function onSkip(e:Event):void {
            _driver.skip = true;
        }

        /**
         *
         */
        override public function dispose():void {
            if (tollgate_type != 3) {
                var mainLineData:MainLineData = (MainLineData.getPoint(tollgateData.id) as MainLineData);
                SoundManager.instance.tweenVolumeSmall(mainLineData.bgm, 0.0, 1);
            } else if (tollgate_type == 3) {
                SoundManager.instance.tweenVolumeSmall("battle_bgm", 0.0, 1);
            }
            HeroDataMgr.instance.battleHeros.clear();
            BattleHeroMgr.instance.dispose();
            CommandSet.instance.onSkip.removeAll();
            GameMgr.instance.tollgateData = null;
            BattleAssets.instance.dispose();

            super.dispose();

            // now would be a good time for a clean-up
            System.pauseForGCIfCollectionImminent(0);
            System.gc();
        }
    }
}


