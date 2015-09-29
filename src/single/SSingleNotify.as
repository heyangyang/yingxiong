package single
{
	import com.utils.ArrayUtil;
	import com.view.base.event.EventType;
	import com.view.base.event.ViewDispatcher;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import game.data.ConfigData;
	import game.data.HeroData;
	import game.data.HeroPriceData;
	import game.data.ShopData;
	import game.data.SkillData;
	import game.data.TollgateData;
	import game.manager.HeroDataMgr;
	import game.net.data.IData;
	import game.net.data.c.CBattle;
	import game.net.data.c.CBuyhero;
	import game.net.data.c.CEmbattle;
	import game.net.data.c.CSearchhero;
	import game.net.data.c.CShop;
	import game.net.data.s.SBattle;
	import game.net.data.s.SBuyhero;
	import game.net.data.s.SEmbattle;
	import game.net.data.s.SSearchhero;
	import game.net.data.s.SShop;
	import game.net.data.vo.BattleVo;
	import game.net.data.vo.HeroPosition;
	import game.net.data.vo.HeroVO;
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
			addHandler(CEmbattle.CMD, onEmbattleHanlder)
			addHandler(CBattle.CMD, onBattleHanlder)
			addHandler(CSearchhero.CMD, onSearchHeroHanlder)
			addHandler(CBuyhero.CMD, onBuyHeroHanlder)
			addHandler(CShop.CMD, onBuyShopItemHanlder)
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
		private var mSearchList : Vector.<IData>;
		private var mSearchCD : int = 600;

		private function onSearchHeroHanlder(data : CSearchhero) : void
		{
			var cd : int = (new Date().getTime() - mSingleGameMgr.mSearchHeroCD) / 1000;
			cd = mSearchCD - cd;
			cd = Math.max(cd, 0);
			if (data.type == 0 && mSearchList)
			{
				sendMsg.cd = cd;
				sendMessage(sendMsg);
				return;
			}
			var list : Array = ArrayUtil.change2Array(HeroData.hero.values());
			var sendMsg : SSearchhero = new SSearchhero();
			mSearchList = new Vector.<IData>();
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
				mSearchList.push(vo);
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
			sendMsg.heroes = mSearchList;
			sendMessage(sendMsg);
		}

		/**
		 * 购买英雄
		 * @param data
		 *
		 */
		private function onBuyHeroHanlder(data : CBuyhero) : void
		{
			if (mSearchList == null)
				return;
			var sendMsg : SBuyhero = new SBuyhero();
			var vo : TavernHeroVo = mSearchList[data.id - 1];
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
						
						break;
				}
				mSingleGameMgr.mGameData.diamond -= price;
				sendMessage(mSingleGameMgr.mGameData);
				dispatch(EventType.UPDATE_MONEY);
			}
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