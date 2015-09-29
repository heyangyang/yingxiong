package game.scene {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.mvc.core.Facade;
    import com.mvc.interfaces.INotification;
    import com.scene.SceneMgr;
    import com.singleton.Singleton;

    import feathers.core.PopUpManager;

    import game.common.JTSession;
    import game.dialog.ShowLoader;
    import game.hero.AnimationCreator;
    import game.manager.BattleAssets;
    import game.manager.GameMgr;
    import game.manager.HeroDataMgr;
    import game.net.GameSocket;
    import game.net.data.IData;
    import game.net.data.c.CArena_RivalFightInfo;
    import game.net.data.s.SArena_RivalFightInfo;
    import game.view.arena.ArenaDareData;
    import game.view.data.Data;

    public class ArenaBattleLoader extends BattleLoader {
        private var _id:int; //对手ID
        private var _name:int;

        public const bgm:String = "battle_bgm";
        public const scene:String = "map_013";

        override public function listNotificationName():Vector.<String> {
            var vect:Vector.<String> = new Vector.<String>;
            vect.push(SArena_RivalFightInfo.CMD);
            return vect;
        }

        override public function handleNotification(_arg1:INotification):void {
            if (_arg1.getName() == String(SArena_RivalFightInfo.CMD)) {
                var fightInfo:SArena_RivalFightInfo = _arg1 as SArena_RivalFightInfo;

                if (fightInfo.code == 0) {
//                    DialogMgr.instance.closeAllDialog();
//                    SceneMgr.instance.changeScene(LoadingScene);
                    ShowLoader.add();
                    HeroDataMgr.instance.createRival((_arg1 as SArena_RivalFightInfo).messege, _name);

                    loadMap(scene, bgm, onComplete);
                    function onComplete():void {
                        AnimationCreator.instance.loadRiv(onLoaded, BattleAssets.instance);
                    }

                    function onLoaded():void {
                        dispose();
                        DialogMgr.instance.closeAllDialog();

                        SceneMgr.instance.changeScene(BattleScene, {"tollgate": 0, "pos": 3, "id": _id});

                        ShowLoader.remove();
                    }
                } else if (fightInfo.code == 1) {
                    RollTips.add(Langue.getLangue("arenaNumBuy"));
                } else if (fightInfo.code == 2) {
                    RollTips.add(Langue.getLangue("JieBangNoenough"));
                } else if (fightInfo.code == 3) {
                    RollTips.add(Langue.getLangue("No_Challenge_yourself"));
                } else if (fightInfo.code >= 127) {
                    RollTips.add(Langue.getLangue("codeError") + fightInfo.code);
                }
            }
            ShowLoader.remove();
        }

        /**
         * 战斗 此接口为PVP中使用，有
         * @param name
         * @param id
         * @param messages
         *
         */
        public static function showBattle(name:int, id:int, messages:Vector.<IData>):void {
            GameMgr.instance.game_type = GameMgr.Arena;
            var battleLoading:ArenaBattleLoader = new ArenaBattleLoader();
//            DialogMgr.instance.closeAllDialog();
//            PopUpManager.removePopUps();
//            SceneMgr.instance.changeScene(LoadingScene);
            ShowLoader.add();

            HeroDataMgr.instance.createRival(messages, name);
            battleLoading.loadMap(battleLoading.scene, battleLoading.bgm, onComplete);
            function onComplete():void {
                AnimationCreator.instance.loadMeSelfBattleHeros(HeroDataMgr.instance.getOnBattleHero(), BattleAssets.instance);
                AnimationCreator.instance.loadRiv(onLoaded, BattleAssets.instance);
            }

            function onLoaded():void {
                battleLoading.dispose();
                DialogMgr.instance.closeAllDialog();
                JTSession.isPvp = true;
                PopUpManager.removePopUps();

                SceneMgr.instance.changeScene(BattleScene, {"tollgate": 0, "pos": 3, "id": id});
            }
        }

        /**
         *
         * @param id 对手ID。
         * @param type 1正常挑战，2反击，3揭榜
         * @param name 0，是怪物，1是英雄
         *
         */
        override public function load(id:int, type:int = 0, name:int = 0):void {

            HeroDataMgr.instance.battleHeros.clear();
            GameMgr.instance.game_type = GameMgr.Arena;
            initObserver();
            var cmd:CArena_RivalFightInfo = new CArena_RivalFightInfo;
            cmd.id = id;
            cmd.type = type;
            _id = id;
            _name = name;
            (Data.instance.getData("dare") as ArenaDareData).type = type;
            GameSocket.instance.sendData(cmd);
            ShowLoader.add();
        }

        override public function dispose():void {
            removeObserver();
            Singleton.remove(this);
            super.dispose();
        }

        /**
         *
         */
        override protected function initObserver():void {
            var vector:Vector.<String> = listNotificationName();
            var len:int = vector.length;

            for (var i:int = 0; i < len; i++) {
                var name:String = vector[i];
                Facade.addObserver(name, this);
            }
        }
    }
}
