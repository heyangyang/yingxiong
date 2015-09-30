/**
 * Created by Administrator on 2014/9/30 0030.
 */
package game.view.luckyStar
{
	import com.components.RollTips;
	import com.dialog.DialogMgr;
	import com.langue.Langue;
	import com.mvc.interfaces.INotification;
	import com.sound.SoundManager;
	import com.utils.NumberDisplay;

	import game.common.JTFastBuyComponent;
	import game.common.JTSession;
	import game.data.Goods;
	import game.data.HeroData;
	import game.data.IconData;
	import game.data.LuckyStarData;
	import game.data.RoleShow;
	import game.dialog.ShowLoader;
	import game.hero.AnimationCreator;
	import game.manager.AssetMgr;
	import game.manager.GameMgr;
	import game.net.GameSocket;
	import game.net.data.IData;
	import game.net.data.c.CLuckInitInfo;
	import game.net.data.c.CLuck_start;
	import game.net.data.s.SGet_game_luck;
	import game.net.data.s.SLuckInitInfo;
	import game.net.data.s.SLuck_start;
	import game.view.comm.GetGoodsAwardEffectDia;
	import game.view.uitils.Res;
	import game.view.viewBase.LuckyDlgBase;

	import spriter.SpriterClip;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	/**
	 *幸运星
	 */
	public class LuckyDlg extends LuckyDlgBase
	{
		private var _data : StarData = StarData.instance;
		private const TOTAL_COUNT : int = 20;
		private var _oriSLuck_start : SLuck_start;
		private var index : int = 0;
		private var starSpriterClip : SpriterClip;
		private var _indexNumber : NumberDisplay;

		override protected function init() : void
		{
			_closeButton = closeBtn;
			bgImage.alpha = 0.5;
			run.text = Langue.getLans("start")[0];
			rankScale9Button.text = Langue.getLangue("Luck_Rich_List");
			diamond.text = Langue.getLangue("buyDiamond");
			text_rebateDes.text = Langue.getLangue("luck_Rebate_Description");
		}

		private function sendInitInfo() : void
		{
			var cmd : CLuckInitInfo = new CLuckInitInfo;
			GameSocket.instance.sendData(cmd);
			ShowLoader.add();
		}

		override public function open(container : DisplayObjectContainer, parameter : Object = null, okFun : Function = null, cancelFun : Function = null) : void
		{
			var money : Sprite = JTSession.layerGlobal.getChildByName("moneyBar") as Sprite;
			if (money)
			{
				money.visible = false;
			}
			super.open(container, parameter, okFun, cancelFun);
			setToCenter();
			this.y -= 28;
			turnMC.visible = false;

			var icon : Image;
			if (!_data.isSend)
			{
				for (var i : int = 0; i < 20; ++i)
				{
					icon = this["icon_" + i] as Image;
					icon.visible = false;
				}
				sendInitInfo(); //请求幸运星基本信息
			}
			else
			{
				showGoods(_data.values);
				updateStar();
			}
			GameMgr.instance.onUpateMoney.add(updateStar);
		}

		private function rankScale9ButtonHdr(e : Event) : void
		{
			isVisible = true;
			DialogMgr.instance.open(LuckyRankDlg);
		}

		override protected function addListenerHandler() : void
		{
			super.addListenerHandler();
			but_lucky.addEventListener(Event.TRIGGERED, buyLucky);
			run.addEventListener(Event.TRIGGERED, onStart); //抽奖
			rankScale9Button.addEventListener(Event.TRIGGERED, rankScale9ButtonHdr); //排行
			addContextListener(SLuckInitInfo.CMD + "", handleNotification);
			addContextListener(SLuck_start.CMD + "", handleNotification);
			addContextListener(SGet_game_luck.CMD + "", handleNotification);
		}

		private function buyLucky(e : Event) : void
		{
			isVisible = true;
			DialogMgr.instance.open(JTFastBuyComponent, JTFastBuyComponent.FAST_BUY_STAR);
		}

		private function onStart(e : Event) : void
		{
			if (starSpriterClip.visible)
			{
				if (GameMgr.instance.star == 0)
				{
					DialogMgr.instance.isVisibleDialogs(true);
					DialogMgr.instance.open(JTFastBuyComponent, JTFastBuyComponent.FAST_BUY_STAR);
					RollTips.add(Langue.getLangue("NO_LUCK"));
				}
				else
				{
					var cmd : CLuck_start = new CLuck_start;
					GameSocket.instance.sendData(cmd);
					starSpriterClip.visible = false;
					run.disable = true;
				}
			}
		}

		private function handleNotification(evt : Event, _arg1 : IData) : void
		{
			_indexNumber && _indexNumber.removeFromParent(true);
			_indexNumber = NumberDisplay.create(AssetMgr.instance, "ui_paihangshuzi_", 26, NumberDisplay.CENTER);
			_indexNumber.x = text_diamand.x + (text_diamand.width / 2);
			_indexNumber.y = text_diamand.y + 10;
			addQuiackChild(_indexNumber);
			if (_arg1.getCmd() == SLuckInitInfo.CMD)
			{
				var info : SLuckInitInfo = _arg1 as SLuckInitInfo;
				_data.isSend = true;
				_data.id = info.id;
				_data.values = info.values;
				_data.star = info.luck;
				showGoods(info.values);
				updateStar();
				_indexNumber.number = _data.values;
			}
			else if (_arg1.getCmd() == SLuck_start.CMD)
			{
				_oriSLuck_start = _arg1 as SLuck_start;
				if (_oriSLuck_start.code == 0)
				{
					index = 0;
					turn(TOTAL_COUNT + _oriSLuck_start.pos);
					_data.values = _oriSLuck_start.diamond;

					starSpriterClip.visible = false;
					_indexNumber.number = _data.values;
					showGoods(_data.values);
				}
				else if (_oriSLuck_start.code == 1)
				{
					isVisible = true;
					DialogMgr.instance.open(JTFastBuyComponent, JTFastBuyComponent.FAST_BUY_STAR);
					RollTips.add(Langue.getLangue("NO_LUCK"));
				}
				else if (_oriSLuck_start.code == 3)
				{
					RollTips.add(Langue.getLangue("packFulls"));
				}
				else if (_oriSLuck_start.code >= 127)
				{
					RollTips.add(Langue.getLangue("codeError") + _oriSLuck_start.code);
				}
			}
			else if (_arg1.getCmd() == SGet_game_luck.CMD)
			{
				var star : SGet_game_luck = _arg1 as SGet_game_luck;
				GameMgr.instance.star = _data.star = star.luck;
				updateStar();
			}
			ShowLoader.remove();
		}

		/**
		 * 显示最后获得的物品
		 */
		private function showReward() : void
		{
			var goodsList : Vector.<LuckyStarData> = _data.goodsList;
			var i : int = 0;
			starSpriterClip.visible = true;
			var dataVector : Vector.<IconData> = new Vector.<IconData>;
			for each (var lucky : LuckyStarData in goodsList)
			{
				if (lucky.pos == _oriSLuck_start.pos)
				{
					var item : Button = this["bg_" + (_oriSLuck_start.pos - 1)] as Button;
					turnMC.visible = true;
					turnMC.x = item.x - 5;
					turnMC.y = item.y - 5;

					var iconData : IconData = new IconData();
					dataVector[i++] = iconData;
					iconData.IconId = lucky.id;
					if (lucky.type < 100 && lucky.type != 5)
					{
						iconData.QualityTrue = Res.instance.getQualityToolTextures(0);
					}
					else
					{
						iconData.QualityTrue = Res.instance.getQualityToolTextures(lucky.quality);
					}
					iconData.Name = lucky.name;
					iconData.Num = "x " + lucky.num;
					if (lucky.type == 5)
					{
						var heroData : HeroData = HeroData.hero.getValue(lucky.type1);
						iconData.IconType = lucky.type1;
						iconData.IconTrue = (RoleShow.hash.getValue(heroData.show) as RoleShow).photo;
					}
					else
					{
						var goods : Goods = Goods.goods.getValue(lucky.type) as Goods;
						if (lucky.type == 3)
						{
							iconData.IconTrue = Res.instance.getCommTextures(11);
							iconData.Num = "x " + _data.values;
						}
						else
						{
							iconData.IconTrue = goods.picture;
						}
						iconData.IconType = lucky.type;
					}
					break;
				}
			}
			run.disable = false;
			isVisible = true;
			var effectData : Object = {vector: dataVector, effectPoint: null, effectName: "effect_036", effectSound: "cheers", effectFrame: 299};
			DialogMgr.instance.open(GetGoodsAwardEffectDia, effectData, null, null, "translucence", 0x000000, 0.5);
		}

		private function turn(num : int) : void
		{
			SoundManager.instance.playSound("xingyunxin");

			var item : Button = this["bg_" + (index++ % TOTAL_COUNT)] as Button;
			turnMC.x = item.x - 5;
			turnMC.y = item.y - 5;
			turnMC.visible = true;
			if (num-- == 0)
			{
				showReward();
			}
			else
			{
				if (num > 5)
				{
					Starling.juggler.delayCall(turn, 0.1, num);
				}
				else
				{
					Starling.juggler.delayCall(turn, 0.3, num);
				}
			}
		}

		private function updateStar() : void
		{
			star.text = GameMgr.instance.star + "";
		}

		/**
		 * 显示所以幸运星物品表的物品
		 */
		private function showGoods(_star : int = 0) : void
		{
			var goodsList : Vector.<LuckyStarData> = _data.goodsList;
			var len : int = goodsList.length;
			var heroData : HeroData;
			var goods : Goods;
			for (var i : int = 0; i < len; i++)
			{
				var luckstar : LuckyStarData = goodsList[i];
				var button : Button = this["bg_" + (luckstar.pos - 1)] as Button;
				var icon : Image = this["icon_" + (luckstar.pos - 1)] as Image;
				icon.visible = true;
				var quality : Image = this["item" + (luckstar.pos - 1)] as Image;
				var text : TextField = this["text_" + (luckstar.pos - 1)] as TextField;
				if (luckstar.type == 3)
				{
					icon.texture = AssetMgr.instance.getTexture(Res.instance.getCommTextures(11));
					text.text = "x " + _star;
				}
				else if (luckstar.type == 5)
				{
					heroData = HeroData.hero.getValue(luckstar.type1);
					icon.texture = AssetMgr.instance.getTexture((RoleShow.hash.getValue(heroData.show) as RoleShow).photo);
					text.text = "x 1";
					quality.texture = Res.instance.getQualityHeroTexture(heroData.quality);
				}
				else
				{
					goods = Goods.goods.getValue(luckstar.type) as Goods;
					icon.texture = AssetMgr.instance.getTexture(goods.picture);
					text.text = "x " + luckstar.num;
					if (luckstar.type < 100 && luckstar.type != 5 && luckstar.type != 3)
					{
						quality.texture = Res.instance.getQualityToolTexture(0);
					}
					else
					{
						quality.texture = Res.instance.getQualityToolTexture(luckstar.quality);
					}
				}
				quality.x = quality.y = 0;
				text.x = 11;
				text.y = 60;
				icon.x = button.width - icon.width >> 1;
				icon.y = button.height - icon.height >> 1;

				button.container.addQuiackChild(icon);
				button.container.addQuiackChild(quality);
				button.container.addQuiackChild(text);
			}

			// 添加开始按钮的特效
			starSpriterClip = AnimationCreator.instance.create("effect_011", AssetMgr.instance);
			starSpriterClip.play("effect_011");
			starSpriterClip.animation.looping = true;
			Starling.juggler.add(starSpriterClip);
			starSpriterClip.x = run.x + run.width / 2 - 5;
			starSpriterClip.y = run.y + run.height / 2;
			addQuiackChild(starSpriterClip);
		}

		override public function close() : void
		{
			var money : Sprite = JTSession.layerGlobal.getChildByName("moneyBar") as Sprite;
			if (money)
			{
				money.visible = true;
			}
			super.close();
		}

		override public function dispose() : void
		{
			starSpriterClip && starSpriterClip.removeFromParent(true);
			super.dispose();
		}
	}
}
