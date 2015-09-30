package single
{
	import com.utils.ArrayUtil;
	import com.view.base.event.EventType;
	import com.view.base.event.ViewDispatcher;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	import game.data.ConfigData;
	import game.data.Goods;
	import game.data.HeroData;
	import game.data.HeroPriceData;
	import game.data.LuckyStarData;
	import game.data.ShopData;
	import game.data.SignData;
	import game.data.SkillData;
	import game.data.TollgateData;
	import game.data.WidgetData;
	import game.manager.HeroDataMgr;
	import game.net.data.IData;
	import game.net.data.c.CBattle;
	import game.net.data.c.CBuyhero;
	import game.net.data.c.CEmbattle;
	import game.net.data.c.CGet_sign;
	import game.net.data.c.CLuckInitInfo;
	import game.net.data.c.CLuck_start;
	import game.net.data.c.CPictorialial;
	import game.net.data.c.CSearchhero;
	import game.net.data.c.CShop;
	import game.net.data.c.CSign;
	import game.net.data.s.SBattle;
	import game.net.data.s.SBuyhero;
	import game.net.data.s.SEmbattle;
	import game.net.data.s.SGet_game_luck;
	import game.net.data.s.SGet_sign;
	import game.net.data.s.SLuckInitInfo;
	import game.net.data.s.SLuck_start;
	import game.net.data.s.SPictorialial;
	import game.net.data.s.SSearchhero;
	import game.net.data.s.SShop;
	import game.net.data.vo.BattleVo;
	import game.net.data.vo.HeroPosition;
	import game.net.data.vo.HeroVO;
	import game.net.data.vo.Pictorial;
	import game.net.data.vo.SignState;
	import game.net.data.vo.TavernHeroVo;

	public class SSingleNotify
	{
		private static var instance : SSingleNotify;

		public static function getInstance() : SSingleNotify
		{
			if (!instance)
			{
				instance = new SSingleNotify();
				instance.mSingleGameMgr = SSingleGameData.getInstance();
				instance.addListenerHandler();
			}
			return instance;
		}

		private var mDictionary : Dictionary = new Dictionary();
		private var mSingleGameMgr : SSingleGameData;

		private function addListenerHandler() : void
		{
			addHandler(CEmbattle.CMD, onEmbattleHanlder);
			addHandler(CBattle.CMD, onBattleHanlder);
			addHandler(CSearchhero.CMD, onSearchHeroHanlder);
			addHandler(CBuyhero.CMD, onBuyHeroHanlder);
			addHandler(CShop.CMD, onBuyShopItemHanlder);
			addHandler(CPictorialial.CMD, onPictorialialHanlder);
			addHandler(CLuckInitInfo.CMD, onSLuckInitInfoHanlder);
			addHandler(CLuck_start.CMD, onLuckStartHanlder);
			addHandler(CSign.CMD, onSingnHandler);
			addHandler(CGet_sign.CMD, onStartSingnHandler);
		}

		public function addHandler(eventString : int, listener : Function) : void
		{
			mDictionary[eventString] = listener;
		}

		public function receiveMessage(dataBase : IData) : void
		{
			var handler : Function = mDictionary[dataBase.getCmd()];
			if (handler != null)
			{
				handler(dataBase);
				return;
			}
			trace("发送消息:", dataBase.getCmd(), getQualifiedClassName(dataBase));
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
			if (data.type == 0 && sendMsg.heroes)
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
				vo.star = Math.random() * 5;
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
				var heroVo : HeroVO = mSingleGameMgr.createRoleByType(vo.type);
				heroVo.quality = vo.quality;
				mSingleGameMgr.mGameHeros.heroes.push(heroVo);
				sendMessage(mSingleGameMgr.mGameHeros);
				dispatch(EventType.UPDATE_MONEY);
			}
			sendMessage(sendMsg);
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
				//道具
				if (mSingleGameMgr.mGameData.bagprop == WidgetData.getCountByTab(2))
					return 3;
				//材料
				if (mSingleGameMgr.mGameData.bagmat == WidgetData.getCountByTab(1))
					return 3;
				//装备
				if (mSingleGameMgr.mGameData.bagequ == WidgetData.getCountByTab(5))
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

		private function sendMessage(data : IData) : void
		{
			ViewDispatcher.dispatch(data.getCmd() + "", data);
		}

		public function dispatch(type : String, obj : * = null) : void
		{
			ViewDispatcher.dispatch(type, obj);
		}
	}
}