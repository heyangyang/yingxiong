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

    public class GameStartIosFT extends GameStartIosBase {
        public function GameStartIosFT() {
            HttpServerList.ServerListAddress = "http://42.62.14.78/ctrl/servers.php";
            HttpServerList.VervionCheckAddress = "http://42.62.14.78/ctrl/check.php";
            PushNotifications.PushAddress = "http://42.121.111.191/push/";

            DataDecompress.ShopDataType = "diamond_shop";
            ConverURL.AssetsRoot = "assets_ios_ft/";
//            ConverURL.AssetsRoot = "assets_ft/";

            Config.Device_Lan = Constants.FT;

            Config.data_version = "data_ios_FT_2_0_4";
            var str:String = new String(new Assets.Dirtyword());
            WordFilter.instance.init(str);

            addEventListener(Event.ADDED_TO_STAGE, onAdd);
            super(Config.ios_FT, DGameCenter);
        }

        private function onAdd(evt:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAdd);
        }
    }
}
