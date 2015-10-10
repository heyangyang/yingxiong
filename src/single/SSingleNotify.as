package single
{
	import com.view.base.event.ViewDispatcher;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	import game.net.data.IData;

	public class SSingleNotify
	{
		private static var instance : SSingleNotify;

		public static function getInstance() : SSingleNotify
		{
			if (!instance)
			{
				instance = new SSingleNotify();

			}
			return instance;
		}

		public function SSingleNotify()
		{
			addListenerHandler()
			mSingleGameMgr = SSingleGameData.getInstance();
		}

		protected var mDictionary : Dictionary = new Dictionary();
		protected var mSingleGameMgr : SSingleGameData;
		internal var mCmdId : int;

		protected function addListenerHandler() : void
		{
			regeditModel(SRoleSingleNotify);
			regeditModel(SItemSingleNotify);
			regeditModel(SHeroSingleNotify);
			regeditModel(SWarSinggleNotify);
			regeditModel(SMailSingleNotify);
		}

		protected function addHandler(eventString : int, listener : Function) : void
		{
			mDictionary[eventString] = listener;
		}

		private function regeditModel(classNotify : Class) : void
		{
			var notify : SSingleNotify = new classNotify();
			mDictionary[notify.mCmdId] = notify;
		}

		public function receiveMessage(dataBase : IData) : void
		{
			var cmd : String = dataBase.getCmd().toString().substring(0, 2);
			var notify : SSingleNotify = mDictionary[cmd];
			if (notify != null)
			{
				notify.receiveMessage(dataBase);
				return;
			}
			else if (mDictionary[dataBase.getCmd()] is Function)
			{
				var fun : Function = mDictionary[dataBase.getCmd()];
				if (fun != null)
				{
					fun(dataBase);
					return;
				}
			}
			trace("发送消息:", dataBase.getCmd(), getQualifiedClassName(dataBase));
		}


		protected function sendMessage(data : IData) : void
		{
			ViewDispatcher.dispatch(data.getCmd() + "", data);
		}

		public function dispatch(type : String, obj : * = null) : void
		{
			ViewDispatcher.dispatch(type, obj);
		}
	}
}