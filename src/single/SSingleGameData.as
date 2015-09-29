package single
{
	import com.scene.SceneMgr;
	import com.view.base.event.ViewDispatcher;

	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;

	import avmplus.getQualifiedClassName;

	import game.data.Goods;
	import game.data.HeroData;
	import game.data.WidgetData;
	import game.net.data.IData;
	import game.net.data.s.SAllgoods;
	import game.net.data.s.SGet_all_hero;
	import game.net.data.s.SGet_game_data;
	import game.net.data.vo.HeroVO;
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
		 * 所有数据
		 */
		private var mBytes : Object;
		/**
		 * 是否创建了角色
		 */
		private var mIsCreate : Boolean;
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
			mSearchHeroCD = mBytes.mSearchHeroCD;
		}

		/**
		 * 检测是否创建了角色
		 *
		 */
		public function checkIsCreateRole() : void
		{
			if (!mIsCreate)
			{
				mGameData = new SGet_game_data();
				mGameData.level = 99;
				mGameData.tollgateid = 99;
				mGameData.tired = 100;
				mGameData.diamond = mGameData.coin = 99999;
				mGameData.arenaname = "";
				mGameData.herotab = 8;
				mGameData.bagequ = mGameData.bagmat = mGameData.bagprop = 20;
				mBytes.data = mGameData;

				mGameHeros = new SGet_all_hero();
				var heros : Vector.<IData> = new Vector.<IData>();
				heros.push(createRoleByType(30013));
				mGameHeros.heroes = heros;
				mBytes.heros = mGameHeros;

				mGameGoods = new SAllgoods();
				mGameGoods.equip = new Vector.<IData>();
				mGameGoods.props = new Vector.<IData>();
				mBytes.goods = mGameGoods;
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
			ViewDispatcher.dispatch(mGameData.getCmd() + "", mGameData);

			mGameHeros = mBytes.heros;
			ViewDispatcher.dispatch(mGameHeros.getCmd() + "", mGameHeros);

			mGameGoods = mBytes.goods;
			ViewDispatcher.dispatch(mGameGoods.getCmd() + "", mGameGoods);
		}

		/**
		 * 根据type创建英雄
		 * @param type
		 * @return
		 *
		 */
		internal function createRoleByType(type : int) : HeroVO
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
			heroVo.level = 1;
			heroVo.id = type;
			heroVo.type = type;
			heroVo.quality = 2;
			return heroVo;
		}

		internal function addGoodsByType(type : int, count : int) : Goods
		{
			var data : WidgetData = new WidgetData(Goods.goods.getValue(type));
			switch (data.tab)
			{
				//材料
				case 1:
					break;
				//道具
				case 2:
					break;
				//装备
				case 5:
					break;
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
			data.mSearchHeroCD = mSearchHeroCD;
			bytes.writeObject(data);
			EncryptedLocalStore.setItem("s_d", bytes);
		}
	}
}