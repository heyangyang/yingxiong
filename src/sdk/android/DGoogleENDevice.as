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

    public class DGoogleENDevice extends PhoneDevice {
        public function DGoogleENDevice(type:String) {
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
                HttpClient.send("http://211.72.249.246/charge.php", {mod: "callback", act: Config.google_en, payment_method: "google_play",
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

            if (applicationDescriptor == 'com.turboo.qmfben.google') {
                key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAip/TZWUzVhYyB0YkS5fbyHrV5lI/4MMw6QWgqUqTjEYzDElIeWQO4q0joiaCr/hNjJJx8s89wq+JA5+M6K8jOiGxzwE7OyF+dt8VJJBoq3dzV2k/aghs5qQjH3tqDVN99+lAa+jU4tm9ikpmURODSe/4gCEjti5/z44i1zTDBwW1KDmp/yxC64qyo49WH3E29cTLwJsbKe5HvipJMYmFn5MDhqFcJIb3wHqczxrKD/6+GcaCxbAbzdvre1HEbkszNdXrFB+cYfpHh9Yly2VIH8BGkaxtT5BShuL/cJT/119aahsTvDsJBCp+pnuVFwxa9zY+o2Oll2BJtjw1auV1RwIDAQAB";
            }
            trace(this, productName, pay_orderId, key);
            sdkProxy.pay(productName, pay_orderId, key);
        }
    }
}
