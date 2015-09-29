package game.view.comm
{
	import com.dialog.DialogMgr;
	import com.langue.Langue;

	import game.data.ExpData;
	import game.data.HeroData;
	import game.data.HeroPriceData;
	import game.data.Val;
	import game.dialog.ResignDlg;
	import game.manager.HeroDataMgr;
	import game.net.message.EquipMessage;
	import game.view.uitils.FunManager;
	import game.view.uitils.Res;
	import game.view.viewBase.HeroInfoDialogBase;

	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.text.TextField;

	public class HeroInfoDialog extends HeroInfoDialogBase
	{
		private var heroData:HeroData=null;

		public function HeroInfoDialog()
		{
			super();
		}

		override protected function init():void
		{
			enableTween=true;
			clickBackroundClose();
			bgImage0.alpha=bgImage1.alpha=bgImage2.alpha=0.5;
			var names:Array=Langue.getLans("gyb_des_nametype");
			text_expert.text=names[0];
			text_HabitWeapon.text=names[1];
			heroBreak_Scale9Button.text=Langue.getLangue("hero_Break_Down");
			joy.visible=false;
			setToCenter();
		}

		/**打开*/
		override public function open(container:DisplayObjectContainer, parameter:Object=null, okFun:Function=null, cancelFun:Function=null):void
		{
			super.open(container, parameter, okFun, cancelFun);
			heroData=parameter as HeroData;
			setToCenter();
			showHeroInfomation();
		}

		override protected function addListenerHandler():void
		{
			super.addListenerHandler();
			addViewListener(heroBreak_Scale9Button, Event.TRIGGERED, onHeroUpgrade);
		}

		/**
		 * 解散英雄
		 */
		private function onHeroUpgrade():void
		{
			if (heroData == null || heroData.id == 0 || HeroDataMgr.instance.hash.keys().length == 1)
			{
				return;
			}
			DialogMgr.instance.isVisibleDialogs(true);
			var tip:ResignDlg=DialogMgr.instance.open(ResignDlg) as ResignDlg;
			var heroPriceData:HeroPriceData=HeroPriceData.hash.getValue((heroData.rarity == 0 ? 1 : heroData.rarity) + "" + heroData.quality) as HeroPriceData;
			tip.text=getLangue("heroDismissalMsg").replace("*", FunManager.hero_dismissal(heroPriceData.price, heroData.level)) + ExpData.getExpGoodsBylevel(heroData.level);
			tip.onResign.addOnce(isOkClick);
		}

		private function isOkClick():void
		{
			EquipMessage.sendDissolutionMessage(heroData);
		}

		/**
		 * 英雄属性
		 */
		private function showHeroInfomation():void
		{
			var tmpArray:Array=Val.MAGICBALL;
			//下一品质属性值
			var nextArray:Array=heroData.getNextPurgePropertys(heroData.getUpQuality());
			var len:int=tmpArray.length;
			var txt:TextField;
			var key:String;
			var currValue:uint=0;
			var nextValue:uint=0;
			var isUpQuality:Boolean=heroData.isUpQuality();

			var tmplang:Array=Langue.getLans("ENCHANTING_TYPE");
			var title:TextField;
			skillDes.text=heroData.des;
			joy.texture=Res.instance.getJobIconTexture(heroData.job);
			joy.visible=true;
			text_expertValue.text=Langue.getLans("hero_job")[heroData.job - 1];
			text_HabitWeaponValue.text=Langue.getLans("Equip_type")[heroData.weapon - 1];

			for (var i:int=0; i < len; i++)
			{
				key=tmpArray[i];
				//当前品质属性值
				currValue=heroData[key];
				nextValue=nextArray[i];
				txt=this[key + "Value"] as TextField;
				txt.text=currValue.toString();
				txt=this[key + "AddValue"] as TextField;
				(this["add_" + i] as TextField).visible=false;

				if (i >= 2)
				{
					title=this[key] as TextField;
					title.text=tmplang[i];
				}

				if (isUpQuality)
				{
					//变化值
//                    txt.text = "" + nextValue;
				}
				else
				{
					txt.text="";
				}
			}
		}
	}
}
