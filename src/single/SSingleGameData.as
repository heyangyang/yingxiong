package single
{
	import com.scene.SceneMgr;
	import com.utils.ArrayUtil;
	import com.view.base.event.ViewDispatcher;

	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.setInterval;

	import avmplus.getQualifiedClassName;

	import game.data.Goods;
	import game.data.HeroData;
	import game.data.MercenaryData;
	import game.data.WidgetData;
	import game.net.data.IData;
	import game.net.data.s.SAllgoods;
	import game.net.data.s.SGet_all_hero;
	import game.net.data.s.SGet_game_data;
	import game.net.data.s.SIsHeroBuy;
	import game.net.data.s.SMagicOrbsState;
	import game.net.data.s.SSearchhero;
	import game.net.data.s.SSign;
	import game.net.data.vo.EquipVO;
	import game.net.data.vo.GateHero;
	import game.net.data.vo.GoodsVO;
	import game.net.data.vo.HeroVO;
	import game.net.data.vo.SignState;
	import game.net.data.vo.magicOrbsStateVO;
	import game.scene.GameLoadingScene;

	/**
	 * 单机数据
	 * @author hyy
	 *
	 */
	public class SSingleGameData
	{
		/**
		 * 是否单机游戏
		 */
		public static const isSingleGame : Boolean = true;

		private static var instance : SSingleGameData;

		public static function getInstance() : SSingleGameData
		{
			if (!instance)
			{
				instance = new SSingleGameData();
				instance.init();
			}
			return instance;
		}
		/**
		 * 唯一id标示
		 */
		private var mId : int;
		/**
		 * 所有数据
		 */
		internal var mBytes : Object;
		/**
		 * 是否创建了角色
		 */
		internal var mIsCreate : Boolean;
		/**
		 * 所搜英雄的cd
		 */
		internal var mSearchHeroCD : Number;
		/**
		 * 玩家基础信息数据
		 */
		internal var mGameData : SGet_game_data;
		/**
		 * 玩家所有英雄数据
		 */
		internal var mGameHeros : SGet_all_hero;
		/**
		 * 玩家所有物品数据
		 */
		internal var mGameGoods : SAllgoods;
		/**
		 * 探索英雄
		 */
		internal var mSearchHeroData : SSearchhero;
		/**
		 * 探索宝珠
		 */
		internal var mMagicOrbsState : SMagicOrbsState;
		/**
		 * 关卡英雄
		 */
		internal var mGateHero : SIsHeroBuy;
		/**
		 * 签到信息
		 */
		internal var mSign : SSign;
		internal var mSignDay : int;

		private function init() : void
		{
			var bytes : ByteArray = EncryptedLocalStore.getItem("s_d");
			if (!bytes)
			{
				bytes = new ByteArray();
				mBytes = {};
			}
			else
			{
				mBytes = bytes.readObject();
				for (var key : String in mBytes)
				{
					if (mBytes[key] is Boolean)
						continue;
					if (mBytes[key] is int)
						continue;
					if (mBytes[key] is Number)
						continue;
					mBytes[key] = readObject2Data(mBytes[key]);
				}
			}

			mIsCreate = mBytes.mIsCreate;
			mId = mBytes.mId;
			mSearchHeroCD = mBytes.mSearchHeroCD;
			mSignDay = mBytes.mSignDay;
			setInterval(save, 30000);
		}

		public function get id() : int
		{
			return ++mId;
		}

		/**
		 * 检测是否创建了角色
		 *
		 */
		public function checkIsCreateRole() : void
		{
			if (!mIsCreate)
			{
				mId = 0;
				mGameData = new SGet_game_data();
				mGameData.level = 1;
				mGameData.tollgateid = 99;
				mGameData.tired = 100;
				mGameData.diamond = 199999;
				mGameData.coin = 999999;
				mGameData.arenaname = "";
				mGameData.herotab = 8;
				mGameData.bagequ = mGameData.bagmat = mGameData.bagprop = 20;
				mBytes.data = mGameData;

				mGameHeros = new SGet_all_hero();
				var heros : Vector.<IData> = new Vector.<IData>();
				heros.push(createRoleByType(30001, 1, 0));
				mGameHeros.heroes = heros;
				mBytes.heros = mGameHeros;

				mGameGoods = new SAllgoods();
				mGameGoods.type = 1;
				mGameGoods.equip = new Vector.<IData>();
				mGameGoods.props = new Vector.<IData>();

				mSearchHeroData = new SSearchhero();
				mSearchHeroData.heroes = new Vector.<IData>();
				mBytes.goods = mGameGoods;
				mBytes.mSearchHeroData = mSearchHeroData;


				mMagicOrbsState = new SMagicOrbsState();
				mMagicOrbsState.magicOrbs = new Vector.<IData>();
				var magicOrbVo : magicOrbsStateVO;
				for (var i : int = 2; i <= 5; i++)
				{
					magicOrbVo = new magicOrbsStateVO();
					magicOrbVo.level = i;
					magicOrbVo.state = 0;
					mMagicOrbsState.magicOrbs.push(magicOrbVo);
				}
				mBytes.mMagicOrbsState = mMagicOrbsState;

				mGateHero = new SIsHeroBuy();
				mGateHero.heroes = new Vector.<IData>();
				var list : Array = ArrayUtil.change2Array(MercenaryData.hash.values());
				var mercenaryData : MercenaryData;
				var gateHero : GateHero;
				for each (mercenaryData in list)
				{
					gateHero = new GateHero();
					gateHero.id = mercenaryData.id;
					gateHero.state = 1;
					mGateHero.heroes.push(gateHero);
				}
				mBytes.mGateHero = mGateHero;

				mSign = new SSign();
				mSign.type = 1;
				mSign.days1 = 1;
				mSign.days2 = 1;
				mSign.days = new Vector.<IData>();
				var state : SignState;
				for (i = 0; i < 7; i++)
				{
					state = new SignState();
					state.day = i + 1;
					state.state = i == 0 ? 1 : 0;
					mSign.days.push(state);
				}

				mBytes.mSign = mSign;
				mSignDay = new Date().getDay();
			}
			mIsCreate = true;
			readRoleInfomation();
			SceneMgr.instance.changeScene(GameLoadingScene);
		}

		/**
		 * 读取玩家资料
		 *
		 */
		private function readRoleInfomation() : void
		{
			mGameData = mBytes.data;
			mGameHeros = mBytes.heros;
			mGameGoods = mBytes.goods;
			initHeroEquip();


			mSearchHeroData = mBytes.mSearchHeroData;
			mMagicOrbsState = mBytes.mMagicOrbsState;
			mGateHero = mBytes.mGateHero;

			mSign = mBytes.mSign;
			//新一天登录签到
			if (mSignDay != new Date().getDay())
			{
				onSignHanlder();
			}
			ViewDispatcher.dispatch(mGameGoods.getCmd() + "", mGameGoods);
			ViewDispatcher.dispatch(mGameData.getCmd() + "", mGameData);
			ViewDispatcher.dispatch(mGameHeros.getCmd() + "", mGameHeros);
		}

		internal function onSignHanlder() : void
		{
			var state : SignState;
			for (var i : int = 0; i < 7; i++)
			{
				state = mSign.days[i] as SignState;
				if (state.state == 0)
				{
					state.state = 1;
					return;
				}
			}

			//清零
			for (i = 0; i < 7; i++)
			{
				state = mSign.days[i] as SignState;
				if (state.state == 0)
				{
					state.state = i == 0 ? 1 : 0;
					return;
				}
			}
		}

		/**
		 * 根据type创建英雄
		 * @param type
		 * @return
		 *
		 */
		internal function createRoleByType(type : int, quality : int, star : int, level : int = 1) : HeroVO
		{
			var heroData : HeroData = HeroData.hero.getValue(type) as HeroData;
			var heroVo : HeroVO = new HeroVO();
			heroVo.hp = heroData.hp;
			heroVo.attack = heroData.attack;
			heroVo.defend = heroData.defend;
			heroVo.puncture = heroData.puncture;
			heroVo.hit = heroData.hit;
			heroVo.dodge = heroData.dodge;
			heroVo.crit = heroData.crit;
			heroVo.critPercentage = heroData.critPercentage;
			heroVo.anitCrit = heroData.anitCrit;
			heroVo.toughness = heroData.toughness;
			heroVo.level = level;
			heroVo.id = id;
			heroVo.type = type;
			heroVo.quality = quality;
			heroVo.foster = star;
			heroVo.updateQualityPropertys(quality);
			return heroVo;
		}

		/**
		 * 添加物品到背包
		 * @param type
		 * @param count 数量
		 * @return
		 *
		 */
		internal function addGoodsByType(type : int, count : int = 1, level : int = 1) : void
		{
			var data : WidgetData = new WidgetData(Goods.goods.getValue(type));

			switch (data.tab)
			{
				//材料
				case 1:
				//道具
				case 2:
					//幸运星
					if (data.type == 3)
					{
						mGameData.lucknum += count;
						return;
					}
					goodsVo = ArrayUtil.getArrayObjByField(mGameGoods.props, type, "type") as GoodsVO;
					if (goodsVo && goodsVo.pile + count < 99)
					{
						goodsVo.pile += count;
					}
					else
					{
						//最大堆叠数99
						var maxCount : int = Math.min(count, 99);
						count -= maxCount;
						var goodsVo : GoodsVO = new GoodsVO();
						readObject(goodsVo, data);
						data.pile = goodsVo.pile = maxCount;
						goodsVo.id = id;
						goodsVo.level = level;
						mGameGoods.props.push(goodsVo);
						if (count > 0)
							addGoodsByType(type, count);
					}
					break;
				//装备
				case 5:
					data.pile = 1;
					var equipVo : EquipVO = new EquipVO();
					readObject(equipVo, data);
					equipVo.id = id;
					mGameGoods.equip.push(equipVo);
					break;
			}
		}


		/**
		 * 否个类型包包是否已满
		 * @param tab
		 * @return
		 *
		 */
		internal function isPackageIsFull(tab : int) : Boolean
		{
			//道具
			if (tab == 2 && mGameData.bagprop <= WidgetData.getCountByTab(2))
				return true;
			//材料
			if (tab == 1 && mGameData.bagmat <= WidgetData.getCountByTab(1))
				return true;
			//装备
			if (tab == 5 && mGameData.bagequ <= WidgetData.getCountByTab(5))
				return true;
			return false;
		}

		/**
		 * 初始化人物装备
		 *
		 */
		internal function initHeroEquip() : void
		{
			var vo : EquipVO;
			var heroVo : HeroVO;
			var goods : Goods;
			for each (vo in mGameGoods.equip)
			{
				goods = Goods.goods.getValue(vo.type);
				if (vo.equip == 0)
					continue;
				heroVo = getRoleById(vo.equip);
				heroVo["seat" + goods.seat] = vo.id;
			}
		}

		/**
		 * 根据type获得装备
		 * @param type
		 * @return
		 *
		 */
		internal function getEquipByType(type : int) : EquipVO
		{
			var vo : EquipVO;
			for each (vo in mGameGoods.equip)
			{
				if (vo.type == type)
					return vo;
			}
			return null;
		}

		/**
		 * 根据物品type获得数量
		 * @param type
		 * @return
		 *
		 */
		internal function getGoodsCountByType(type : int) : int
		{
			var vo : GoodsVO;
			var count : int = 0;
			for each (vo in mGameGoods.props)
			{
				if (vo.type == type)
					count += vo.pile;
			}
			return count;
		}

		internal function getGoodsCountById(id : int) : int
		{
			var vo : GoodsVO;
			var count : int = 0;
			for each (vo in mGameGoods.props)
			{
				if (vo.id == id)
					count += vo.pile;
			}
			return count;
		}

		internal function getGoodsById(id : int) : GoodsVO
		{
			var vo : GoodsVO;
			var count : int = 0;
			for each (vo in mGameGoods.props)
			{
				if (vo.id == id)
					return vo;
			}
			return null;
		}

		internal function deleteGoodsCountByType(type : int, count : int = 1) : void
		{
			var vo : GoodsVO;
			for each (vo in mGameGoods.props)
			{
				if (vo.type == type)
				{
					if (vo.pile > count)
					{
						vo.pile -= count;
						return;
					}
					var index : int = mGameGoods.props.indexOf(vo);
					mGameGoods.props.splice(index, 1);
					count -= vo.pile;
				}
			}

			throw new Error("物品不足！");
		}

		/**
		 * 根据id删除物品。
		 * @param id
		 * @param count 默认0，删除全部
		 *
		 */
		internal function deleteGoodsCountById(id : int, count : int = 0) : GoodsVO
		{
			var vo : GoodsVO;
			for each (vo in mGameGoods.props)
			{
				if (vo.id == id)
				{
					if (count > 0)
					{
						vo.pile -= count;
						return vo;
					}
					var index : int = mGameGoods.props.indexOf(vo);
					mGameGoods.props.splice(index, 1);
					return vo;
				}
			}

			throw new Error("物品不足！");
			return null;
		}

		/**
		 * 根据id获得装备
		 * @param type
		 * @return
		 *
		 */
		internal function getEquipById(id : int) : EquipVO
		{
			var vo : EquipVO;
			for each (vo in mGameGoods.equip)
			{
				if (vo.id == id)
					return vo;
			}
			return null;
		}

		/**
		 * 根据type获取英雄
		 * @param type
		 * @return
		 *
		 */
		public function getRoleByType(type : int) : HeroVO
		{
			var allHeros : SGet_all_hero = mBytes.heros;
			for each (var hero : HeroVO in allHeros.heroes)
			{
				if (hero.type == type)
					return hero;
			}
			return null;
		}

		/**
		 * 根据id获取英雄
		 * @param type
		 * @return
		 *
		 */
		public function getRoleById(id : int) : HeroVO
		{
			var allHeros : SGet_all_hero = mBytes.heros;
			for each (var hero : HeroVO in allHeros.heroes)
			{
				if (hero.id == id)
					return hero;
			}
			return null;
		}

		/**
		 * 把IData数据转换成Object保存
		 * @param data
		 * @return
		 *
		 */
		private function changeData2Object(data : IData) : Object
		{
			var object : Object = {};
			object.className = getQualifiedClassName(data);
			object.bytes = data.serialize();
			return object;
		}

		private function readObject2Data(object : Object) : IData
		{
			var className : Class = getDefinitionByName(object.className) as Class;
			var data : IData = new className();
			data.deSerialize(object.bytes);
			return data;
		}

		public function readObject(child : *, obj : Object) : void
		{
			var value : *;
			var key : String;
			var data : XML = describeType(child);

			for each (var variable : * in data.variable)
			{
				key = String(variable.@name);
				value = obj[key];

				if (value == null || value == undefined)
				{
					continue;
				}

				if (child[key] is int)
				{
					child[key] = int(value);
				}
				else if (child[key] is Number)
				{
					child[key] = Number(value);
				}
				else if (child[key] is Boolean)
				{
					child[key] = Boolean(int(value));
				}
				else if (child[key] is String)
				{
					child[key] = value;
				}
				else
				{
					child[key] = new Vector.<IData>();
					ArrayUtil.copyArrayFormArray(child[key], value);
				}
			}
		}

		/**
		 * 存档
		 *
		 */
		public function save() : void
		{
			var bytes : ByteArray = new ByteArray();
			var data : Object = {};
			var child : Object;
			for (var key : String in mBytes)
			{
				if (!(mBytes[key] is IData))
					continue;
				data[key] = changeData2Object(mBytes[key]);
			}
			data.mIsCreate = mIsCreate;
			data.mId = mId;
			data.mSearchHeroCD = mSearchHeroCD;
			data.mSignDay = mSignDay;
			bytes.writeObject(data);
			EncryptedLocalStore.setItem("s_d", bytes);
		}
	}
}