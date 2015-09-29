/**
 * Created by Administrator on 2014/10/28 0028.
 */
package sdk.android {
import com.langue.Langue;
import com.turbotech.PlatformSDK.SdkExtension;
import com.turbotech.PlatformSDK.SdkExtensionEvent;
import com.turbotech.PlatformSDK.SdkProxy;

import game.dialog.ShowLoader;

import sdk.base.PhoneDevice;

public class TencentAndroidDevice extends PhoneDevice{
    private var _proxy:SdkProxy;
    private var uid : String;

    public function TencentAndroidDevice(type : String)
    {
        super(type);
        _proxy = SdkExtension.getSdkProxy();
    }

    override public function init() : void
    {
        super.init();
        _proxy.addEventListener(SdkExtensionEvent.LOGIN_RECEIVED, onLoginCallback);
    }

    override public function login(onSuccess : Function, onFail : Function) : void
    {
        super.login(onSuccess, onFail);
        ShowLoader.remove();

        _proxy.login();
    }
    private function onLoginCallback(event : SdkExtensionEvent) : void
    {
        uid = String(event.data);
        super.loginCallBack(Boolean(event.loginFlag));
    }


    override public function loginOut() : void
    {
        super.loginOut();

    }

    override public function get accountId() : String
    {
        return uid;
    }

    override public function pay(productId : String, productName : String, productPrice : Number, productCount : int, pay_orderId : String,diamond:int) : void
    {
        super.pay(productId, productName, productPrice, productCount,pay_orderId,diamond);
        var order:String = this.orderId;
        _proxy.tenpay(diamond + Langue.getLangue("diamond"),order,String(productPrice));
    }
}
}
