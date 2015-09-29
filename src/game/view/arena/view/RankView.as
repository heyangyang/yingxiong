package game.view.arena.view {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;

    import feathers.controls.Scroller;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.common.JTGlobalDef;
    import game.data.ConfigData;
    import game.data.HeroData;
    import game.data.JTPvpNewRuleData;
    import game.data.VipData;
    import game.dialog.ResignDlg;
    import game.dialog.ShowLoader;
    import game.manager.GameMgr;
    import game.manager.HeroDataMgr;
    import game.managers.JTFunctionManager;
    import game.managers.JTPvpInfoManager;
    import game.managers.JTSingleManager;
    import game.net.GameSocket;
    import game.net.data.c.CColiseumChance;
    import game.net.data.c.CColiseumRankInfo;
    import game.net.data.c.CColiseumReport;
    import game.net.data.c.CGetColiseumPoses;
    import game.net.data.s.SColiseumRivalFightInfo;
    import game.net.data.s.SColiseumRivalHero;
    import game.net.data.s.SColiseumSend;
    import game.net.data.vo.getColiseumPosesVO;
    import game.scene.ArenaBattleLoader;
    import game.view.arena.ArenaDialog;
    import game.view.arena.ArenaEmbattleDialog;
    import game.view.arena.ArenaRoleDialog;
    import game.view.arena.render.RankItemView;
    import game.view.comm.GraphicsNumber;
    import game.view.uitils.FunManager;
    import game.view.viewBase.RankViewBase;

    import starling.display.Sprite;
    import starling.events.Event;

    public class RankView extends RankViewBase {
        private var rank:Sprite;
        private var initData:Boolean;

        public function RankView() {
            super();
        }

        override protected function init():void {
            var names:Array = Langue.getLans("btn_rank_name");
            huanBtn_Scale9Button.text = names[1];
            zxBtn_Scale9Button.text = names[2];
            var labes:Array = Langue.getLans("title_rank_name");
            txtNumTitle.text = labes[0];
            txtFightNumTitle.text = labes[1];

            const layout:TiledRowsLayout = new TiledRowsLayout();
            layout.useSquareTiles = false;
            layout.useVirtualLayout = true;
            layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_hero.layout = layout;
            list_hero.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
            list_hero.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_hero.itemRendererFactory = tileListItemRendererFactory;
            function tileListItemRendererFactory():RankItemView {
                var itemRender:RankItemView = new RankItemView();
                itemRender.setSize(760, 98);
                return itemRender;
            }
            txtName.text = GameMgr.instance.arenaname.toString();
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            addViewListener(huanBtn_Scale9Button, Event.TRIGGERED, onClickHandler);
            addViewListener(zxBtn_Scale9Button, Event.TRIGGERED, onClickHandler);
            JTFunctionManager.registerFunction(JTGlobalDef.PVP_RANKS_LIST, onPvpRanksRsponse);
            JTFunctionManager.registerFunction(JTGlobalDef.PVP_PK_FIGHT, onPvpFightResponse);
            JTFunctionManager.registerFunction(JTGlobalDef.PVP_REFRESH_INFOS, onRefreshPVPInfosResponse);
            JTFunctionManager.registerFunction(JTGlobalDef.PVP_LOOK_HEROS, onLookHerosResponse);
            JTFunctionManager.registerFunction(JTGlobalDef.PVP_GET_BATTLE, onGetBattleHeros);
            JTFunctionManager.registerFunction(JTGlobalDef.PVP_BUY_NUM, onGetBattleBuyWars);
        }

        private function onGetBattleBuyWars(result:Object):void {
            this.txtNum.text = JTSingleManager.instance.pvpInfoManager.pvpCount.toString() + "/" + ConfigData.instance.arenaBattleMax.toString();
            var names:Array = Langue.getLans("btn_rank_name");
            if (JTSingleManager.instance.pvpInfoManager.pvpCount <= 0) {
                huanBtn_Scale9Button.text = names[0]; //购买次数
            } else {
                huanBtn_Scale9Button.text = names[1]; //换一组
            }
        }

        private function onGetBattleHeros(result:Object):void {
            ShowLoader.remove();
            var heroList:Vector.<*> = HeroDataMgr.instance.hash.values();
            var power:int = 0
            for each (var vo:getColiseumPosesVO in result.poses) {
                con: for each (var da:HeroData in heroList) {
                    if (vo.id == da.id) {
                        power += da.getPower;
                        break con;
                    }
                }
            }
            txtFightNum.text = power.toString();
        }

        private function onLookHerosResponse(result:Object):void {
            ShowLoader.remove();
            var pvpHeros:SColiseumRivalHero = result as SColiseumRivalHero;
            DialogMgr.instance.open(ArenaRoleDialog, pvpHeros);
        }

        private function onClickHandler(e:Event):void {
            switch (e.currentTarget) {
                case huanBtn_Scale9Button:
                    if (JTSingleManager.instance.pvpInfoManager.pvpCount > 0) {
                        var coliRanksPackage:CColiseumRankInfo = new CColiseumRankInfo();
                        GameSocket.instance.sendData(coliRanksPackage);
                        ShowLoader.add();
                    } else {
                        var vipData:VipData = GameMgr.instance.vipData.baseVip;
                        var buyCount:int = JTSingleManager.instance.pvpInfoManager.buyCount;
                        var needVip:int = vipData.getVipByJingjiCount(buyCount + 1);
                        var prompt:String = Langue.getLangue("buyPvpCount");
                        var money:int = FunManager.coliseum_buys(buyCount);
                        if ((buyCount + 1) >= vipData.jingji_buy && vipData.id < needVip) {
                            RollTips.add(Langue.getLangue("vip_jingji_buy").replace("*", needVip).replace("*", buyCount + 1));
                            return;
                        }
                        DialogMgr.instance.isVisibleDialogs(true);
                        var tips:ResignDlg = DialogMgr.instance.open(ResignDlg) as ResignDlg;
                        tips.text = prompt.replace("*", money);
                        tips.onResign.addOnce(onClickBuyHandler);
                    }
                    break;
                case zxBtn_Scale9Button:
                    DialogMgr.instance.open(ArenaEmbattleDialog, JTSingleManager.instance.pvpInfoManager.onbattle);
                    break;
            }
        }

        private function onClickBuyHandler():void {
            var buyPvpCountPackage:CColiseumChance = new CColiseumChance();
            GameSocket.instance.sendData(buyPvpCountPackage);
        }

        private function onPvpRanksRsponse(result:Object):void {
            ShowLoader.remove();
            var pvpInfoManager:JTPvpInfoManager = JTSingleManager.instance.pvpInfoManager;
            list_hero.dataProvider = new ListCollection(pvpInfoManager.rankList);
            refreshMyselfInfo();
        }

        /**
         * 刷新PVP信息
         * @param result 1 为PVP 2为复仇
         *
         */
        private function onRefreshPVPInfosResponse(result:Object):void {
            var coliseumSend:SColiseumSend = result as SColiseumSend;
            if (coliseumSend.type == 1) {
                var coliRanksPackage:CColiseumRankInfo = new CColiseumRankInfo();
                GameSocket.instance.sendData(coliRanksPackage);
            } else if (coliseumSend.type == 2) {
                var coliseReport:CColiseumReport = new CColiseumReport();
                GameSocket.instance.sendData(coliseReport);
            }
        }

        override protected function show():void {
            var coliRanksPackage:CColiseumRankInfo = new CColiseumRankInfo();
            GameSocket.instance.sendData(coliRanksPackage);

            var cmd:CGetColiseumPoses = new CGetColiseumPoses();
            GameSocket.instance.sendData(cmd);
            ShowLoader.add(); //请求防守阵型
        }

        private function refreshMyselfInfo():void {
            var pvpInfoManager:JTPvpInfoManager = JTSingleManager.instance.pvpInfoManager;
            var pvpTemplatews:JTPvpNewRuleData = JTPvpNewRuleData.hash.getValue(pvpInfoManager.pvpLv) as JTPvpNewRuleData;
            txtName.text = pvpTemplatews.title1;
            this.txtNum.text = pvpInfoManager.pvpCount.toString() + "/" + ConfigData.instance.arenaBattleMax.toString();
            rank && rank.removeFromParent(true);
            rank = GraphicsNumber.instance().getNumber(pvpInfoManager.rank + 1, "ui_paihangshuzi_");
            rank.pivotX = rank.width * 0.5;
            rank.pivotY = rank.height * 0.5;
            rank.x = 542;
            rank.y = 181;
            addChild(rank);

            var names:Array = Langue.getLans("btn_rank_name");
            if (pvpInfoManager.pvpCount <= 0) {
                huanBtn_Scale9Button.text = names[0] //购买次数
            } else {
                huanBtn_Scale9Button.text = names[1]; //换一组
            }
        }

        /**
         * 进入战斗
         * @param result
         *
         */
        private function onPvpFightResponse(result:Object):void {
            var pvpInfoManager:JTPvpInfoManager = JTSingleManager.instance.pvpInfoManager;
            var fightInfo:SColiseumRivalFightInfo = result as SColiseumRivalFightInfo;
            pvpInfoManager.enemy_info = pvpInfoManager.getRankInfoById(fightInfo.id);
            ArenaBattleLoader.showBattle(0, fightInfo.id, fightInfo.messege);
            (this.parent as ArenaDialog).close();
        }

        override public function dispose():void {
            JTFunctionManager.removeFunction(JTGlobalDef.PVP_RANKS_LIST, onPvpRanksRsponse);
            JTFunctionManager.removeFunction(JTGlobalDef.PVP_PK_FIGHT, onPvpFightResponse);
            JTFunctionManager.removeFunction(JTGlobalDef.PVP_REFRESH_INFOS, onRefreshPVPInfosResponse);
            JTFunctionManager.removeFunction(JTGlobalDef.PVP_LOOK_HEROS, onLookHerosResponse);
            JTFunctionManager.removeFunction(JTGlobalDef.PVP_GET_BATTLE, onGetBattleHeros);
            list_hero && list_hero.removeFromParent(true);
            rank && rank.removeFromParent(true);
            super.dispose();
        }

    }
}
