package {
    import com.langue.WordFilter;
    import com.mobileLib.utils.ConverURL;
    import com.utils.Assets;
    import com.utils.Constants;

    import game.data.DataDecompress;
    import game.utils.Config;
    import game.utils.HttpServerList;

    import sdk.PushNotifications;
    import sdk.android.DAndroidHttpServer;
    import sdk.android.DGoogleFTDevice;

    public class GameStartGoogle_FT extends GameStartAndroidBase {
        public function GameStartGoogle_FT() {
            HttpServerList.ServerListAddress = "http://42.62.14.78/ctrl/servers.php";
            HttpServerList.VervionCheckAddress = "http://42.62.14.78/ctrl/check.php";
            PushNotifications.PushAddress = "http://42.121.111.191/push/";

            DataDecompress.ShopDataType = "diamond_shop";
            ConverURL.AssetsRoot = "assets_android_ft/";
//            ConverURL.AssetsRoot = "assets_ft/";
            Config.data_version = "data_google_FT";

            Config.Device_Lan = Constants.FT;

            var str:String = new String(new Assets.Dirtyword());
            WordFilter.instance.init(str);

            super(Config.google_ft, DGoogleFTDevice);
        }

        override protected function changeYingxiong():void {
            DAndroidHttpServer.getInstance().getSession();
            addChild(new Main());
        }
    }
}
