package game.view.arena.render
{
	import com.langue.Langue;

	import game.data.GamePhotoData;
	import game.data.Val;
	import game.dialog.ShowLoader;
	import game.managers.JTPvpInfoManager;
	import game.net.GameSocket;
	import game.net.data.c.CColiseumRivalFightInfo;
	import game.net.data.vo.ColiseumReportList;
	import game.view.viewBase.ReportItemViewBase;

	import starling.events.Event;
	import starling.filters.ColorMatrixFilter;

	public class ReportItemView extends ReportItemViewBase
	{
		public function ReportItemView()
		{
			super();
			bgImage.alpha=0.5;
			btn_Scale9Button.text=Langue.getLangue("fc_report_btn");
			btn_Scale9Button.addEventListener(Event.TRIGGERED, onSendRePKHandler);
			txt_2.fontName=""
		}

		private function onSendRePKHandler(e:Event):void
		{
			if (!this.data)
			{
				return;
			}
			JTPvpInfoManager.type=JTPvpInfoManager.TYPE_FIGHT;
			var rankInfo:ColiseumReportList=data as ColiseumReportList;
			var sendPkPackage:CColiseumRivalFightInfo=new CColiseumRivalFightInfo();
			sendPkPackage.id=rankInfo.id;
			sendPkPackage.type=JTPvpInfoManager.TYPE_FIGHT;
			GameSocket.instance.sendData(sendPkPackage);
			ShowLoader.add();
		}

		override public function set data(value:Object):void
		{
			super.data=value;
			var report:ColiseumReportList=value as ColiseumReportList;
			if (report)
			{
				if (report.pic)
					hero_icon.data=GamePhotoData.hashMapPhoto.getValue(report.pic);
				txt_1.text=report.combat.toString();
				txt_2.text=report.name;
				slSprite.visible=report.win;
				sbSprite.visible=!report.win;
				btn_Scale9Button.touchable=!report.win;
				if (report.win)
				{
					btn_Scale9Button.filter=new ColorMatrixFilter(Val.filter);
					btn_Scale9Button.touchable=false;
				}
				else
				{
					btn_Scale9Button.filter=null;
					btn_Scale9Button.touchable=true;
				}
			}
		}
	}
}
