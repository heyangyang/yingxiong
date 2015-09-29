package game.dialog {
    import com.dialog.DialogMgr;
    import com.utils.Constants;
    import com.utils.StringUtil;
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

    import game.common.JTFastBuyComponent;
    import game.manager.GameMgr;
    import game.manager.HeroDataMgr;
    import game.net.message.GoodsMessage;
    import game.view.viewBase.DialogBackgroundBase;
    import game.view.vip.VipDlg;

    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Event;

    public class DialogBackgroundView extends DialogBackgroundBase {
        private var _conten:Sprite = null;

        public function DialogBackgroundView() {
            super();
            //init();
        }

        private function init():void {
            var buyGoodsView:CommGoodsView;
            _conten = new Sprite();
            addChild(_conten);
            var datas:Array = [{moeny: String(HeroDataMgr.instance.getPower()), moneyType: 0}, {moeny: StringUtil.changePrice(GameMgr.instance.coin),
                                   moneyType: 1}, {moeny: StringUtil.changePrice(GameMgr.instance.diamond), moneyType: 2},
                               {moeny: String(GameMgr.instance.tired), moneyType: 3}];
            for (var i:int = 0; i < 4; i++) {
                buyGoodsView = new CommGoodsView();
                _conten.addQuiackChild(buyGoodsView);
                buyGoodsView.name = "buyGoodsView_" + i;
                buyGoodsView.x = i * 188;
                buyGoodsView.data = datas[i];
                buyGoodsView.addEventListener(Event.TRIGGERED, onTouch);
                if (i == 0) {
                    buyGoodsView.touchable = false;
                    buyGoodsView.addGoods.visible = false;
                    buyGoodsView.txt.width = 135;
                }
            }
            _conten.x = Constants.virtualWidth - (_conten.width + 184) >> 1;
            _conten.y = 7;

            GameMgr.instance.onUpateMoney.add(updateMoney);
            ViewDispatcher.instance.addEventListener(EventType.UPDATE_TIRED, updateMoney);
        }

        private function updateMoney():void {
            var datas:Array = [{moeny: String(HeroDataMgr.instance.getPower()), moneyType: 0}, {moeny: StringUtil.changePrice(GameMgr.instance.coin),
                                   moneyType: 1}, {moeny: StringUtil.changePrice(GameMgr.instance.diamond), moneyType: 2},
                               {moeny: String(GameMgr.instance.tired), moneyType: 3}];
            var buyGoodsView:CommGoodsView;
            for (var i:int = 0; i < 4; i++) {
                buyGoodsView = _conten.getChildByName("buyGoodsView_" + i) as CommGoodsView;
                buyGoodsView.data = datas[i];
            }
        }

        private function onTouch(e:Event):void {
            var index:int = (e.currentTarget as DisplayObject).name.split("_")[1];
            switch (index) {
                case 0:
//                    DialogMgr.instance.isVisibleDialogs(true);
//                    DialogMgr.instance.open(JTFastBuyComponent, JTFastBuyComponent.FAST_BUY_MONEY);
                    break;
                case 1:
                    DialogMgr.instance.isVisibleDialogs(true);
                    DialogMgr.instance.open(JTFastBuyComponent, JTFastBuyComponent.FAST_BUY_MONEY);
                    break;
                case 2:
                    DialogMgr.instance.open(VipDlg, VipDlg.CHARGE);
                    break;
                case 3:
                    DialogMgr.instance.isVisibleDialogs(true);
                    GoodsMessage.onBuyTiredClick();
                    break;
            }
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}
