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

    public class DAndroidDevice extends PhoneDevice {
        public function DAndroidDevice(type:String) {
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
                HttpClient.send("http://211.72.249.246/charge.php", {mod: "callback", act: Config.android_Fun_ft, payment_method: "google_play",
                                    data: encodeURI(e.data), sign: encodeURI(e.sign)}, onComplement, null, "post");

                function onComplement(returnObj:String):void {
                    if (returnObj == "success")
                        addTips("buySuccess");
                    else
                        addTips("buyLose");
                }
            }
            //onPurchaseCallback(true, Base64.Encode(data.receipt));
        }

        override public function pay(productId:String, productName:String, productPrice:Number, productCount:int, pay_orderId:String,
                                     diamond:int):void {

            super.pay(productId, productName, productPrice, productCount, pay_orderId, diamond);
            var ns:Namespace = NativeApplication.nativeApplication.applicationDescriptor.namespace();
            var key:String;

            var applicationDescriptor:String = String(NativeApplication.nativeApplication.applicationDescriptor.ns::id);

            if (applicationDescriptor == 'com.turbotech.mengshoutang.fun') {
                key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAomchDNqoGHCj+uKX1wpo4OFhyDQYMVWzj1+NlJvf3rv8Fx8gXKAWm+5FmX7uF1EPOBoXzi94WwNaZuvHQUFwJMkU+Q9/h6k+wLwnygJFEhc5+9NuAPjHRd8rSTkvBZqSfzJKuRPt7U2Lt4CQPbiDK9ltcquAC7x8ovwC30G0xI/ItonQ7+cQmIbDsDgHo2kkZLhyuXX00JRHlBgMCBst0F6LhhRR43SVdy/yQAAO5BXrQGuDJghz3iRmTDBl/vsClKnqjmAUyN7VgaKy1/dDHISSpMGQNavZJT/EGWelndDrbKTX8DqB2EGrgDyOl4yU0rTYNo5EkGa2Z87uMDvY6QIDAQAB";
            } else if (applicationDescriptor == 'com.turbotech.mengshoutang.fun2') {
                key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAz69HtW2SN84buGVj2VM3xDw/BvCejkXdmZ/F3oJNeEvm7C+PcE8kUvAYzcK0wV/6NxkiXZrCX0L0XYCSXgVppdA/KCPHFLkfjPXbtkyCLPqmh2ccusYwc6Rtj4ndOcz6u2B0fcbwCVI7i9Z445AGMKx7dPcA3ETpPo5TozcAKOV2Yj/gD0lB+H5HmF8ZkyJBvpM6xw6d+gtd2OkZsYm3zBK0n3gqKeKdHe5nIjnDULE3LtPD6yKcRFxkK2x4xlIgymPRNXy0jur8YqBKScwUDqbgKY5T66Vd0kqjYWG0z6Y6qdpoXYc5Pl3pSg1svQlIMKwst+6SBp/bStEjkjQp1wIDAQAB";
            } else if (applicationDescriptor == 'com.turbotech.mengshoutang.fun3') {
                key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApNq3qvWVVEAnmAuVQe1mMOiWynwM/qXgMtuvXwLrwFS+89/Acv4AqPzmdVjAG2sdAiOYycBXE8Izl9/11SMIMDc5xv0G10sB4we7YJk0mNeNi403iqMjtblL656hzkjA0p6v5IPeZ4sBxfwwBh5uNqL9N59YZxRFNEyMVAcmZE/KE3Cw4Pct7XwooaAvFmt/wwOhCLoNFAgDYxThNWpaJuIRFTg4E/F2A+x2ySFcS8N6kR/ef66ZC/lFfGs1OAg3k6pPHe8RBbMfUZQmrBEndxLzQCLacjLm+Bsbcnj+7JRo6MWXe4DfvCvrwomJHd0qGHIsprcT1XlvN8pkx3avMwIDAQAB";
            } else if (applicationDescriptor == 'com.turbotech.mengshoutang.fun4') {
                key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAz3/Ya/inH/Kjm6yFHIPdzO+aOoA6USglM4gkRfXKFMqnoz1ckxEIM98cvff7R8o2YuWD87WbpHSkni/O1JMSkLvXGXPknT5LUusW7Jl+7PU09ufIV74RLHKEeeHNO25WxO8KJJUGVlAslD+Kua828iUiZPvvHsvttpO+ouq1AiGtQoNgithlB9xbXX3Pk4GPYNFWQmboT21hdXNo7ib5tR78xi58mgSTuvgFGABKVbsTo/KP9sHEM1yPQNMoFWJTfJNDtVe/NqzjSYbNUD93d6jxrNWIIzZVV3rhgOyXVOTeD1FTMRRWq9PZUSlm4cp2G8+MgrskjpovaIaFB5JDPwIDAQAB";
            } else if (applicationDescriptor == 'com.turbotech.mengshoutang.fun5') {
                key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAte6+SqTeIS2s8rveOBfXXlHJSR3+4VW5VD0KL43wxlCfllrcnvWc0k3v6qMjscuk4CwuAwJumXNyKFWUCgH+i94zUcZmvXo8JnHpMC0oKOO0/FpEusxPRlZ4/DDG3tTxOfJdtQrTBdukdKYT/+EMulSJ2Y0YiA51uEeaj57QuGC8CaM7QpBHbNNbbgjhnEHnY1wAdDmucC8pCKUC6bXP/xNFSB+FEXugljhwXMTsvp4duFNU0wQJKg8nB9ifdGrdJICSspg6GHJ9dvzgpZXKQDOfTntIsO8Mfyh5Swroa9T/znRy1fr3cYT+v8nxoyWlDpaL7S0dVD2SvobUP3o5qQIDAQAB";
            } else if (applicationDescriptor == 'com.turbotech.mengshoutang.fun6') {
                key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAutmcdMONhvANey7xEG/fclhqwKKMAC4CvrhmcAZg6GOeTvwHaUt0Lqege+uT4Wjh0WNzBK8GHWNldDBWW0unFpA+NFarMl8fqb0v+kWJHnnwAwafaPyv//I2du/ycq213O2sn/1ELskRiQ0Xl18tWLsDLStqHBVR2E6r6mwJhwCcQetaIIAxDxNr/NR03efU9LDJQMuctU+Z6UjqhM5ylnUXOciVjwR0ETpth1YSZWjtGiyvMsOaVA4fJouw+lW8chU5nwIgGKcPJ1DpvUK0T/h54iGcsu3vjq4+3oN/4iNpJkNRL0kzmxPrpqzPa6z8hXgTSiKkHttcjJ2Ft2PPEwIDAQAB";
            } else if (applicationDescriptor == 'com.turbotech.mengshoutang.fun7') {
                key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAisFIyxgn+7n1aXAmei4rsl8QKJb+yGvRprmYbd+vNMjfgS5DahdqQRLbwtAiisbjbT+prpDg90LeA5NQ9o/RWxJh2bGZ+mMVVwMjKqa2WGSTfuQru5vIsr3EzP7D3igk5sVo05IMiUvvLNtNi0+28WNWtP5B8ANwSiLRCyGPLCScBbSspKIGMIC6gS+RPOHsX/wluIy15T2/b6n1Z7hSoE0u2vNZOs1hvJrN3u0hYjH+LJyaOGQtBR490hYE7bDERYd/G5Au71vWgdIq3HF8LOqll8f51XcCZTE/u5oBJXLS5pMNDa2yJqAgzB3jTWHVoVXAXCLsMV5zs6gYCw78fwIDAQAB";
            } else if (applicationDescriptor == 'com.turbotech.mengshoutang.fun8') {
                key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyVdup3ld4ay4UWW+OVekFkc7m/ZehgAncUzrl9Io2hN8no6zkPbbgvLFInerAsH9Q/4DqAkjgU1zAdT6k3szQKIWgi2A950JlPFWS9kfu1pu8YKjAhdDC/FZ20avu4+rh+rSgassaq4stT2UUK3Hc8i34Ekvt3MlkemfsMrBzFvhcVvvsERswEpgqKvreL+POK7uZNVz1CfCs/uMolKdtY9ayrJe4thrAIGYyB9chGpcV+BAniNWHELIPmCNTO9mkf+QeXpzGEh5BRi31GMyXgvJvLaKF2peXXS0R8iJgcrfHWUO8ccQw3h5/FesT3FYrb2ZiS4E85ztCyQWBCjCBwIDAQAB";
            }

            trace(this, productName, pay_orderId, key);
            sdkProxy.pay(productName, pay_orderId, key);
        }
    }
}
