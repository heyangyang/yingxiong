package game.utils
{

	/**
	 * 客户端配置文件
	 * @author hyy
	 *
	 */
	public class Config
	{
		//Windows
		public static const windows : String = "windows";
		public static var device : String = "windows";

		//IOS
		public static const ios : String = "i_qmms";
		public static const ios_FT : String = "i_qmfb";
		public static const ios_EN : String = "i_qmfben";

		//Google
		public static const google_ft : String = "a_google";
		public static const google_en : String = "a_gen";

		//Android
		public static const android_tencent : String = "a_tencent";
		public static const android_turbo : String = "a_turbo";
		public static const android_turbo1 : String = "a_turbo1";
		public static const android_turbo2 : String = "a_turbo2";
		public static const android_turbo3 : String = "a_turbo3";

		public static var device_bar : Boolean;
		public static var isAutoLogin : Boolean;
		public static var isWarPass : Boolean;
		public static var isNewPass : Boolean;
		public static var checkUpdate : Boolean;

		// 系统语言版本
		public static var Device_Lan : String = "";

		/**
		 * 加载的swf地址
		 */
		public static var swf_type : String;
		public static var data_version : String;
		public static var isAccountPreName : Boolean = false;

		public static function parseXml(xml : XML) : void
		{
			var ns : Namespace = xml.namespace();
			isAutoLogin = xml.ns::isAutoLogin == "true";
			isWarPass = xml.ns::isWarPass == "true";
			isNewPass = xml.ns::isNewPass == "true";
			isNewPass=true;
			checkUpdate = xml.ns::checkUpdate == "true";
			device_bar = xml.ns::device_bar == "true";
		}
	}
}
