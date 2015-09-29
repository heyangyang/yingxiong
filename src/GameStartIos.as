package {
    import com.langue.WordFilter;
    import com.mobileLib.utils.ConverURL;
    import com.utils.Assets;
    import com.utils.Constants;

    import flash.events.Event;

    import game.data.DataDecompress;
    import game.utils.Config;
    import game.utils.HttpServerList;

    import sdk.PushNotifications;
    import sdk.ios.DGameCenter;

    public class GameStartIos extends GameStartIosBase {
        public function GameStartIos() {
            HttpServerList.ServerListAddress = "http://42.62.14.78/ctrl/servers.php";
            HttpServerList.VervionCheckAddress = "http://42.62.14.78/ctrl/check.php";
            PushNotifications.PushAddress = "http://42.121.111.191/push/";

            DataDecompress.ShopDataType = "diamond_shop";
            ConverURL.AssetsRoot = "assets_ios/";
//            ConverURL.AssetsRoot = "assets/";
            Config.Device_Lan = Constants.JT;

            Config.data_version = "data_ios_2_0_0";
            var str:String = new String(new Assets.Dirtyword());
            WordFilter.instance.init(str);

            addEventListener(Event.ADDED_TO_STAGE, onAdd);
            super(Config.ios, DGameCenter);
        }

        private function onAdd(evt:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAdd);
        }
    }
}
