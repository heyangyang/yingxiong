package sdk.android
{
import com.components.RollTips;
import com.dialog.DialogMgr;
import com.langue.Langue;
import com.mobileLib.utils.ConverURL;
import com.turbotech.PlatformSDK.SdkExtension;
import com.turbotech.PlatformSDK.SdkExtensionEvent;
import com.turbotech.PlatformSDK.SdkProxy;

import game.dialog.ShowLoader;

import sdk.AlipayAndroid;
import sdk.base.PhoneDevice;

import starling.utils.AssetManager;

/**
	 * 360平台
	 * @author hyy
	 *
	 */
	public class AlipayAndroidDevice extends PhoneDevice
	{
		private var uid : String;
        private var _proxy:SdkProxy;
		public function AlipayAndroidDevice(type : String)
		{
            super(type);
            _proxy = SdkExtension.getSdkProxy();
		}

		override public function init() : void
		{
			super.init();
            _proxy.addEventListener(SdkExtensionEvent.ERROR, onError);
        }

        private function onError(event : SdkExtensionEvent) : void
        {
            RollTips.add(event.error);
        }

		override public function get accountId() : String
		{
			return uid;
		}



		override public function pay(productId : String, productName : String, productPrice : Number, productCount : int, pay_orderId : String,diamond:int) : void
		{
			super.pay(productId, productName, productPrice, productCount,pay_orderId,diamond);

            var order:String = this.orderId;
            ShowLoader.add();
            var asstes:AssetManager = new AssetManager();
            asstes.enqueue(ConverURL.conver("newUi/chongzhi/"));
            asstes.loadQueue(onComplete);
            AlipayAndroid.assets = asstes;
            function onComplete(tmp_ratio:Number):void {
                if (tmp_ratio == 1.0) {
                    var dialog:AlipayAndroid =  DialogMgr.instance.open(AlipayAndroid) as AlipayAndroid;
                    dialog.onYinLan.add(onYinLianHdr);
                    dialog.onAlipay.add(onAlipayHdr);
                    ShowLoader.remove();
                }
            }

             function onAlipayHdr(obj:Object):void {
                 trace("onAlipayHdr",productId,orderId,String(productPrice));
                _proxy.alipay(diamond + Langue.getLangue("diamond"),order,String(productPrice));
            }

            function onYinLianHdr(obj:Object):void {
                trace("onYinLianHdr",productId,orderId,String(productPrice));
                _proxy.unionpay(diamond + Langue.getLangue("diamond"),order,String(productPrice));
            }
		}


	}
}