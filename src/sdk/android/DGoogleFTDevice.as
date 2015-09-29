package sdk.android {
    import com.turbotech.PlatformSDK.SdkExtension;
    import com.turbotech.PlatformSDK.SdkExtensionEvent;
    import com.turbotech.PlatformSDK.SdkProxy;
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

    import flash.desktop.NativeApplication;

    import game.utils.Config;
    import game.utils.HttpClient;

    import sdk.base.PhoneDevice;

    import starling.events.Event;

    public class DGoogleFTDevice extends PhoneDevice {
        public function DGoogleFTDevice(type:String) {
            super(type);
        }

        private var sdkProxy:SdkProxy;

        override public function init():void {
            super.init();
            ViewDispatcher.instance.addEventListener(EventType.GOTO_WEB, gotoWebHandler);
            ViewDispatcher.instance.addEventListener(EventType.UPDATE_PACKAGE, updatePackHandler);
            sdkProxy = SdkExtension.getSdkProxy(); //创建extension
            sdkProxy.addEventListener(SdkExtensionEvent.PAY_RECEIVED, onPayCallback);
        }

        private function gotoWebHandler(evt:Event, url:String):void {
            sdkProxy.web(url);
        }

        private function updatePackHandler(evt:Event, url:String):void {
            sdkProxy.market(url);
        }

        private function onPayCallback(e:SdkExtensionEvent):void {
            if (e.payFlag) {
                HttpClient.send("http://211.72.249.246/charge.php", {mod: "callback", act: Config.google_ft, payment_method: "google_play",
                                    data: encodeURI(e.data), sign: encodeURI(e.sign)}, onComplement, null, "post");

                function onComplement(returnObj:String):void {
                    if (returnObj == "success")
                        addTips("buySuccess");
                    else
                        addTips("buyLose");
                }
            }
//            onPurchaseCallback(true, Base64.Encode(data.receipt));
        }

        override public function pay(productId:String, productName:String, productPrice:Number, productCount:int, pay_orderId:String,
                                     diamond:int):void {

            super.pay(productId, productName, productPrice, productCount, pay_orderId, diamond);
            trace(this, " super.pay----" + productId, productName, productPrice, productCount, pay_orderId, diamond);
            var ns:Namespace = NativeApplication.nativeApplication.applicationDescriptor.namespace();
            var key:String;

            var applicationDescriptor:String = String(NativeApplication.nativeApplication.applicationDescriptor.ns::id);

            if (applicationDescriptor == 'com.turboo.qmms.google') {
                key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzSKUrCY1Jodb3oLvMenzYQ0lQPNqbu5Ly4wCjLOGBloBO92wJu5pAqi0z0HPBHtsYAVeItEhHrJo8coHFZje6H3JN9Vo+Zu3oKKOEYFMa2sbsAVKUyrQg2T9c4mB/cWCksloiYwEHV5A72K+NhuPOUvB9Q/EU8ZHGAkhiXrQ5NxwNmWWwRjy1LpsH9OhoTr3gmuZ8ClTlvsY1/dk2d3IIiytmkmUaiCPGLcMpWo/nDIQvnlIaBVO6i6LQK2TGhoNgaZwuhih+Zl+N/P6O2O1zIxsGjvAqT3hwo65nLxphCRjhpnJQE7/pyJW69namQ31VmXtAvZGclDHUURGvmahUQIDAQAB";
            }
            trace(this, productName, pay_orderId, key);
            sdkProxy.pay(productName, pay_orderId, key);
        }
    }
}
