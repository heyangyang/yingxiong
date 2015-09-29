package game.view.notice
{
	import com.langue.Langue;
	import com.utils.Constants;
	import com.view.base.event.EventType;

	import flash.text.TextFormat;

	import feathers.controls.ScrollText;

	import game.common.JTGlobalDef;
	import game.dialog.ShowLoader;
	import game.manager.GameMgr;
	import game.managers.JTFunctionManager;
	import game.net.GameSocket;
	import game.net.data.c.CNotice;
	import game.net.data.s.SNotice;
	import game.net.data.vo.noticeVO;
	import game.view.viewBase.NoticeDlgBase;

	import starling.display.DisplayObjectContainer;
	import starling.events.Event;

	/**
	 * 公告
	 * @author Administrator
	 *
	 */
	public class NoticeDlg extends NoticeDlgBase
	{
		private var _scrollText:ScrollText;

		public function NoticeDlg()
		{
			super();
		}

		override protected function init():void
		{
			enableTween=true;
			clickBackroundClose();
			close_Scale9Button.text=Langue.getLangue("signRewardResignMsgOKText");

			_scrollText=new ScrollText();
			_scrollText.x=infoTxt.x;
			_scrollText.y=infoTxt.y;
			_scrollText.width=infoTxt.width;
			_scrollText.height=infoTxt.height;

			var textFormat:TextFormat=new TextFormat(infoTxt.fontName, infoTxt.fontSize, infoTxt.color);
			_scrollText.textFormat=textFormat;
			addChild(_scrollText);
			GameMgr.instance.hasNotice=false;

		}

		override protected function addListenerHandler():void
		{
			super.addListenerHandler();
			close_Scale9Button.addEventListener(Event.TRIGGERED, close);
			this.addContextListener(SNotice.CMD + "", messageNotification);
			this.dispatch(EventType.UPDATE_NOTICE);
		}

		override protected function show():void
		{
			var cmd:CNotice=new CNotice();
			GameSocket.instance.sendData(cmd);
		}

		private function messageNotification(evt:Event, info:SNotice):void
		{
			updateNoticeInfo(info);
		}

		private function updateNoticeInfo(info:SNotice):void
		{
			var str:String="";
			var len:int=info.notice.length;

			for (var i:int=0; i < len; i++)
			{
				str+=(info.notice[i] as noticeVO).msg;
			}
			_scrollText.text=str;
		}
	}
}
