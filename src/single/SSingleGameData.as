package single
{
	import com.scene.SceneMgr;
	import com.view.base.event.ViewDispatcher;

	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;

	import avmplus.getQualifiedClassName;

	import game.data.HeroData;
	import game.net.data.IData;
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

		private var mBytes : Object;
		private var mIsCreate : Boolean;

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
		}

		public function checkIsCreateRole() : void
		{
			if (!mIsCreate)
			{
				var data : SGet_game_data = new SGet_game_data();
				data.level = 1;
				data.tollgateid = 1;
				data.tired = 100;
				data.diamond = data.coin = 100;
				data.arenaname = "";
				mBytes.data = data;

				var allHeros : SGet_all_hero = new SGet_all_hero();
				var heros : Vector.<IData> = new Vector.<IData>();
				heros.push(createRoleByType(30013));
				allHeros.heroes = heros;
				mBytes.heros = allHeros;
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
			var data : SGet_game_data = mBytes.data;
			ViewDispatcher.dispatch(data.getCmd() + "", data);

			var allHeros : SGet_all_hero = mBytes.heros;
			ViewDispatcher.dispatch(allHeros.getCmd() + "", allHeros);
		}

		/**
		 * 根据type创建英雄
		 * @param type
		 * @return
		 *
		 */
		public function createRoleByType(type : int) : HeroVO
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
			bytes.writeObject(data);
			EncryptedLocalStore.setItem("s_d", bytes);
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


	}
}