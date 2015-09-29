package sdk.ios {
    import com.adobe.ane.productStore.Product;
    import com.adobe.ane.productStore.ProductEvent;
    import com.adobe.ane.productStore.ProductStore;
    import com.adobe.ane.productStore.Transaction;
    import com.adobe.ane.productStore.TransactionEvent;
    import com.sticksports.nativeExtensions.gameCenter.GameCenter;
    import com.view.base.event.ViewDispatcher;

    import game.data.DiamondShopData;
    import game.dialog.ShowLoader;
    import game.net.data.s.SXYLMLogin;
    import game.utils.Base64;

    import sdk.DataEyeManger;
    import sdk.base.PhoneDevice;

    import starling.animation.IAnimatable;

    /**
     * 游戏中心
     * @author hyy
     *
     */
    public class DGameCenter extends PhoneDevice {
        private var appPurchase:ProductStore;
        private var productOk:Boolean = false;
        private var _interval:IAnimatable;
        private var _count:int = 0;

        public function DGameCenter(type:String) {
            super(type);
        }

        override public function init():void {
            super.init();

            if (!GameCenter.isSupported) {
                return;
            }
            ViewDispatcher.instance.addEventListener(SXYLMLogin.CMD + "", initPay);
            GameCenter.init();
        }

        public function initPay():void {
            if (appPurchase == null) {
                appPurchase = new ProductStore();
                appPurchase.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_SUCCESS, onProductsReceived);
                appPurchase.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_CANCEL, onFailedTransaction);
                appPurchase.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_FAIL, onFailedTransaction);
                appPurchase.addEventListener(ProductEvent.PRODUCT_DETAILS_FAIL, onFailedDetails);
                appPurchase.addEventListener(ProductEvent.PRODUCT_DETAILS_SUCCESS, onSuccessDetails);
                finishTransactions(appPurchase.pendingTransactions);
                productInit();
            }
        }

        private function productInit():void {
            var len:int = DiamondShopData.list.length;
            var vector:Vector.<String> = new Vector.<String>();
            for (var i:int = 0; i < len; i++) {
                var diamond:DiamondShopData = DiamondShopData.list[i];
                vector.push(diamond.idNume);
            }
            trace(this, "productInit ", vector);
            appPurchase.requestProductsDetails(vector);
            _count++;
        }

        private function onFailedDetails(e:ProductEvent):void {
            if (!productOk && _count <= 3) {
                trace(this, "商品初始化失败，再次调用商品初始化接口 ", e);
                productInit();
            }
        }

        private function onSuccessDetails(e:ProductEvent):void {
            var products:Vector.<com.adobe.ane.productStore.Product> = e.products;
            for each (var product:Product in products) {
                DiamondShopData.updataShopData(product.identifier, product.price, product.priceLocale);
                trace(this, "动态物品数据---= " + product.identifier, product.price, product.priceLocale);
            }
            productOk = true;
        }

        private function onProductsReceived(e:TransactionEvent):void {
            trace(this, "onProductsReceived e.transactions.length: ", e.transactions.length);
            ShowLoader.remove();
            var i:uint = 0;
            var t:Transaction;
            while (e.transactions && i < e.transactions.length) {
                t = e.transactions[i];
                i++;
                appPurchase.finishTransaction(t.identifier);
                onPurchaseCallback(true, Base64.Encode(t.receipt));
            }
        }

        /**
         * 发送验证消息
         * @param verifyReceipt
         *
         */
        override protected function sendVerifyReceipt(verifyReceipt:String):void {
            trace(this, "发送验证消息 ");
            DataEyeManger.instance.onChargeSuccess(orderId);
            sendDiamondShop(verifyReceipt);
        }

        private function onFailedTransaction(e:TransactionEvent):void {
            ShowLoader.remove();
            trace(this, "onFailedTransaction", e.transactions);
            finishTransactions(e.transactions);
        }

        private function finishTransactions(list:Vector.<Transaction>):void {
            if (list == null) {
                return;
            }
            var len:int = list.length;
            var t:Transaction;

            for (var i:int = 0; i < len; i++) {
                t = list[i];
                appPurchase.finishTransaction(t.identifier);
            }
        }

        override public function login(onSuccess:Function, onFail:Function):void {
            super.login(onSuccess, onFail);
            trace(this, "GameCenter.isSupported: ", GameCenter.isSupported);
            if (!GameCenter.isSupported) {
                return;
            }
            ShowLoader.add(getLangue("login"));
            GameCenter.init();
            GameCenter.localPlayerAuthenticated.add(onSuccesComplement);
            GameCenter.localPlayerNotAuthenticated.add(onFailComplement);
            GameCenter.authenticateLocalPlayer();

            function onSuccesComplement():void {
                remove();
                trace(this, "onSuccesComplement");
                loginCallBack(true);
            }

            function onFailComplement():void {
                remove();
                trace(this, "onFailComplement");
                loginCallBack(false);
            }

            function remove():void {
                GameCenter.localPlayerAuthenticated.removeAll();
                GameCenter.localPlayerNotAuthenticated.removeAll();
            }
        }

        override public function get accountId():String {
            return GameCenter.localPlayer.id;
        }

        override public function pay(shopid:String, productName:String, productPrice:Number, productCount:int, pay_orderId:String,
                                     diamond:int):void {
            super.pay(shopid, productName, productPrice, productCount, pay_orderId, diamond);
            trace(this, "productOk: ", productOk, "productName: ", productName, "productCount: ", productCount);
            if (!productOk) {
                addTips("pay_product"); //获取商品列表
                return;
            }
            ShowLoader.add(getLangue("pay"));
            trace(this, productName, productCount);
            appPurchase.makePurchaseTransaction(productName, productCount);
        }

    }
}
