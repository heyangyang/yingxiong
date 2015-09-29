/**
 * Created by Administrator on 2014/9/30 0030.
 */
package game.view.luckyStar {
    import com.langue.Langue;
    import game.view.viewBase.LuckyRankBase;
    import starling.core.Starling;
    import starling.display.DisplayObjectContainer;

    /**
     *幸运星财富排行榜
     * @author Administrator
     */
    public class LuckyRankDlg extends LuckyRankBase {
        public function LuckyRankDlg() {
            super();
        }

        override protected function init():void {
            userNameTxt.text = Langue.getLangue("Game_Players"); //玩家
            starTxt.text = Langue.getLangue("buyLucky"); //幸运星
            valueTxt.text = Langue.getLangue("The_Total_Value"); //总价值
            nameListTxt.text = Langue.getLangue(""); //最近获奖名单
            nTxt.text = Langue.getLangue("Game_Players"); //玩家
            rewardTxt.text = Langue.getLangue("Game_Prizes"); //奖品
            view_1.visible = false;
            view_2.visible = false;
            clickBackroundClose();
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
            this.y -= 30;
            Starling.juggler.delayCall(function():void {
                addChild(new RichList);
                addChild(new LastList);
            }, 0.2);
        }
    }
}
