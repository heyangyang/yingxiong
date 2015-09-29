package game.view.arena.view {
    import com.langue.Langue;
    
    import game.common.JTGlobalDef;
    import game.data.JTPVPRuleData;
    import game.data.JTPvpNewRuleData;
    import game.dialog.ShowLoader;
    import game.manager.GameMgr;
    import game.managers.JTFunctionManager;
    import game.managers.JTPvpInfoManager;
    import game.managers.JTSingleManager;
    import game.net.GameSocket;
    import game.net.data.c.CColiseumRankInfo;
    import game.view.comm.GraphicsNumber;
    import game.view.viewBase.RuleViewBase;
    
    import starling.display.Sprite;

    public class RuleView extends RuleViewBase {
        private var rank:Sprite;

        public function RuleView() {
            super();
        }

        override protected function init():void {
            var arr:Array = Langue.getLans("num_Digital");
            text_rules_title_1.text = arr[0];
            text_rules_title_2.text = arr[1];
            text_reward_title_1.text = arr[0];
            text_reward_title_2.text = arr[1];
            text_reward_title_3.text = arr[2];
            text_rules.text = Langue.getLangue("challenge_Rules");
            text_rules_1.text = Langue.getLangue("decide_he_Outcome");
            text_rules_2.text = Langue.getLangue("rank_Swap");
            text_reward.text = Langue.getLangue("award");
            text_reward_1.text = Langue.getLangue("fixed_Value");
            text_reward_2.text = Langue.getLangue("honor_Points");
            text_reward_3.text = Langue.getLangue("highest");
            text_highestRanking.text = Langue.getLangue("highest_Ranking");
            text_rankAwards.text = Langue.getLangue("current_Ranking_Award");
        }

        override protected function addListenerHandler():void {
            JTFunctionManager.registerFunction(JTGlobalDef.PVP_RANKS_LIST, onPvpRanksRsponse);
            JTFunctionManager.registerFunction(JTGlobalDef.PVP_REFRHES_HONOR, updataHonor);
        }

		/**
		 *用于挑战玩家获得的荣誉值 
		 */		
		public static var _hornor:int = 0;
		
        private function refreshMyselfInfo():void {
            var pvpInfoManager:JTPvpInfoManager = JTSingleManager.instance.pvpInfoManager;
            var pvpTemplatews:JTPvpNewRuleData = JTPvpNewRuleData.hash.getValue(pvpInfoManager.pvpLv) as JTPvpNewRuleData;
            text_strongestKing.text = pvpTemplatews.title1;
            text_rankAwards_powe.text = pvpInfoManager.hornor.toString();
			_hornor = pvpInfoManager.hornor;
            GameMgr.instance.honor = pvpInfoManager.hornor;
            text_rankAwards_diamond.text = (JTPVPRuleData.hash.getValue(pvpInfoManager.pvpLv) as JTPVPRuleData).diamon.toString();
            rank && rank.removeFromParent(true);
            rank = GraphicsNumber.instance().getNumber(pvpInfoManager.rank + 1, "ui_paihangshuzi_");
            rank.pivotX = rank.width * 0.5;
            rank.pivotY = rank.height * 0.5;
            rank.x = 433;
            rank.y = 435;
            addChild(rank);
        }

        override protected function show():void {
            var pvpInfoManager:JTPvpInfoManager = JTSingleManager.instance.pvpInfoManager;
            if (pvpInfoManager.rankList.length == 0) {
                var coliRanksPackage:CColiseumRankInfo = new CColiseumRankInfo();
                GameSocket.instance.sendData(coliRanksPackage);
                ShowLoader.add();
            } else {
                refreshMyselfInfo();
            }
        }

        private function onPvpRanksRsponse(result:Object):void {
            ShowLoader.remove();
            var pvpInfoManager:JTPvpInfoManager = JTSingleManager.instance.pvpInfoManager;
            refreshMyselfInfo();
        }

        private function updataHonor(result:Object):void {
            JTSingleManager.instance.pvpInfoManager.hornor = GameMgr.instance.honor;
            text_rankAwards_powe.text = JTSingleManager.instance.pvpInfoManager.hornor.toString();
        }

        override public function dispose():void {
            JTFunctionManager.removeFunction(JTGlobalDef.PVP_RANKS_LIST, onPvpRanksRsponse);
            rank.removeFromParent(true);
            super.dispose();
        }

    }
}
