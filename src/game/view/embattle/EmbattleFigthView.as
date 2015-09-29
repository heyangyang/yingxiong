package game.view.embattle {
    import com.langue.Langue;

    import game.view.viewBase.EmbattleFigthViewBase;

    public class EmbattleFigthView extends EmbattleFigthViewBase {
        public function EmbattleFigthView() {
            super();
        }

        override protected function init():void {
            txt_des1.text = Langue.getLangue("Hero"); //英雄
            txt_des2.text = Langue.getLangue("useup"); //消耗
            txt_des3.text = Langue.getLans("Our_combat_power")[0]; //我方战力
            txt_des4.text = Langue.getLans("Our_combat_power")[1]; //敌方战力
            auto__Scale9Button.text = Langue.getLangue("autoEmbattle"); //自动布阵
            battle__Scale9Button.text = Langue.getLangue("Into_battle"); //进入战斗
        }
    }
}
