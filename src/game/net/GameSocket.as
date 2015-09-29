package game.net
{
	import com.components.RollTips;
	import com.dialog.DialogMgr;
	import com.langue.Langue;
	import com.mvc.interfaces.INotification;
	import com.net.TcpSocket;
	import com.scene.SceneMgr;
	import com.singleton.Singleton;
	import com.view.base.event.EventType;
	import com.view.base.event.ViewDispatcher;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	import game.common.JTLogger;
	import game.data.Val;
	import game.dialog.MsgDialog;
	import game.dialog.ShowLoader;
	import game.manager.GameMgr;
	import game.net.data.IData;
	import game.net.data.s.SBattle;
	import game.scene.BattleScene;
	import game.view.SystemSet.SystemSetDlg;
	import game.view.new2Guide.NewGuide2Manager;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import single.SSingleGameData;
	import single.SSingleNotify;

	public class GameSocket extends TcpSocket
	{
		public static function get instance() : GameSocket
		{
			return Singleton.getInstance(GameSocket) as GameSocket;
		}

		private var _hash : Object;
		private var _timer : Timer;

		public function GameSocket()
		{
			socketConnected = new Signal(GameSocket);
			securityError = new Signal(GameSocket);
			ioError = new Signal(GameSocket);
			socketClose = new Signal(GameSocket);
			_hash = {};
			_timer = new Timer(2000);
		}

		override protected function addListener() : void
		{
			super.addListener();
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
		}

		override protected function removeListener() : void
		{
			super.removeListener();
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);

			if (socketConnected)
				socketConnected.removeAll();

			if (securityError)
				securityError.removeAll();

			if (ioError)
				ioError.removeAll();

			if (socketClose)
				socketClose.removeAll();
		}

		public var socketConnected : ISignal;
		public var securityError : ISignal;
		public var ioError : ISignal;
		public var socketClose : ISignal;

		override protected function connectHandler(event : Event) : void
		{
			super.connectHandler(event);
			_timer.start();
			_hash = {};
			socketConnected.dispatch(this);

		}

		override protected function closeHandler(event : Event) : void
		{
			JTLogger.warn("[GameSocket.closeHandler] This Socket Close!");
			socketClose.dispatch(this);
			_hash = {};
			getMsgDialog();
			super.closeHandler(event);
		}

		override protected function ioErrorHandler(event : IOErrorEvent) : void
		{
			JTLogger.warn("[GameSocket.IoErrorHandler] This Socket Error!");
			ioError.dispatch(this);
			super.ioErrorHandler(event);

		}

		private function onTimer(e : TimerEvent) : void
		{
			var time : int = getTimer();
			var t : int, gap : int;

			for (var cmd : String in _hash)
			{
				t = _hash[cmd];
				gap = time - t;

				if (gap > 12000)
				{
					getMsgDialog(cmd);
					_timer.stop();
					break;
				}
			}
		}

		override protected function securityErrorHandler(event : SecurityErrorEvent) : void
		{
			super.securityErrorHandler(event);
			JTLogger.warn("[GameSocket.securityErrorHandler] This Socket SecurityError!");

			if (isSelf)
			{
				getMsgDialog();
				securityError.dispatch(this);
			}
		}

		//---------------------------------------------------------------------
		override public function sendData(dataBase : IData) : void
		{
			if (SSingleGameData.isSingleGame)
			{
				SSingleNotify.getInstance().receiveMessage(dataBase);
				return;
			}
			if (!connected)
			{
				getMsgDialog();
				return;
			}
			var cmd : int = dataBase.getCmd();
			_hash[cmd] = getTimer();
			send(cmd, dataBase.serialize());
		}

		private function getMsgDialog(cmd : String = null) : void
		{
			if (NewGuide2Manager.instance)
			{
				RollTips.addLangue("un_connect");
				SystemSetDlg.logout();
				ShowLoader.remove();
				return;
			}

			//战斗中不提示消息框
			if (SceneMgr.instance.getCurScene() is BattleScene)
			{
				if (!GameMgr.instance.isGameover)
				{
					return;
				}
			}

			if (cmd == SBattle.CMD + "")
			{
				ViewDispatcher.dispatch(EventType.RESET_GAME);
			}


//
			if (DialogMgr.instance.isShow(MsgDialog))
			{
				var msg : MsgDialog = DialogMgr.instance.getDlg(MsgDialog) as MsgDialog;
				msg.text == Langue.getLangue("connect_tips")
//                msg.text = Langue.getLangue("connect_again");
			}
			else
			{
				DialogMgr.instance.open(MsgDialog, Val.getlange("connect_again"));
			}
			ShowLoader.remove();
		}

		override protected function dispatchData(dataBase : INotification) : void
		{
			var cmd : int = int(dataBase.getName());
			delete _hash[cmd];
			super.notifyObserver(dataBase);
		}
	}
}