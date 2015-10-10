package game.view.magicShop.view
{
	import com.components.RollTips;
	import com.dialog.DialogMgr;
	import com.langue.Langue;
	import com.sound.SoundManager;
	import com.utils.Constants;

	import feathers.controls.Scroller;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;

	import game.data.Goods;
	import game.data.IconData;
	import game.data.MagicorbsData;
	import game.dialog.ResignDlg;
	import game.dialog.ShowLoader;
	import game.hero.AnimationCreator;
	import game.manager.AssetMgr;
	import game.manager.GameMgr;
	import game.net.GameSocket;
	import game.net.data.IData;
	import game.net.data.c.CGetMagicOrbs;
	import game.net.data.c.CMagicOrbsState;
	import game.net.data.c.COversellItem;
	import game.net.data.s.SGetMagicOrbs;
	import game.net.data.s.SMagicOrbsState;
	import game.net.data.s.SOversellItem;
	import game.net.data.vo.magicOrbsStateVO;
	import game.view.comm.GetGoodsAwardEffectDia;
	import game.view.magicShop.MagicOrbDia;
	import game.view.magicShop.data.GetMagicOrbs;
	import game.view.magicShop.render.MagicRender;
	import game.view.uitils.Res;
	import game.view.viewBase.MagicObrGetViewBase;
	import game.view.widget.ViewWidget;

	import spriter.SpriterClip;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;

	/**
	 *宝珠获取
	 * @author lfr
	 */
	public class MagicObrGetView extends MagicObrGetViewBase
	{
		private var magicState : Vector.<IData>; //保存宝珠状态
		private var stateVo : magicOrbsStateVO;
		private var sarah : SarahRenderView;
		private var dataVector : Vector.<IconData> = null;
		private var _selectList : Vector.<int>; //选中的物品
		private var _isSelect : Boolean = false; // 标志当前是否选择被吞噬状态  true为选择状态
		private var magicVector : Vector.<GetMagicOrbs> = new Vector.<GetMagicOrbs>;
		private var dataProvider : Vector.<GetMagicOrbs>

		public function MagicObrGetView()
		{
			super();
		}

		/**初始化*/
		override protected function init() : void
		{
			sell_Scale9Button.text = Langue.getLangue("SELL"); //出售
			complete_Scale9Button.text = Langue.getLans("jg_desz_moneytype")[2]; //一键收取
			btn_automatic.text = Langue.getLangue("magicAutomatic"); //智能抽取

			for (var i : int = 0; i < 5; i++)
			{
				sarah = new SarahRenderView();
				addQuiackChild(sarah);
				sarah.name = "sarah_" + (i + 1); //用来请求时，发送服务端的等级
				sarah.x = i * 136 + 165;
				sarah.y = 420;
				sarah.data = {icon: "icon_120" + (i + 1), moeny: (MagicorbsData.hash.getValue((i + 1)) as MagicorbsData).coinCount, moneyType: (MagicorbsData.hash.getValue((i + 1)) as MagicorbsData).coinType};
				this.getChildByName("sarah_" + (i + 1)).addEventListener(Event.TRIGGERED, onSiphon);
				if (i > 0)
				{
					var mask : Image = new Image(AssetMgr.instance.getTexture("ui_baozhuchouqu_00_anniu"));
					sarah.addQuiackChild(mask);
					mask.name = "mask";
					mask.y = 3;
				}
			}

			const listLayout : TiledRowsLayout = new TiledRowsLayout();
			listLayout.gap = 5;
			listLayout.horizontalGap = 24;
			listLayout.useSquareTiles = false;
			listLayout.useVirtualLayout = true;
			listLayout.verticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
			listLayout.paging = TiledRowsLayout.PAGING_HORIZONTAL; //自动排列			
			list_orb.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF; //横向滚动 
			list_orb.layout = listLayout;
			list_orb.itemRendererFactory = itemRendererFactory;
		}

		/**初始化监听*/
		override protected function addListenerHandler() : void
		{
			super.addListenerHandler();
			btn_automatic.addEventListener(Event.TRIGGERED, upAutomaticMagic);
			complete_Scale9Button.addEventListener(Event.TRIGGERED, onCompleteToPack);
			sell_Scale9Button.addEventListener(Event.TRIGGERED, onSell);
			addContextListener(SMagicOrbsState.CMD + "", handleNotification);
			addContextListener(SOversellItem.CMD + "", handleNotification);
			addContextListener(SGetMagicOrbs.CMD + "", handleNotification);
		}

		/**更新*/
		public function updata() : void
		{

		}

		/**渲染器*/
		private function itemRendererFactory() : IListItemRenderer
		{
			var item : MagicRender = new MagicRender();
			item.setSize(98, 98);
			return item as IListItemRenderer;
		}

		/**请求状态*/
		override protected function show() : void
		{
			showGrids();
			stateSend();
		}

		/** 创建宝珠背包*/
		private function showGrids(goods : Goods = null) : void
		{
			dataProvider = new Vector.<GetMagicOrbs>;
			var magicOrbs : GetMagicOrbs = null;
			if (goods == null)
			{
				dataProvider = dataProvider.concat(magicVector);
				for (var i : int = 0; i < 18; i++)
				{
					magicOrbs = new GetMagicOrbs();
					dataProvider.push(magicOrbs);
				}

			}
			else
			{
				magicOrbs = new GetMagicOrbs();
				magicOrbs.id = goods.id;
				magicOrbs.type = goods.type;
				magicOrbs.quality = goods.quality;
				magicOrbs.level = 1;
				magicVector.push(magicOrbs);
				dataProvider = dataProvider.concat(magicVector);

				var page : int = Math.floor(magicVector.length / 18) + 1; //显示多少页
				var adlen : int = page * 18 - magicVector.length;
				for (var j : int = 0; j < adlen; j++)
				{
					magicOrbs = new GetMagicOrbs();
					dataProvider.push(magicOrbs);
				}
			}
			list_orb.dataProvider = new ListCollection(dataProvider);
		}

		/**出售*/
		private function onSell(e : Event) : void
		{
			(this.parent as MagicOrbDia).isVisible = true;
			var tip : ResignDlg = DialogMgr.instance.open(ResignDlg) as ResignDlg;
			var text : String = Langue.getLangue("Whether_selected_Orb");
			tip.ok_Scale9Button.text = Langue.getLangue("SELL");
			tip.close_Scale9Button.text = Langue.getLangue("Next_Time"); //下次再来吧
			tip.text = text;
			tip.onResign.addOnce(isOkClick);
			tip.onClose.addOnce(isCloseClick);
		}

		/**
		 *确定出售宝珠
		 */
		private function isOkClick() : void
		{
			_selectList = new Vector.<int>;
			var len : int = dataProvider.length;
			var getMagicOrbs : GetMagicOrbs = null;
			for (var i : int = 0; i < len; i++)
			{
				getMagicOrbs = dataProvider[i] as GetMagicOrbs;
				if (getMagicOrbs.selected && getMagicOrbs.id > 0)
				{
					_selectList.push(getMagicOrbs.id);
				}
			}

			if (_selectList.length > 0)
			{
				var cmd : COversellItem = new COversellItem();
				cmd.ids = _selectList;
				cmd.tab = 2;
				GameSocket.instance.sendData(cmd);
				ShowLoader.add();
			}
			else
			{
				RollTips.add(Langue.getLangue("noSelectSellGoods")); //没有选中出售物品
			}
		}

		private function isCloseClick() : void
		{
			_selectList = new Vector.<int>;
			var len : int = dataProvider.length;
			var getMagicOrbs : GetMagicOrbs = null;
			for (var i : int = 0; i < len; i++)
			{
				getMagicOrbs = dataProvider[i] as GetMagicOrbs;
				getMagicOrbs.selected = false;
			}
			list_orb.dataViewPort.dataProvider_refreshItemHandler();
		}

		/**
		 * 一键批量选取保存到背包
		 */
		private function onCompleteToPack(e : Event) : void
		{
			if (magicVector.length > 0)
			{
				_selectList = new Vector.<int>;
				var len : int = dataProvider.length;
				var getMagicOrbs : GetMagicOrbs = null;
				for (var i : int = 0; i < len; i++)
				{
					getMagicOrbs = dataProvider[i] as GetMagicOrbs;
					if (getMagicOrbs.id > 0)
					{
						_selectList.push(getMagicOrbs.id);
					}
				}
				if (_selectList.length > 0)
				{
					flyList();
					_selectList = new Vector.<int>;
					magicVector = new Vector.<GetMagicOrbs>;
					showGrids();
				}
				else
				{
					RollTips.add(Langue.getLangue("noSelectSellGoods")); //没有选中出售物品
				}

			}
		}

		/**点击当前可以获取的宝珠*/
		private function onSiphon(e : Event) : void
		{
			if (e.target is SarahRenderView)
			{
				var index : int = int((e.currentTarget as SarahRenderView).name.split("_")[1]);
				getMagicOrbs(index);
			}
		}

		/**获取操作宝珠类型根据index*/
		private function getMagicOrbs(index : int) : void
		{
			var magicData : MagicorbsData = MagicorbsData.hash.getValue(index);
			if (magicData && magicData.coinType == 2 && GameMgr.instance.diamond < magicData.coinCount)
			{
				RollTips.add(Langue.getLangue("diamendNotEnough")); //钻石不足
			}
			else if (magicData && magicVector.length >= 18)
			{
				RollTips.add(Langue.getLangue("orbCaps")); //宝珠获取上限
			}
			else
			{
				ShowLoader.add();
				var cmd : CGetMagicOrbs = new CGetMagicOrbs();
				cmd.level = index;
				GameSocket.instance.sendData(cmd);
			}
		}

		/** 显示操作宝珠类型状态*/
		private function showMagicState() : void
		{
			if (getChildByName("openAction"))
			{
				getChildByName("openAction").removeFromParent(true);
			}

			var length : int = magicState.length;
			var serahItem : SarahRenderView;
			var mak : Image = null;
			for (var i : int = 0; i < length; i++)
			{
				stateVo = magicState[i] as magicOrbsStateVO;
				serahItem = this.getChildByName("sarah_" + stateVo.level) as SarahRenderView;
				mak = serahItem.getChildByName("mask") as Image;
				//宝珠未开启
				if (stateVo.state == 0)
				{
					if (mak)
						mak.visible = true;
					serahItem.touchable = false;
					this["up_" + (stateVo.level - 1)].texture = AssetMgr.instance.getTexture("ui_zhishijiantou02_tubiao"); //箭头变灰
				}
				else
				{ 	//宝珠开启
					sarah = serahItem;
					if (stateVo.level != 1) //如果宝珠开启的等级不是1级,就变亮
					{
						if (mak)
							mak.visible = false;
						serahItem.touchable = true;
						this["up_" + (stateVo.level - 1)].texture = AssetMgr.instance.getTexture("ui_zhishijiantou01_tubiao"); //箭头变亮

						if (getChildByName("openAction"))
						{
							getChildByName("openAction").removeFromParent(true);
						}
						createAction(this.getChildByName("sarah_" + stateVo.level), "openAction");
					}
				}
			}
		}

		/**创建特效*/
		private function createAction(child : DisplayObject, name : String) : SpriterClip
		{
			//这是点击想获取宝珠上的效果
			var action : SpriterClip = AnimationCreator.instance.create("effect_030", AssetMgr.instance);
			action.play("effect_030");
			Starling.juggler.add(action);
			action.x = child.x + 50;
			action.y = child.y + 50;
			addQuiackChildAt(action, 1);
			action.touchable = false;
			action.animation.looping = true;
			action.name = name;
			return action;
		}

		/**
		 *  智能抽取当前可以抽取最高的宝珠
		 */
		private function upAutomaticMagic(e : Event) : void
		{
			getMagicOrbs(0);
		}

		/**服务端返回*/
		private function handleNotification(evt : Event, _arg1 : IData) : void
		{
			//宝珠状态
			if (_arg1.getCmd() == SMagicOrbsState.CMD)
			{
				getMagicOrbsState(_arg1 as SMagicOrbsState);
			}
			else if (_arg1.getCmd() == SGetMagicOrbs.CMD)
			{
				getMagicDataOrbs(_arg1 as SGetMagicOrbs);
			}
			else if (_arg1.getCmd() == SOversellItem.CMD) //出售宝珠 
			{
				var sellItem : SOversellItem = _arg1 as SOversellItem;
				if (0 == sellItem.code)
				{
					flyList();
					var sellData : GetMagicOrbs = null;
					for (var j : int = 0; j < _selectList.length; j++)
					{
						com: for (var m : int = 0; m < magicVector.length; m++)
						{
							sellData = magicVector[m] as GetMagicOrbs;
							if (sellData.id == _selectList[j])
							{
								magicVector.splice(m, 1);
								break com;
							}
						}
					}
					_selectList = new Vector.<int>;
					showGrids();
				}
				else
				{
					RollTips.add(Langue.getLangue("codeError") + sellItem.code);
				}
			}
			ShowLoader.remove();
		}

		/**飞动列表*/
		private function flyList() : void
		{
			var count : int = 0;
			var len : int = dataProvider.length;
			var k : int = 0;
			for (var i : int = 0; i < len; i++)
			{
				var oldData : GetMagicOrbs = dataProvider[i];
				if (oldData.type == 0)
					break;
				if (_selectList.indexOf(oldData.id) != -1)
				{
					var goods : Goods = Goods.goods.getValue(oldData.type);
					var widget : ViewWidget = new ViewWidget(goods);
					var v : int = ((i % 18) % 7) * (15 + 100) + list_orb.x;
					var h : int = ((i % 18) / 7) * (15 + 100) + list_orb.y + 20;
					widget.x = v;
					widget.y = h;
					k++;
					addQuiackChild(widget);
					Starling.juggler.tween(widget, 0.3, {x: Constants.FullScreenWidth, y: -90, onCompleteArgs: [widget], onComplete: complete});
				}
			}

			function complete(widget : ViewWidget) : void
			{
				widget.removeFromParent(true);
				count++;
				if (count == k)
				{
					SoundManager.instance.playSound("deal");
				}
			}
		}

		// 请求魔法宝珠状态
		private function stateSend() : void
		{
			ShowLoader.add();
			var cmd : CMagicOrbsState = new CMagicOrbsState();
			GameSocket.instance.sendData(cmd);
		}

		// 获取宝珠状态
		private function getMagicOrbsState(info : SMagicOrbsState) : void
		{
			magicState = info.magicOrbs; //保存状态
			showMagicState(); //显示状态
			ShowLoader.remove();
		}

		//获取宝珠
		private function getMagicDataOrbs(info : SGetMagicOrbs) : void
		{
			if (0 == info.code)
			{
				//抽取成功，获得宝珠
				if (info.type > 0) //小于,没有宝珠
				{
					var goods : Goods = (Goods.goods.getValue(info.type) as Goods).clone() as Goods;
					goods.id = info.id;
					showGrids(goods);
					if (goods.quality >= 4)
					{
						dataVector = new Vector.<IconData>;
						var iconData : IconData = null;
						iconData = new IconData();
						iconData.IconId = goods.id;
						iconData.QualityTrue = Res.instance.getQualityToolTextures(goods.quality);
						iconData.IconTrue = goods.picture;
						iconData.Num = "Lv " + 1;
						iconData.IconType = goods.type;
						iconData.Name = goods.name;
						dataVector.push(iconData);
						(this.parent as MagicOrbDia).isVisible = true;
						var effectData : Object = {vector: dataVector, effectPoint: null, effectName: "effect_036", effectSound: "baoxiangkaiqihuode", effectFrame: 299};
						DialogMgr.instance.open(GetGoodsAwardEffectDia, effectData, null, null, "translucence", 0x000000, 0.5);
					}
				}
				if (info.level > 1) //大于1，开启下一个宝珠等级
				{
					stateVo = magicState[info.level - 2] as magicOrbsStateVO;
					stateVo.state = 1; //开启
					showMagicState(); //重置
				}
			}
			else if (1 == info.code)
			{
				RollTips.add(Langue.getLangue("notEnoughCoin")); //金币不足
			}
			else if (2 == info.code)
			{
				RollTips.add(Langue.getLangue("notEnoughCoin")); //钻石不足
			}
			else if (3 == info.code)
			{
				RollTips.add(Langue.getLangue("ToolPackFull")); //背包已满
				showMagicState(); //重置
			}
			else if (127 <= info.code)
			{

			}
			ShowLoader.remove();
		}

		/**销毁*/
		override public function dispose() : void
		{
			magicState = null; //保存宝珠状态
			stateVo = null;
			sarah = null;
			dataVector = null;
			_selectList; //选中的物品
			_isSelect = false; // 标志当前是否选择被吞噬状态  true为选择状态
			magicVector = null;
			dataProvider = null
			super.dispose();
		}

	}
}
