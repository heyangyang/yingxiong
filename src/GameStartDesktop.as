/**
 * Created by Administrator on 2014/9/16 0016.
 */
package
{
	import com.langue.WordFilter;
	import com.mobileLib.utils.ConverURL;
	import com.utils.Assets;

	import flash.display.Sprite;

	import game.data.DataDecompress;
	import game.utils.Config;
	import game.utils.HttpServerList;

	import sdk.PushNotifications;

	public class GameStartDesktop extends Sprite
	{
		public function GameStartDesktop()
		{
			HttpServerList.ServerListAddress = "http://42.62.14.78/ctrl/servers.php";
			HttpServerList.VervionCheckAddress = "http://42.62.14.78/ctrl/check.php";
			PushNotifications.PushAddress = "http://42.121.111.191/push/";

			DataDecompress.ShopDataType = "diamond_shop";
			ConverURL.AssetsRoot = "assets/";
			ConverURL.AssetsRoot = "assets_atf/";

			Config.data_version = "data_ios_2_0_0";

			var str : String = new String(new Assets.Dirtyword());
			WordFilter.instance.init(str);
			Config.device = Config.windows;

			addChild(new Main());
		}
	}
}
