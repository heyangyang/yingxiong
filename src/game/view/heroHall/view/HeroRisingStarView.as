package game.view.heroHall.view
{
	import com.dialog.DialogMgr;
	import com.langue.Langue;

	import flash.geom.Rectangle;

	import game.data.Goods;
	import game.data.HeroData;
	import game.data.StarData;
	import game.data.Val;
	import game.data.WidgetData;
	import game.manager.GameMgr;
	import game.net.message.EquipMessage;
	import game.view.goodsGuide.EquipInfoDlg;
	import game.view.heroHall.render.HeroIconRender;
	import game.view.heroHall.render.StarBarRender;
	import game.view.viewBase.HeroRisingStarViewBase;

	import starling.events.Event;
	import starling.text.TextField;

	/**
	 *英雄升星
	 * @author lfr
	 */
	public class HeroRisingStarView extends HeroRisingStarViewBase
	{
		private var _currData:HeroData=null;
		/**当前英雄*/
		private var _currHeroRender:HeroIconRender;
		/**下阶级英雄*/
		private var _nextHeroRender:HeroIconRender;

		/**星星*/
		private var _currStarBar:StarBarRender=null;
		private var _nextStarBar:StarBarRender=null;

		public function HeroRisingStarView()
		{
			super();
		}

		override protected function init():void
		{
			bgImage0.alpha=bgImage1.alpha=bgImage2.alpha=0.5;
			sxBtn_Scale9Button.text=Langue.getLans("heroLableName")[3];
			addbtn_Scale9Button.text=Langue.getLangue("get");

			_currHeroRender=new HeroIconRender(null, false, true);
			_currHeroRender.x=257;
			_currHeroRender.y=105;
			_currHeroRender.touchable=false;
			addQuiackChild(_currHeroRender);

			_nextHeroRender=new HeroIconRender(null, false, true);
			_nextHeroRender.x=473;
			_nextHeroRender.y=105;
			_nextHeroRender.touchable=false;
			addQuiackChild(_nextHeroRender);

			_currStarBar=new StarBarRender();
			addQuiackChild(_currStarBar);


			_nextStarBar=new StarBarRender();
			addQuiackChild(_nextStarBar);
		}

		override protected function addListenerHandler():void
		{
			super.addListenerHandler();
			this.addViewListener(sxBtn_Scale9Button, Event.TRIGGERED, onUpStarHandler);
			this.addViewListener(addbtn_Scale9Button, Event.TRIGGERED, onUpStarHandler);
		}

		public function updata(heroData:HeroData):void
		{
			if (heroData == null)
			{
				return;
			}
			_currData=heroData;
			_currStarBar.updataStar(_currData.foster, 0.9);

			if (_currData.isUpStar())
			{
				_nextStarBar.updataStar(_currData.foster + 1, 0.9);
			}
			else
			{
				_nextStarBar.updataStar(5, 0.9);
			}
			_currStarBar.x=_currHeroRender.x + ((_currHeroRender.quality.width - _currStarBar.width) >> 1);
			_nextStarBar.x=_nextHeroRender.x + ((_nextHeroRender.quality.width - _nextStarBar.width) >> 1);
			_currStarBar.y=_nextStarBar.y=220;

			var colneData:HeroData=_currData.clone() as HeroData;
			colneData.seat=0;
			_currHeroRender.data=colneData;

			if (_currData.isUpQuality())
			{
				var cData:HeroData=_currData.clone() as HeroData;
				cData.seat=0;
				cData.quality=_currData.quality + 1;
				_nextHeroRender.data=cData;
			}
			else
			{
				_nextHeroRender.data=colneData;
			}

			var starData:StarData=StarData.hash.getValue(_currData.foster + 1);
			if (starData != null)
			{
				var goods:Goods=Goods.goods.getValue(_currData.type);
				var hasCount:int=WidgetData.pileByType(goods.type);
				txt_percent.text=(hasCount + "/" + starData.materialNum);
				bar.clipRect=new Rectangle(0, 0, (hasCount / starData.materialNum) >= 1 ? 273 : (hasCount / starData.materialNum) * 273, 38);
			}
			else
			{
				txt_percent.text=Langue.getLangue("hero_Top_star");
				bar.clipRect=new Rectangle(0, 0, 0, 0);
			}
			showHeroInfomation();
		}

		/**进行升星*/
		private function onUpStarHandler(e:Event):void
		{
			var good:Goods=Goods.goods.getValue(_currData.type);
			var starData:StarData;
			if (_currData.isUpStar())
			{
				starData=StarData.hash.getValue(_currData.foster + 1);
			}
			else
			{
				starData=StarData.hash.getValue(5);
			}

			var hasCount:int=WidgetData.pileByType(good.type);
			//材料不足
			if (hasCount < starData.materialNum || e.currentTarget == addbtn_Scale9Button)
			{
				good.isPack=false;
				good=good.clone() as Goods;
				good.Price=0;
				DialogMgr.instance.open(EquipInfoDlg, good);
				return;
			}

			//金币不足
			if (starData.payType == 1 && GameMgr.instance.coin < starData.money)
			{
				addTips("notEnoughCoin");
				return;
			}

			//钻石不足
			if (starData.payType == 2 && GameMgr.instance.diamond < starData.money)
			{
				addTips("diamendNotEnough");
				return;
			}
			EquipMessage.sendStarMessage(_currData);
		}

		/**
		 * 英雄属性
		 */
		private function showHeroInfomation():void
		{
			var tmpArray:Array=Val.MAGICBALL;
			var nextArray:Array=[];
			var len:int=tmpArray.length;
			var title:TextField;
			var txt:TextField;
			var key:String;
			var currValue:uint=0;
			var nextValue:uint=0;
			var isUpStar:Boolean=_currData.isUpStar();
			var tmplang:Array=Langue.getLans("ENCHANTING_TYPE");

			if (isUpStar)
			{
				nextArray=_currData.getNextStarPropertys(_currData.foster + 1);
			}
			else
			{
				nextArray=_currData.getNextStarPropertys(5);
			}

			for (var i:int=0; i < len; i++)
			{
				key=tmpArray[i];
				currValue=_currData[key];
				nextValue=nextArray[i];
				txt=this[key + "Value"] as TextField;
				txt.text=currValue.toString();
				txt=this[key + "AddValue"] as TextField;

				if (i >= 2)
				{
					title=this[key] as TextField;
					title.text=tmplang[i];
				}

				if (isUpStar)
				{
					txt.text="" + nextValue;
					(this["add_" + i] as TextField).visible=true;
				}
				else
				{
					txt.text="";
					(this["add_" + i] as TextField).visible=false;
				}
			}
		}

	}
}
