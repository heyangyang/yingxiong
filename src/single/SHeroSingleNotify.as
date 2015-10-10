package single
{
	import com.utils.ArrayUtil;
	import com.view.base.event.EventType;

	import game.data.ConfigData;
	import game.data.ExpData;
	import game.data.Goods;
	import game.data.HeroData;
	import game.data.HeroPriceData;
	import game.data.MercenaryData;
	import game.data.PurgeData;
	import game.data.SkillData;
	import game.data.StarData;
	import game.data.TollgateData;
	import game.manager.HeroDataMgr;
	import game.net.data.IData;
	import game.net.data.c.CBattle;
	import game.net.data.c.CBuyhero;
	import game.net.data.c.CEmbattle;
	import game.net.data.c.CHeroBuy;
	import game.net.data.c.CHeroDismissal;
	import game.net.data.c.CHeroPotion;
	import game.net.data.c.CHeroStar;
	import game.net.data.c.CIsHeroBuy;
	import game.net.data.c.CPurge;
	import game.net.data.c.CSearchhero;
	import game.net.data.s.SBattle;
	import game.net.data.s.SBuyhero;
	import game.net.data.s.SEmbattle;
	import game.net.data.s.SHeroBuy;
	import game.net.data.s.SHeroDismissal;
	import game.net.data.s.SHeroPotion;
	import game.net.data.s.SHeroStar;
	import game.net.data.s.SPurge;
	import game.net.data.s.SSearchhero;
	import game.net.data.vo.BattleVo;
	import game.net.data.vo.GateHero;
	import game.net.data.vo.GoodsVO;
	import game.net.data.vo.HeroPosition;
	import game.net.data.vo.HeroVO;
	import game.net.data.vo.TavernHeroVo;
	import game.view.uitils.FunManager;

	/**
	 * 英雄
	 * @author hyy
	 *
	 */
	public class SHeroSingleNotify extends SSingleNotify
	{
		public function SHeroSingleNotify()
		{
			super();
			mCmdId = 14;
		}

		override protected function addListenerHandler() : void
		{
			addHandler(CEmbattle.CMD, onEmbattleHanlder);
			addHandler(CSearchhero.CMD, onSearchHeroHanlder);
			addHandler(CBuyhero.CMD, onBuyHeroHanlder);
			addHandler(CBattle.CMD, onBattleHanlder);
			addHandler(CPurge.CMD, onPurgeHandler);
			addHandler(CHeroStar.CMD, onHeroStarHandler);
			addHandler(CHeroPotion.CMD, onAddHeroExpHandler);
			addHandler(CIsHeroBuy.CMD, onGateHeroListHandler);
			addHandler(CHeroBuy.CMD, onBuyGateHeroHandler);
			addHandler(CHeroDismissal.CMD, onDismissalHeroHandler);
		}

		/**
		 * 探索英雄
		 * @param data
		 *
		 */
		private var mSearchCD : int = 600;

		private function onSearchHeroHanlder(data : CSearchhero) : void
		{
			var cd : int = (new Date().getTime() - mSingleGameMgr.mSearchHeroCD) / 1000;
			var sendMsg : SSearchhero = mSingleGameMgr.mSearchHeroData;
			cd = mSearchCD - cd;
			cd = Math.max(cd, 0);
			if (data.type == 0 && sendMsg.heroes && sendMsg.heroes.length > 0)
			{
				sendMsg.cd = cd;
				sendMessage(sendMsg);
				return;
			}
			var list : Array = ArrayUtil.change2Array(HeroData.hero.values());
			var searchList : Vector.<IData> = new Vector.<IData>();
			var vo : TavernHeroVo;
			var index : int;
			var count : int = list.length;
			var heroData : HeroData;
			for (var i : int = 0; i < 3; i++)
			{
				vo = new TavernHeroVo();
				index = count * Math.random();
				if (index == count)
					index = count - 1;
				heroData = list[index];
				vo.ravity = heroData.rarity;
				vo.id = i + 1
				vo.type = heroData.type;
				vo.quality = 1 + 6 * Math.random();
				vo.star = Math.round(Math.random() * 5);
				searchList.push(vo);
			}
			if (cd == 0)
			{
				mSingleGameMgr.mSearchHeroCD = new Date().getTime();
			}
			else
			{
				var money : int = Math.ceil((cd / 60) * ConfigData.instance.diamond_per_min);
				mSingleGameMgr.mGameData.diamond -= money;
				sendMessage(mSingleGameMgr.mGameData);
				dispatch(EventType.UPDATE_MONEY);
			}
			sendMsg.cd = mSearchCD;
			sendMsg.heroes = searchList;
			mSingleGameMgr.mBytes.mSearchHeroData = sendMsg;
			sendMessage(sendMsg);
		}

		/**
		 * 购买英雄
		 * @param data
		 *
		 */
		private function onBuyHeroHanlder(data : CBuyhero) : void
		{
			if (mSingleGameMgr.mSearchHeroData.heroes == null)
				return;
			var sendMsg : SBuyhero = new SBuyhero();
			var vo : TavernHeroVo = mSingleGameMgr.mSearchHeroData.heroes[data.id - 1];
			var heroPriceData : HeroPriceData = HeroPriceData.hash.getValue(vo.ravity + "" + vo.quality);
			if (heroPriceData.price > mSingleGameMgr.mGameData.diamond)
			{
				sendMsg.code = 2;
			}
			else
			{
				mSingleGameMgr.mGameData.diamond -= heroPriceData.price;
				var heroVo : HeroVO = mSingleGameMgr.createRoleByType(vo.type, vo.quality, vo.star);
				mSingleGameMgr.mGameHeros.heroes.push(heroVo);
				sendMessage(mSingleGameMgr.mGameHeros);
				dispatch(EventType.UPDATE_MONEY);
			}
			sendMessage(sendMsg);
		}

		/**
		 * 布阵
		 * @param data
		 *
		 */
		private function onEmbattleHanlder(data : CEmbattle) : void
		{
			var embattle : SEmbattle = new SEmbattle();
			//0成功1失败
			embattle.status = 0;
			var vo : HeroVO;
			for each (var position : HeroPosition in data.heroes)
			{
				vo = mSingleGameMgr.getRoleByType(position.id);
				vo.seat = position.position;
			}
			sendMessage(embattle);
		}

		/**
		 * 战斗
		 * @param data
		 *
		 */
		private function onBattleHanlder(data : CBattle) : void
		{
			var sendData : SBattle = new SBattle();
			var tollgateData : TollgateData = TollgateData.hash.getValue(data.currentCheckPoint);
			var heroList : Array = HeroDataMgr.instance.getOnBattleHero();
			var battleHeros : Array = ArrayUtil.change2Array(HeroDataMgr.instance.battleHeros.values());
			var list : Array = [].concat(heroList, battleHeros);
			var heroData : HeroData;
			var vo : BattleVo;
			var skillData : SkillData;
			var count : int = 0;
			while (true)
			{
				for each (heroData in list)
				{
					vo = new BattleVo();
					skillData = getSpell(heroData);
					if (!skillData)
						continue;
					vo.skill = skillData.id;
					sendData.battleCommands.push(vo);
				}
				if (count++ > 50)
					break;
				if (heroList.length == 0)
					break;
				if (battleHeros.length == 0)
					break;
			}
			sendMessage(sendData);
		}

		private function getSpell(heroData : HeroData) : SkillData
		{
			var index : int = Math.random() * 3;
			if (index == 0)
				return null;
			return SkillData.getSkill(heroData["skill" + index]);
		}

		/**
		 * 英雄进阶
		 * @param data
		 *
		 */
		private function onPurgeHandler(data : CPurge) : void
		{
			var heroVo : HeroVO = mSingleGameMgr.getRoleById(data.heroid);
			if (!heroVo)
				return;
			var heroData : HeroData = HeroDataMgr.instance.hash.getValue(data.heroid);
			var sendMsg : SPurge = new SPurge();
			var purgeData : PurgeData = PurgeData.hash.getValue(heroVo.quality); //净化数据
			var goods_id : int = purgeData ? purgeData.materials[0][0] : 0;
			var count : int = purgeData ? purgeData.materials[0][1] : 0;
			sendMsg.code = checkErrorCode();
			if (sendMsg.code == 0)
			{
				if (purgeData.type == 1)
					mSingleGameMgr.mGameData.coin -= purgeData.num;
				if (purgeData.type == 2)
					mSingleGameMgr.mGameData.diamond -= purgeData.num;
				heroVo.quality = heroVo.quality + 1;
				heroVo.updateQualityPropertys(heroVo.quality);
				mSingleGameMgr.deleteGoodsCountByType(goods_id, count);
				sendMessage(mSingleGameMgr.mGameGoods);
				sendMessage(mSingleGameMgr.mGameData);
				dispatch(EventType.UPDATE_MONEY);
			}
			sendMessage(sendMsg);


			function checkErrorCode() : int
			{
				//金币
				if (purgeData.type == 1 && mSingleGameMgr.mGameData.coin < purgeData.num)
					return 1;
				//钻石
				else if (purgeData.type == 2 && mSingleGameMgr.mGameData.diamond < purgeData.num)
					return 2;
				else if (mSingleGameMgr.getGoodsCountByType(goods_id) < count)
					return 3;
				else if (heroVo.quality == 7)
					return 4;
				return 0;
			}
		}

		/**
		 * 英雄升星
		 * @param data
		 *
		 */
		private function onHeroStarHandler(data : CHeroStar) : void
		{
			var heroVo : HeroVO = mSingleGameMgr.getRoleById(data.heroid);
			if (!heroVo)
				return;
			var heroData : HeroData = HeroDataMgr.instance.hash.getValue(data.heroid);
			var starData : StarData = StarData.hash.getValue(heroVo.foster + 1);
			var sendMsg : SHeroStar = new SHeroStar();
			sendMsg.code = checkErrorCode();

			if (sendMsg.code == 0)
			{
				if (starData.payType == 1)
					mSingleGameMgr.mGameData.coin -= starData.money;
				if (starData.payType == 2)
					mSingleGameMgr.mGameData.diamond -= starData.money;
				heroData.foster = heroVo.foster = heroVo.foster + 1;
				heroVo.updateQualityPropertys(heroVo.quality);
				mSingleGameMgr.deleteGoodsCountByType(heroVo.type, starData.materialNum);
				sendMessage(mSingleGameMgr.mGameGoods);
				sendMessage(mSingleGameMgr.mGameData);
				dispatch(EventType.UPDATE_MONEY);
			}
			sendMessage(sendMsg);
			dispatch(EventType.NOTIFY_HERO_STAR, heroData);

			function checkErrorCode() : int
			{
				if (starData == null)
					return 2;

				//金币不足
				if (starData.payType == 1 && mSingleGameMgr.mGameData.coin < starData.money)
					return 3;

				//钻石不足
				if (starData.payType == 2 && mSingleGameMgr.mGameData.diamond < starData.money)
					return 4;

				if (mSingleGameMgr.getGoodsCountByType(heroVo.type) < starData.materialNum)
					return 5;

				return 0;
			}
		}

		/**
		 * 喝经验药水
		 * @param data
		 *
		 */
		private function onAddHeroExpHandler(data : CHeroPotion) : void
		{
			var heroVo : HeroVO = mSingleGameMgr.getRoleById(data.id);
			if (!heroVo)
				return;
			var sendMsg : SHeroPotion = new SHeroPotion();
			sendMsg.code = checkErrorCode();
			if (sendMsg.code == 0)
			{
				var goodsVo : GoodsVO = mSingleGameMgr.getGoodsById(data.mats);
				var goods : Goods = Goods.goods.getValue(goodsVo.type);
				heroVo.exp += goods.magicIndex;
				var list : Array = ArrayUtil.change2Array(ExpData.hash.values());
				var len : int = list.length;
				var expData : ExpData;
				for (var i : int = heroVo.level; i < len; i++)
				{
					expData = list[i];

					if (heroVo.exp < expData.exp)
						break;
					heroVo.exp -= expData.exp;
				}
				heroVo.level = expData.id;
				var heroData : HeroData = HeroDataMgr.instance.hash.getValue(data.id);
				heroData.exp = heroVo.exp;
				heroData.level = sendMsg.level = heroVo.level;
				heroData.updateQualityPropertys(heroVo.quality);
				heroVo.updateQualityPropertys(heroVo.quality);
				mSingleGameMgr.deleteGoodsCountByType(goodsVo.type);
				sendMessage(mSingleGameMgr.mGameGoods);
				sendMessage(mSingleGameMgr.mGameData);
			}
			sendMessage(sendMsg);

			function checkErrorCode() : int
			{
				if (mSingleGameMgr.getGoodsCountById(data.mats) < 1)
					return 1;
				if (heroVo.level == 65)
					return 2;
				return 0;
			}
		}

		/**
		 * 获取雇佣兵信息
		 * @param data
		 *
		 */
		private function onGateHeroListHandler(data : CIsHeroBuy) : void
		{
			var mercenaryData : MercenaryData;
			var gateHero : GateHero;
			for each (gateHero in mSingleGameMgr.mGateHero.heroes)
			{
				mercenaryData = MercenaryData.hash.getValue(gateHero.id);
				if (gateHero.state == 1 && mSingleGameMgr.mGameData.tollgateid >= mercenaryData.pointID)
					gateHero.state = 0;
			}
			sendMessage(mSingleGameMgr.mGateHero);
		}

		/**
		 * 购买雇佣兵
		 * @param data
		 *
		 */
		private function onBuyGateHeroHandler(data : CHeroBuy) : void
		{
			var mercenaryData : MercenaryData = MercenaryData.hash.getValue(data.id);
			var sendMsg : SHeroBuy = new SHeroBuy();
			var gateHero : GateHero;
			for each (gateHero in mSingleGameMgr.mGateHero.heroes)
			{
				if (gateHero.id == data.id)
					break;
			}
			sendMsg.state = checkErrorCode();

			if (sendMsg.state == 0)
			{
				//金币不足
				if (mercenaryData.payType == 1 && mSingleGameMgr.mGameData.coin < mercenaryData.sellCount)
					mSingleGameMgr.mGameData.coin -= mercenaryData.sellCount;
				if (mercenaryData.payType == 1 && mSingleGameMgr.mGameData.diamond < mercenaryData.sellCount)
					mSingleGameMgr.mGameData.diamond -= mercenaryData.sellCount;
				gateHero.state = 2;
				var heroVo : HeroVO = mSingleGameMgr.createRoleByType(mercenaryData.heroID, mercenaryData.quality, mercenaryData.star, mercenaryData.level);
				mSingleGameMgr.mGameHeros.heroes.push(heroVo);
				sendMessage(mSingleGameMgr.mGameGoods);
				sendMessage(mSingleGameMgr.mGameData);
				sendMessage(mSingleGameMgr.mGameHeros);
				dispatch(EventType.UPDATE_MONEY);
			}
			sendMessage(sendMsg);

			function checkErrorCode() : int
			{
				//金币不足
				if (mercenaryData.payType == 1 && mSingleGameMgr.mGameData.coin < mercenaryData.sellCount)
					return 1;
				if (mSingleGameMgr.mGameData.tollgateid < mercenaryData.pointID)
					return 2;
				if (gateHero.state == 2)
					return 3;
				if (mercenaryData.payType == 1 && mSingleGameMgr.mGameData.coin < mercenaryData.sellCount)
					return 6;
				return 0;
			}
		}

		/**
		 * 分解英雄
		 * @param data
		 *
		 */
		private function onDismissalHeroHandler(data : CHeroDismissal) : void
		{
			var heroVo : HeroVO = mSingleGameMgr.getRoleById(data.id);
			if (!heroVo)
				return;
			var heroData : HeroData = HeroData.hero.getValue(heroVo.type);
			var heroPriceData : HeroPriceData = HeroPriceData.hash.getValue((heroData.rarity == 0 ? 1 : heroData.rarity) + "" + heroVo.quality) as HeroPriceData;
			var sendMsg : SHeroDismissal = new SHeroDismissal();
			sendMsg.code = checkErrorCode();
			if (sendMsg.code == 0)
			{
				HeroDataMgr.instance.hash.remove(data.id);
				mSingleGameMgr.mGameData.diamond += FunManager.hero_dismissal(heroPriceData.price, heroData.level);

				var expData : ExpData = ExpData.hash.getValue(heroVo.level);

				if (expData && expData.item)
				{
					var tmp_arr : Array = expData.item.match(/\{[\d,\,]*\}/gs);
					var len : int = tmp_arr.length;
					var tmp_goodsArr : Array;
					for (var i : int = 0; i < len; i++)
					{
						tmp_goodsArr = tmp_arr[i].match(/\d+/gs);
						mSingleGameMgr.addGoodsByType(tmp_goodsArr[0], tmp_goodsArr[1]);
					}
				}
				sendMessage(mSingleGameMgr.mGameGoods);
				sendMessage(mSingleGameMgr.mGameData);
				dispatch(EventType.UPDATE_MONEY);
			}
			sendMessage(sendMsg);

			function checkErrorCode() : int
			{
				if (mSingleGameMgr.isPackageIsFull(2))
					return 3;
				return 0;
			}
		}
	}
}