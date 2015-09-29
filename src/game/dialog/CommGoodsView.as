package game.dialog {
    import com.dialog.DialogMgr;
    import com.utils.StringUtil;
    import com.view.base.event.EventType;

    import game.common.JTFastBuyComponent;
    import game.common.JTGlobalDef;
    import game.manager.GameMgr;
    import game.manager.HeroDataMgr;
    import game.managers.JTFunctionManager;
    import game.net.message.GoodsMessage;
    import game.view.heroHall.HeroDialog;
    import game.view.uitils.Res;
    import game.view.viewBase.CommGoodsBase;
    import game.view.vip.VipDlg;

    import starling.events.Event;

    public class CommGoodsView extends CommGoodsBase {
        private var _type:int = 0;

        /**
         *
         * @param type 0战斗力 1金币 2钻石  7疲劳
         *
         */
        public function CommGoodsView(type:int) {
            _type = type;
            super();
            btn_bg.container.addChild(txt);
            btn_bg.container.addChild(icon_type);
            btn_bg.container.addChild(addGoods);
            icon_type.texture = Res.instance.getCommTexture(type);
            addEventListener(Event.TRIGGERED, onTouch);
            updata();
        }

        private function updata():void {
            switch (_type) {
                case 0:
                    txt.text = HeroDataMgr.instance.getPower().toString();
                    addContextListener(EventType.UPDATE_POWER, updateText);
                    break;
                case 1:
                    txt.text = StringUtil.changePrice(GameMgr.instance.coin);
                    addContextListener(EventType.UPDATE_MONEY, updateText);
                    break;
                case 2:
                    txt.text = StringUtil.changePrice(GameMgr.instance.diamond);
                    addContextListener(EventType.UPDATE_MONEY, updateText);
                    break;
                case 7:
                    txt.text = GameMgr.instance.tired.toString() + "/100";
                    addContextListener(EventType.UPDATE_TIRED, updateText);
                    break;
            }
        }

        private function updateText():void {
            switch (_type) {
                case 0:
                    txt.text = HeroDataMgr.instance.getPower().toString();
                    break;
                case 1:
                    txt.text = StringUtil.changePrice(GameMgr.instance.coin);
                    break;
                case 2:
                    txt.text = StringUtil.changePrice(GameMgr.instance.diamond);
                    break;
                case 7:
                    txt.text = GameMgr.instance.tired.toString() + "/100";
                    break;
            }
        }

        private function onTouch(e:Event):void {
            switch (_type) {
                case 0: //战斗力
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(HeroDialog, null, null, cancelHandler);
                    break;
                case 1: //金币
                    DialogMgr.instance.isVisibleDialogs(true);
                    DialogMgr.instance.open(JTFastBuyComponent, JTFastBuyComponent.FAST_BUY_MONEY);
                    break;
                case 2: //钻石
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(VipDlg, VipDlg.CHARGE, null, cancelHandler);
                    break;
                case 7: //疲劳值
                    DialogMgr.instance.isVisibleDialogs(true);
                    GoodsMessage.onBuyTiredClick();
                    break;
            }
        }


        /**改变时显示元素*/
        private function cancelHandler(e:*):void {
            JTFunctionManager.executeFunction(JTGlobalDef.PLAY_CITY_ANIMATABLE);
        }
    }
}
