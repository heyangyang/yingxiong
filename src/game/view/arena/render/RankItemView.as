package game.view.arena.render
{
	import com.components.RollTips;
	import com.langue.Langue;
	import com.utils.NumberDisplay;

	import game.data.GamePhotoData;
	import game.dialog.ShowLoader;
	import game.manager.AssetMgr;
	import game.managers.JTPvpInfoManager;
	import game.managers.JTSingleManager;
	import game.net.GameSocket;
	import game.net.data.c.CColiseumRivalFightInfo;
	import game.net.data.c.CColiseumRivalHero;
	import game.net.data.vo.ColiseumRankInfo;
	import game.view.viewBase.RankItemViewBase;

	import starling.display.Image;
	import starling.events.Event;

	public class RankItemView extends RankItemViewBase
	{
		private var _indexNumber:NumberDisplay;
		private var _child:Image=null;

		public function RankItemView()
		{
			super();
			bgImage.alpha=0.5;
			txt_3.text=Langue.getLangue("BATTLE");
			btn_Scale9Button.text=Langue.getLangue("change_rank_name");
			txt_2.fontName="";
		}

		override public function set data(value:Object):void
		{
			super.data=value;
			if (value == null)
			{
				return;
			}
			var rank:ColiseumRankInfo=value as ColiseumRankInfo;
			if (rank)
			{
				_indexNumber && _indexNumber.removeFromParent(true);
				_child && _child.removeFromParent(true);
				if (rank.pos > 3)
				{
					_indexNumber=NumberDisplay.create(AssetMgr.instance, "ui_paihangshuzi_", 26, NumberDisplay.CENTER);
					_indexNumber.x=txt_1.x + 12;
					_indexNumber.y=txt_1.y - 5;
					addQuiackChild(_indexNumber);
					_indexNumber.number=rank.pos;
				}
				else
				{
					_child=new Image(AssetMgr.instance.getTexture("ui_paihangshuzi_01_0" + rank.pos));
					_child.x=txt_1.x;
					_child.y=txt_1.y - 5;
					addQuiackChild(_child);
				}
				txt_2.text=rank.name;
				txt_4.text=rank.power.toString();
				hero_icon.data=GamePhotoData.hashMapPhoto.getValue(rank.picture);
				btn_Scale9Button.addEventListener(Event.TRIGGERED, onPkHandler);
				hero_icon.addEventListener(Event.TRIGGERED, lookRoleInfoHandler);
			}
			else
			{
				txt_1.text=txt_2.text=txt_4.text="";
			}
		}

		private function lookRoleInfoHandler(e:Event):void
		{
			if (!this.data)
			{
				return;
			}
			var lines:Array=(this.data.name as String).split(".");
			if (this.data.name == "^." + this.data.rid + ".$")
			{
				RollTips.showTips("robot");
				return;
			}
			var sendlookHeros:CColiseumRivalHero=new CColiseumRivalHero();
			sendlookHeros.id=this.data.rid;
			JTPvpInfoManager.hero_title=this.data.name;
			GameSocket.instance.sendData(sendlookHeros);
			ShowLoader.add();
		}

		private function onPkHandler(e:Event):void
		{
			if (!this.data)
			{
				return;
			}
			var rankInfo:ColiseumRankInfo=this.data as ColiseumRankInfo;
			var pvpInfoManager:JTPvpInfoManager=JTSingleManager.instance.pvpInfoManager;
			var errors:Array=Langue.getLans("pvpErrors");
			if (pvpInfoManager.rank == rankInfo.pos)
			{
				RollTips.add(errors[2]); //不能挑战自己
				return;
			}
			if (JTSingleManager.instance.pvpInfoManager.pvpCount <= 0)
			{
				RollTips.add(errors[0]); //挑战次数不足
				return;
			}
			JTPvpInfoManager.type=JTPvpInfoManager.TYPE_PVP;
			var sendPkPackage:CColiseumRivalFightInfo=new CColiseumRivalFightInfo();
			sendPkPackage.id=rankInfo.id;
			sendPkPackage.type=JTPvpInfoManager.TYPE_PVP;
			sendPkPackage.index=rankInfo.pos;
			JTPvpInfoManager.pvpRid=rankInfo.rid;
			GameSocket.instance.sendData(sendPkPackage);
		}

	}
}
