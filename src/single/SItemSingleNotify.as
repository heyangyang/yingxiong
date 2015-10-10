package single
{
	import com.utils.ArrayUtil;
	import com.view.base.event.EventType;

	import game.data.Goods;
	import game.data.HeroData;
	import game.data.JewelLevData;
	import game.data.LuckyStarData;
	import game.data.MagicorbsData;
	import game.data.ShopData;
	import game.data.SignData;
	import game.data.StrengthenData;
	import game.data.StrenthenRateData;
	import game.data.WidgetData;
	import game.manager.HeroDataMgr;
	import game.net.data.IData;
	import game.net.data.c.CGetMagicOrbs;
	import game.net.data.c.CGet_sign;
	import game.net.data.c.CJewelry;
	import game.net.data.c.CLuckInitInfo;
	import game.net.data.c.CLuck_start;
	import game.net.data.c.CMagicOrbsState;
	import game.net.data.c.COversellItem;
	import game.net.data.c.CPictorialial;
	import game.net.data.c.CSetEquip;
	import game.net.data.c.CShop;
	import game.net.data.c.CSign;
	import game.net.data.c.CStrengthen;
	import game.net.data.s.SGetMagicOrbs;
	import game.net.data.s.SGet_game_luck;
	import game.net.data.s.SGet_sign;
	import game.net.data.s.SJewelry;
	import game.net.data.s.SLuckInitInfo;
	import game.net.data.s.SLuck_start;
	import game.net.data.s.SOversellItem;
	import game.net.data.s.SPictorialial;
	import game.net.data.s.SSetEquip;
	import game.net.data.s.SShop;
	import game.net.data.s.SStrengthen;
	import game.net.data.vo.AotoEquipVO;
	import game.net.data.vo.EquipVO;
	import game.net.data.vo.GoodsVO;
	import game.net.data.vo.HeroVO;
	import game.net.data.vo.Pictorial;
	import game.net.data.vo.SignState;
	import game.net.data.vo.magicOrbsStateVO;

	/**
	 * 物品
	 * @author hyy
	 *
	 */
	public class SItemSingleNotify extends SSingleNotify
	{
		public function SItemSingleNotify()
		{
			super();
			mCmdId = 13;
		}

		override protected function addListenerHandler() : void
		{
			addHandler(CShop.CMD, onBuyShopItemHanlder);
			addHandler(CPictorialial.CMD, onPictorialialHanlder);
			addHandler(CLuckInitInfo.CMD, onSLuckInitInfoHanlder);
			addHandler(CLuck_start.CMD, onLuckStartHanlder);
			addHandler(CSign.CMD, onSingnHandler);
			addHandler(CGet_sign.CMD, onStartSingnHandler);
			addHandler(CSetEquip.CMD, onEquipHandler);
			addHandler(CStrengthen.CMD, onStrengthenHandler);
			addHandler(CMagicOrbsState.CMD, onGetMagicorbsStateHandler);
			addHandler(CGetMagicOrbs.CMD, onGetMagicorbsHandler);
			addHandler(CJewelry.CMD, onJewelryHandler);
			addHandler(COversellItem.CMD, onSellItemHandler);
		}

		/**
		 * 购买商品
		 * @param data
		 *
		 */
		private function onBuyShopItemHanlder(data : CShop) : void
		{
			var sendMsg : SShop = new SShop();
			var shopData : ShopData = ShopData.hash.getValue(data.id);
			var price : int = shopData.count * shopData.cost;

			if (price > mSingleGameMgr.mGameData.diamond)
			{
				sendMsg.code = 2;
			}
			if (sendMsg.code == 0)
			{
				switch (shopData.type)
				{
					//金币
					case 1:
						mSingleGameMgr.mGameData.coin += shopData.count;
						break;
					//幸运星:
					case 3:
						mSingleGameMgr.mGameData.lucknum += shopData.count;
						break;
					//扫荡符
					case 12:
					//喇叭
					case 8:
						return;
						break;
					//物品
					default:
						mSingleGameMgr.addGoodsByType(shopData.type, shopData.count);
						sendMessage(mSingleGameMgr.mGameGoods);
						break;
				}
				mSingleGameMgr.mGameData.diamond -= price;
				sendMessage(mSingleGameMgr.mGameData);
				dispatch(EventType.UPDATE_MONEY);
			}
			sendMessage(sendMsg);
		}

		/**
		 * 图鉴
		 * @param data
		 *
		 */
		private function onPictorialialHanlder(data : CPictorialial) : void
		{
			var sendMsg : SPictorialial = new SPictorialial();
			var pictorial : Pictorial;
			sendMsg.herose = new Vector.<IData>();
			for each (var heroVo : HeroVO in mSingleGameMgr.mGameHeros.heroes)
			{
				pictorial = new Pictorial();
				pictorial.id = heroVo.id;
				sendMsg.herose.push(pictorial);
			}
			sendMessage(sendMsg);
		}

		/**
		 * 获取幸运星列表
		 * @param data
		 *
		 */
		private function onSLuckInitInfoHanlder(data : CLuckInitInfo) : void
		{
			var sendMsg : SLuckInitInfo = new SLuckInitInfo();
			sendMsg.id = 1;
			sendMsg.luck = mSingleGameMgr.mGameData.lucknum;
			sendMessage(sendMsg);
		}

		/**
		 * 开始幸运星抽奖
		 * @param data
		 *
		 */
		private function onLuckStartHanlder(data : CLuck_start) : void
		{
			var sendMsg : SLuck_start = new SLuck_start();
			var list : Array = ArrayUtil.change2Array(LuckyStarData.hash.values());
			var index : int = (list.length - 1) * Math.random();
			var luckyData : LuckyStarData = list[index];
			var goods : Goods = Goods.goods.getValue(luckyData.type);
			sendMsg.code = checkErrorCode();
			sendMsg.pos = luckyData.pos;
			if (sendMsg.code == 0)
			{
				mSingleGameMgr.mGameData.lucknum--;
				switch (goods.type)
				{
					//金币
					case 1:
						mSingleGameMgr.mGameData.coin += luckyData.num;
						break;
					//幸运星
					case 3:
						break;
					//疲劳值
					case 7:
						mSingleGameMgr.mGameData.tired += luckyData.num;
						sendMessage(mSingleGameMgr.mGameData);
						dispatch(EventType.UPDATE_TIRED);
						break;
					//物品
					default:
						mSingleGameMgr.addGoodsByType(luckyData.type, luckyData.num);
						sendMessage(mSingleGameMgr.mGameGoods);
						break;
				}
				var luckMsg : SGet_game_luck = new SGet_game_luck();
				luckMsg.luck = mSingleGameMgr.mGameData.lucknum;
				sendMessage(luckMsg);
			}

			sendMessage(sendMsg);

			function checkErrorCode() : int
			{
				if (mSingleGameMgr.mGameData.lucknum == 0)
					return 1;
				if (mSingleGameMgr.isPackageIsFull(goods.tab))
					return 3;
				return 0;
			}
		}




		/**
		 * 获取签到信息
		 * @param data
		 *
		 */
		private function onSingnHandler(data : CSign) : void
		{
			sendMessage(mSingleGameMgr.mSign);
		}

		/**
		 * 开始签到
		 * @param data
		 *
		 */
		private function onStartSingnHandler(data : CGet_sign) : void
		{
			var state : SignState = mSingleGameMgr.mSign.days[data.day - 1];
			var sendMsg : SGet_sign = new SGet_sign();
			if (state && state.state == 1)
			{
				state.state = 2;
				sendMsg.state = 2;

				var arrSignData : Array = ArrayUtil.change2Array(SignData.hash.values());
				var len : int = arrSignData.length;
				var tmpSignData : SignData;
				for (var i : int = 0; i < len; i++)
				{
					tmpSignData = arrSignData[i] as SignData;
					if (tmpSignData.id == data.day)
					{
						mSingleGameMgr.mGameData.coin += tmpSignData.coin;
						mSingleGameMgr.mGameData.diamond += tmpSignData.diamond;
						var list : Array = tmpSignData.tid_num.match(/\{[\d,\,]*\}/gs);
						var goodsLen : int = list.length;
						var items : Array;
						for (i = 0; i < goodsLen; i++)
						{
							items = list[i].match(/\d+/gs);
							mSingleGameMgr.addGoodsByType(items[0], items[1]);
						}
						sendMessage(mSingleGameMgr.mGameData);
						sendMessage(mSingleGameMgr.mGameGoods);
						dispatch(EventType.UPDATE_MONEY);
						break;
					}
				}
			}
			else if (state && state.state == 2)
				sendMsg.code = 1;
			else
				sendMsg.code = 2;
			sendMessage(sendMsg);
		}

		/**
		 * 穿戴装备
		 * @param data
		 *
		 */
		private function onEquipHandler(data : CSetEquip) : void
		{
			var sendMsg : SSetEquip = new SSetEquip();
			var equipVo : EquipVO;
			var heroVO : HeroVO;
			var heroData : HeroData;
			for each (var vo : AotoEquipVO in data.aotoEquipVO)
			{
				heroVO = mSingleGameMgr.getRoleById(vo.heroID);
				heroData = HeroDataMgr.instance.hash.getValue(heroVO.id);
				//从背包里获取装备
				equipVo = mSingleGameMgr.getEquipById(vo.equipID);

				if (equipVo)
					sendMsg.code = equipGoods(equipVo, heroVO);
				else
				{
					equipVo = mSingleGameMgr.getEquipById(heroVO["seat" + vo.seat]);
					sendMsg.code = unEquipGoods(equipVo, heroVO);
				}
				if (sendMsg.code > 0)
					break;
				heroData.updateQualityPropertys(heroData.quality);
			}
			sendMessage(sendMsg);

			/**
			 * 穿戴装备
			 * @param equip
			 * @param heroVO
			 * @return
			 *
			 */
			function equipGoods(equip : EquipVO, heroVO : HeroVO) : int
			{
				var goods : Goods = Goods.goods.getValue(equip.type);

				if (heroVO.level < goods.limitLevel)
				{
					return 2;
				}

				var oldSeatId : int = heroVO["seat" + vo.seat];
				//卸载原来的装备
				if (oldSeatId > 0)
					unEquipGoods(mSingleGameMgr.getEquipById(oldSeatId), heroVO);
				equip.equip = vo.heroID;
				heroVO["seat" + vo.seat] = equip.id;
				heroData["seat" + vo.seat] = equip.id;
				return 0;
			}

			/**
			 * 卸载装备
			 * @param equip
			 * @param heroVO
			 * @return
			 *
			 */
			function unEquipGoods(equip : EquipVO, heroVO : HeroVO) : int
			{
				var goods : Goods = Goods.goods.getValue(equip.type);

				//背包是否满了
				if (vo.equipID == 0 && mSingleGameMgr.isPackageIsFull(goods.tab))
				{
					return 1;
				}
				equip.equip = 0;
				heroVO["seat" + vo.seat] = 0;
				heroData["seat" + vo.seat] = 0;
				return 0;
			}
		}


		/**
		 * 强化
		 * @param data
		 *
		 */
		private function onStrengthenHandler(data : CStrengthen) : void
		{
			var sendMsg : SStrengthen = new SStrengthen();
			var equip : WidgetData = WidgetData.hash.getValue(data.equid);
			var stone1 : WidgetData = WidgetData.getWidgetByType(data.enId1);
			var stone2 : WidgetData = WidgetData.getWidgetByType(data.enId2);
			var stone3 : WidgetData = WidgetData.getWidgetByType(data.enId3);
			var stoneList : Array = [stone1, stone2, stone3];
			var rate : int = getRate(equip, stoneList);
			var strengthenData : StrengthenData = StrengthenData.hash.getValue(equip.sort + "" + (equip.level + 1));
			sendMsg.code = checkErrorCode();
			var equioVo : EquipVO = mSingleGameMgr.getEquipById(data.equid);
			sendMsg.equid = equip.id;
			sendMsg.level = equioVo.level;
			if (sendMsg.code == 0 || sendMsg.code == 1)
			{
				if (sendMsg.code == 0)
					sendMsg.level = equioVo.level = equip.level = equip.level + 1;
				mSingleGameMgr.mGameData.coin -= strengthenData.coin;
				stone1 && mSingleGameMgr.deleteGoodsCountByType(data.enId1);
				stone2 && mSingleGameMgr.deleteGoodsCountByType(data.enId2);
				stone3 && mSingleGameMgr.deleteGoodsCountByType(data.enId3);
				sendMessage(mSingleGameMgr.mGameGoods);
				sendMessage(mSingleGameMgr.mGameData);
				dispatch(EventType.UPDATE_MONEY);
				dispatch(EventType.UPDATE_POWER);
				dispatch(EventType.NOTIFY_HERO_EQUIP);
			}
			sendMessage(sendMsg);

			function checkErrorCode() : int
			{
				if (equip.enhance_limit > 0 && equip.level == equip.enhance_limit)
					return 5;
				if (mSingleGameMgr.mGameData.coin < strengthenData.coin)
					return 2;
				//强化失败
				if (Math.random() * 100 > rate)
					return 1;
				return 0;
			}

			function getRate(equipData : WidgetData, stoneList : Array) : int
			{
				if (!equipData)
					return 0;
				var rate : int = 0;
				var curr_equip_level : int = equipData ? equipData.level + 1 : 0;
				var strengthenData : StrenthenRateData;
				var goods : Goods;
				for (var i : int = 0, len : int = stoneList.length; i < len; i++)
				{
					goods = stoneList[i];
					if (!goods)
						continue;
					strengthenData = StrenthenRateData.hash.getValue(curr_equip_level + "" + goods.type);
					if (strengthenData == null)
					{
						trace("找不到强化等级几率", curr_equip_level);
						continue;
					}
					rate += strengthenData.rate;
				}
				rate *= equipData ? equipData.strenthenSuccessFactor : 0;
				rate = rate / 10;
				return (rate > 100 ? 100 : rate);
			}
		}

		/**
		 * 获取宝珠状态
		 * @param data
		 *
		 */
		private function onGetMagicorbsStateHandler(data : CMagicOrbsState) : void
		{
			sendMessage(mSingleGameMgr.mMagicOrbsState);
		}

		/**
		 * 抽宝珠
		 * @param data
		 *
		 */
		private function onGetMagicorbsHandler(data : CGetMagicOrbs) : void
		{
			if (data.level == 0)
			{
				data.level = 1;
				var len : int = mSingleGameMgr.mMagicOrbsState.magicOrbs.length;
				for (var i : int = 0; i < len; i++)
				{
					vo = mSingleGameMgr.mMagicOrbsState.magicOrbs[i] as magicOrbsStateVO;
					if (vo.state == 1)
					{
						data.level = vo.level;
						break;
					}
				}
			}
			var magicorbsData : MagicorbsData = MagicorbsData.hash.getValue(data.level);
			var sendMsg : SGetMagicOrbs = new SGetMagicOrbs();
			var rates : Array = [0, 95, 85, 75, 70, 65];
			var vo : magicOrbsStateVO;
			sendMsg.code = checkErrorCode();
			if (sendMsg.code == 0)
			{
				var rate : int = rates[data.level];
				if (Math.random() * 100 < rate)
					sendMsg.level = data.level + 1;
				else
					sendMsg.level = 1;
				if (sendMsg.level > 5)
					sendMsg.level = 5;
				var list : Vector.<Goods> = Goods.getMagicBalls(data.level);
				var goods : Goods = list[Math.round((list.length - 1) * Math.random())]
				sendMsg.id = mSingleGameMgr.id;
				sendMsg.type = goods.type;
				if (magicorbsData.coinType == 1)
					mSingleGameMgr.mGameData.coin -= magicorbsData.coinCount;
				if (magicorbsData.coinType == 2)
					mSingleGameMgr.mGameData.diamond -= magicorbsData.coinCount;

				mSingleGameMgr.addGoodsByType(goods.type, 1, 1);
				sendMessage(mSingleGameMgr.mGameGoods);
				sendMessage(mSingleGameMgr.mGameData);
				dispatch(EventType.UPDATE_MONEY);
			}
			sendMessage(sendMsg);
			if (data.level > 1)
			{
				vo = mSingleGameMgr.mMagicOrbsState.magicOrbs[data.level - 2];
				vo.state = 0;
				sendMessage(mSingleGameMgr.mMagicOrbsState);
			}

			function checkErrorCode() : int
			{
				//金币不足
				if (magicorbsData.coinType == 1 && mSingleGameMgr.mGameData.coin < magicorbsData.coinCount)
					return 1;

				//钻石不足
				if (magicorbsData.coinType == 2 && mSingleGameMgr.mGameData.diamond < magicorbsData.coinCount)
					return 2;

				if (mSingleGameMgr.isPackageIsFull(2))
					return 3;

				return 0;
			}
		}

		/**
		 * 吞噬宝珠
		 * @param data
		 *
		 */
		private function onJewelryHandler(data : CJewelry) : void
		{
			var goodsVo : GoodsVO = mSingleGameMgr.getGoodsById(data.id);
			if (!goodsVo)
				return;
			var sendMsg : SJewelry = new SJewelry();
			var exp : int = 0;
			var tGoodsVo : GoodsVO;
			var tGoods : Goods;
			var tUpgradeData : JewelLevData;
			var needMoney : int = 0;
			var len : int = data.ids.length, i : int, id : int;
			sendMsg.code = checkErrorCode();
			if (sendMsg.code == 0)
			{
				//添加经验
				goodsVo.exp += exp;
				//删除物品
				for (i = 0; i < len; i++)
				{
					id = data.ids[i];
					mSingleGameMgr.deleteGoodsCountById(id);
				}
				//判断是否需要升级
				tGoods = Goods.goods.getValue(goodsVo.type);
				while (true)
				{
					tUpgradeData = JewelLevData.JewelLevHash.getValue(goodsVo.level + "" + tGoods.quality);
					if (tUpgradeData && goodsVo.exp >= tUpgradeData.exp)
					{
						tUpgradeData.exp -= tUpgradeData.exp;
						tUpgradeData = JewelLevData.JewelLevHash.getValue((goodsVo.level + 1) + "" + tGoods.quality);
						if (tUpgradeData)
							goodsVo.level++;
						else
						{
							goodsVo.exp = 0;
							break;
						}
						continue;
					}
					break;
				}
				sendMsg.exp = goodsVo.exp;
				sendMsg.level = goodsVo.level;
				mSingleGameMgr.mGameData.coin -= needMoney;
				sendMessage(mSingleGameMgr.mGameGoods);
				sendMessage(mSingleGameMgr.mGameData);
				dispatch(EventType.UPDATE_MONEY);
			}
			sendMessage(sendMsg);

			function checkErrorCode() : int
			{
				for (i = 0; i < len; i++)
				{
					id = data.ids[i];
					tGoodsVo = mSingleGameMgr.getGoodsById(id);
					if (!tGoodsVo)
						return 2;
					tGoods = Goods.goods.getValue(tGoodsVo.type);
					tUpgradeData = JewelLevData.JewelLevHash.getValue(tGoodsVo.level + "" + tGoods.quality);
					exp += tUpgradeData.provide;
					needMoney += tUpgradeData.coin;
				}
				//金币不足
				if (mSingleGameMgr.mGameData.coin < needMoney)
					return 4;

				return 0;
			}
		}

		/**
		 * 出售物品
		 * @param data
		 *
		 */
		private function onSellItemHandler(data : COversellItem) : void
		{
			var sendMsg : SOversellItem = new SOversellItem();
			var len : int = data.ids.length;
			var money : int = 0;
			var goods : Goods;
			var goodsVo : GoodsVO;

			for (var i : int = 0; i < len; i++)
			{
				goodsVo = mSingleGameMgr.deleteGoodsCountById(data.ids[i]);
				goods = Goods.goods.getValue(goodsVo.type);
				money += goods.Price;
				dispatch(EventType.SELL_GOODS, WidgetData.hash.getValue(goodsVo.id));
			}
			mSingleGameMgr.mGameData.coin += money;
			sendMessage(sendMsg);
		}
	}

}