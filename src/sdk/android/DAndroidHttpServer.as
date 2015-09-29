package sdk.android
{
	import com.components.RollTips;
	import com.dialog.DialogMgr;
	import com.langue.Langue;
	import com.utils.Constants;
	import com.view.base.event.EventType;
	import com.view.base.event.ViewDispatcher;
	
	import game.data.DiamondShopData;
	import game.dialog.ShowLoader;
	import game.utils.HttpClient;
	import game.utils.LocalShareManager;
	import game.view.vip.MyCardPayView;
	
	import sdk.AccountManager;

	public class DAndroidHttpServer
	{
		private static var instance : DAndroidHttpServer;

		public static function getInstance() : DAndroidHttpServer
		{
			if (instance == null)
				instance = new DAndroidHttpServer();
			return instance;
		}

		private var server_url : String;
		public var session_id : String;
		private var session_count : int = 0;
		public var register_count : int = 0;
		public var login_count : int = 0;
		protected const CONNECT_MAX : int = 3;

		public function DAndroidHttpServer()
		{
			server_url = "http://211.72.249.246/2funfun/";

			//开发地址
//			if (Config.device == Config.android)
//				server_url = "http://account.szturbotech.com/2funfun/";
		}


		public function getSession(data : Object = null) : void
		{
			var tmp_session : Object = LocalShareManager.getInstance().get("a_fun");
			var timeData : Date = new Date();

			if (tmp_session && tmp_session.session_id && (timeData.getTime() - tmp_session.time) / 1000 / 60 / 60 < 5)
				session_id = tmp_session.session_id;
			else
			{
				session_count++;
				HttpClient.send(server_url + "get_session_id.php", {}, onComplete, getSession);
			}

			function onComplete(returnObj : String) : void
			{
				var tmpData : Object = JSON.parse(returnObj);

				if (tmpData.error)
				{
					if (session_count <= CONNECT_MAX)
						getSession();
					else
						RollTips.add(tmpData.error);
				}
				else if (tmpData.session_id)
				{
					session_id = tmpData.session_id;
					LocalShareManager.getInstance().save("a_fun", {session_id: session_id, time: timeData.getTime()});
				}
			}
		}

		public function register(email : String, pwd : String, onReturnHandler : Function) : void
		{
			addLoader();
			var data : Object = {};
			data.session_id = session_id;
			data.email = email;
			data.password = pwd;
			register_count++;
			HttpClient.send(server_url + "reg.php", data, onComplete, removeLoader);

			function onComplete(returnObj : String) : void
			{
				removeLoader();
				var tmpData : Object = JSON.parse(returnObj);

				if (!tmpData.error)
				{
					//注册成功后登陆
					login(email, pwd, null);
					onReturnHandler != null && onReturnHandler();
				}
				else if (tmpData.error == "Could not connect to host" && register_count <= CONNECT_MAX)
				{
					register(email, pwd, onReturnHandler);
				}
				else if (tmpData.error.indexOf("Session expired") >= 0 && register_count <= CONNECT_MAX)
				{
					LocalShareManager.getInstance().clear("a_fun");
					session_count = 0;
					getSession();
					register(email, pwd, onReturnHandler);
				}
				else
				{
					RollTips.add(tmpData.error);
				}
			}
		}

		public function login(email : String, pwd : String, onReturnHandler : Function) : void
		{
			addLoader();
			var data : Object = {};
			data.session_id = session_id;
			data.email = email;
			data.password = pwd;
			login_count++;
			HttpClient.send(server_url + "login.php", data, onComplete, removeLoader);

			function onComplete(returnObj : String) : void
			{
				removeLoader();
				var tmpData : Object = JSON.parse(returnObj);

				if (!tmpData.error)
				{
					onReturnHandler != null && onReturnHandler();
				}
				else if (tmpData.error == "Could not connect to host" && login_count <= CONNECT_MAX)
				{
					login(email, pwd, onReturnHandler);
				}
				else if (tmpData.error.indexOf("Session expired") >= 0 && login_count <= CONNECT_MAX)
				{
					LocalShareManager.getInstance().clear("a_fun");
					session_count = 0;
					getSession();
					login(email, pwd, onReturnHandler);
				}
				else
				{
					RollTips.add(tmpData.error);
				}
			}
		}

		/**
		 * Fun点支付
		 * @param product_id
		 *
		 */
		public function pay_fun(diamond : DiamondShopData) : void
		{
			addLoader();
			var data : Object = {};
			data.session_id = session_id;
			data.email = Constants.username;
			data.password = Constants.password;
			data.order_id = AccountManager.instance.createTag(diamond.shopid.toString());
			HttpClient.send(server_url + "pay_fun_point.php", data, onComplete, removeLoader);

			function onComplete(returnObj : String) : void
			{
				removeLoader();
				var tmpData : Object = JSON.parse(returnObj);

				if (!tmpData.error)
				{
				}
				else
				{
					RollTips.add(tmpData.error);
				}
			}
		}

		public function pay_MyCard(diamond : DiamondShopData) : void
		{
			addLoader();
			var data : Object = {};
			data.session_id = session_id;
			data.email = Constants.username;
			data.password = Constants.password;
			data.order_id = AccountManager.instance.createTag(diamond.shopid.toString());
			HttpClient.send(server_url + "pay_mycard_payment.php", data, onComplete, removeLoader);

			function onComplete(returnObj : String) : void
			{
				removeLoader();
				var tmpData : Object = JSON.parse(returnObj);

				if (!tmpData.error)
				{
					ViewDispatcher.dispatch(EventType.GOTO_WEB, tmpData.url);
				}
				else
				{
					RollTips.add(tmpData.error);
				}
			}
		}

		public function pay_MyCard1(cardId : String, cardPwd : String) : void
		{
			addLoader();
			var data : Object = {};
			data.session_id = session_id;
			data.email = Constants.username;
			data.cardno = cardId;
			data.cardpwd = cardPwd;
			data.password = Constants.password;
			data.order_id = AccountManager.instance.createTag("0");
			HttpClient.send(server_url + "pay_mycard_ingame.php", data, onComplete, removeLoader);

			function onComplete(returnObj : String) : void
			{
				removeLoader();
				var tmpData : Object = JSON.parse(returnObj);

				if (!tmpData.error)
				{
					DialogMgr.instance.deleteDlg(MyCardPayView);
					RollTips.add(Langue.getLangue("buySuccess"));
				}
				else
				{
					RollTips.add(tmpData.error);
				}
			}
		}

		public function pay_paypal(diamond : DiamondShopData) : void
		{
			addLoader();
			var data : Object = {};
			data.session_id = session_id;
			data.email = Constants.username;
			data.password = Constants.password;
			data.order_id = AccountManager.instance.createTag(diamond.shopid.toString());
			HttpClient.send(server_url + "pay_banktransfer.php", data, onComplete, removeLoader);

			function onComplete(returnObj : String) : void
			{
				removeLoader();
				var tmpData : Object = JSON.parse(returnObj);

				if (!tmpData.error)
				{
					ViewDispatcher.dispatch(EventType.GOTO_WEB, tmpData.url);
				}
				else
				{
					RollTips.add(tmpData.error);
				}
			}
		}

		private function addLoader(data : Object = null) : void
		{
			ShowLoader.add();
		}

		private function removeLoader(data : Object = null) : void
		{
			if (data != null)
				RollTips.add(Langue.getLangue("connect_out"));
			ShowLoader.remove();
		}
	}
}
