package
{
import com.langue.WordFilter;
import com.mobileLib.utils.ConverURL;
import com.utils.Assets;
import com.utils.Constants;

import game.data.DataDecompress;
import game.utils.Config;
import game.utils.HttpServerList;

import sdk.android.AlipayAndroidDevice;

public class GameStartTurbo extends GameStartAndroidBase
	{
		public function GameStartTurbo()
		{
            HttpServerList.ServerListAddress = "http://42.62.14.78/mst/servers.php";
            HttpServerList.VervionCheckAddress = "http://42.62.14.78/mst/check.php";
//            PushNotifications.PushAddress = "http://42.121.111.191/push/";
            DataDecompress.ShopDataType = "diamond_shop";
//            ConverURL.AssetsRoot = "assets/";
            ConverURL.AssetsRoot = "assets_360/";
//            Config.dev_account_login=true;
            Config.data_version= "data_qmms_201411141134";
//            FontJFData.init(new Assets.jf_map_data());
            var str:String=new String(new Assets.Dirtyword());
            WordFilter.instance.init(str);
            Config.isAccountPreName = true;
			super(Config.android_turbo, AlipayAndroidDevice, false);
		}
	}
}