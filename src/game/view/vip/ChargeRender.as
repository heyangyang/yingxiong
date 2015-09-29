/**
 * Created by Administrator on 2014/10/18 0018.
 */
package game.view.vip {
    import com.components.RollTips;
    import com.langue.Langue;
    import com.mobileLib.utils.DeviceType;
    import com.utils.Constants;

    import game.data.DiamondShopData;
    import game.manager.AssetMgr;
    import game.utils.Config;
    import game.view.viewBase.ChargeRenderBase;

    import sdk.AccountManager;

    import starling.events.Event;

    public class ChargeRender extends ChargeRenderBase {
        private var diamondData:DiamondShopData;

        public function ChargeRender() {
            super();
            this.addEventListener(Event.TRIGGERED, onClick);
        }

        /**
         * 充值
         * @param evt
         */
        private function onClick(evt:Event):void {
            if (evt.bubbles) {
                try {
                    AccountManager.instance.pay(diamondData.shopid.toString(), diamondData.idNume, diamondData.rmb, 1, diamondData.diamond);
                } catch (e:Error) {
                    RollTips.add(Langue.getLangue("buying"));
                }
            }
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (value == null) {
                return;
            }
            diamondData = value as DiamondShopData;

            if (diamondData) {
                if (Config.Device_Lan == Constants.EN) {
                    view.dValue.fontSize = 25;
                } else {
                    view.dValue.fontSize = 34;
                }
                view.dValue.text = diamondData.name; //diamondData.diamond + "";

                if (DeviceType.isIOS()) {
                    view.cost.text = diamondData.priceLocale + " " + diamondData.price;
                } else {
                    view.cost.text = diamondData.usd;
                }

                view.container.texture = AssetMgr.instance.getTexture(diamondData.picture);
            }
        }
    }
}
