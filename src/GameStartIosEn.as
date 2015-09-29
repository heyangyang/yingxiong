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

    public class GameStartIosEn extends GameStartIosBase {
//        iOS繁体版相关修改：
//        推送ID保存地址：http://203.90.235.82/push/
//        服务器信息相关请求地址：
//        http://203.90.235.82/mst/servers.php
//        http://203.90.235.82/mst/check.php
//        http://203.90.235.82/mst/check_assets.php

        public function GameStartIosEn() {
            HttpServerList.ServerListAddress = "http://42.62.14.78/ctrl/servers.php";
            HttpServerList.VervionCheckAddress = "http://42.62.14.78/ctrl/check.php";
            PushNotifications.PushAddress = "http://42.121.111.191/push/";

            DataDecompress.ShopDataType = "diamond_shop";
            ConverURL.AssetsRoot = "assets_ios_en_atf/";
//            ConverURL.AssetsRoot = "assets_en/";

            Config.data_version = "data_qmfb_en_1_0_0";
            Config.Device_Lan = Constants.EN;
            var str:String = new String(new Assets.Dirtyword());
            WordFilter.instance.init(str);

            addEventListener(Event.ADDED_TO_STAGE, onAdd);
            super(Config.ios_EN, DGameCenter);
        }

        private function onAdd(evt:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAdd);
        }
    }
}
