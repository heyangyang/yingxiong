package game.view.arena
{
	import com.langue.Langue;

	import game.data.GamePhotoData;
	import game.data.HeroData;
	import game.fight.Position;
	import game.net.data.IData;
	import game.net.data.s.SColiseumRivalHero;
	import game.net.data.vo.ColiseumRivalHeroVO;
	import game.view.uitils.Res;
	import game.view.viewBase.ArenaRoleDialogBase;

	import starling.display.Button;
	import starling.display.Image;

	/**
	 *PVP玩家资料
	 * @author Administrator
	 */
	public class ArenaRoleDialog extends ArenaRoleDialogBase
	{
		public function ArenaRoleDialog()
		{
			super();
		}

		override protected function init():void
		{
			enableTween=true;
			clickBackroundClose();
			var arr:Array=Langue.getLans("rankTitles");
			zltitle.text=Langue.getLangue("other_Information");
			txtNameTitle.text=Langue.getLangue("Nick_Name"); //昵称
			txtGhTitle.text=Langue.getLangue("Association"); //公会
			txtRankTitle.text=arr[0];
			txtPowerTitle.text=arr[3];
			txtNumTitle.text=Langue.getLangue("victory_Field_Number"); //胜利场数
		}

		override protected function show():void
		{
			var shero:SColiseumRivalHero=_parameter as SColiseumRivalHero;
			txtName.text=shero.name;
			txtGh.text=shero.guild.toString(); //所在公会名字
			txtRank.text=shero.rank.toString();
			txtPower.text=shero.combat.toString();
			txtNum.text=shero.wins.toString();
			txtVip.text=(shero.vip - 1).toString();
			hero.data=GamePhotoData.hashMapPhoto.getValue(shero.pic);

			var list:Vector.<IData>=shero.heroes;
			var head:Image=null;
			var data:ColiseumRivalHeroVO;
			var pos:int=0;
			var scaleBtn:Button=null;
			for (var i:int=0; i < list.length; i++)
			{
				data=list[i] as ColiseumRivalHeroVO;
				if (data.seat > 0)
				{
					pos=Position.instance.seatTopos(data.seat);
					if (pos > 0)
					{
						scaleBtn=this["embtn_" + pos] as Button;
						var heroData:HeroData=(HeroData.hero.getValue(data.type) as HeroData);
						head=new Image(Res.instance.getHeroIconTexture(heroData.show));
						scaleBtn.addChild(head);
					}
				}
			}
		}

		override public function dispose():void
		{
			super.dispose();
		}
	}
}
