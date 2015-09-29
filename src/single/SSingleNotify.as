package single
{
	import com.view.base.event.ViewDispatcher;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	import game.data.HeroData;
	import game.data.SkillData;
	import game.data.TollgateData;
	import game.manager.HeroDataMgr;
	import game.net.data.IData;
	import game.net.data.c.CBattle;
	import game.net.data.c.CEmbattle;
	import game.net.data.s.SBattle;
	import game.net.data.s.SEmbattle;
	import game.net.data.vo.BattleVo;
	import game.net.data.vo.HeroPosition;
	import game.net.data.vo.HeroVO;

	public class SSingleNotify
	{
		private static var instance : SSingleNotify;

		public static function getInstance() : SSingleNotify
		{
			if (!instance)
			{
				instance = new SSingleNotify();
				instance.addListenerHandler();
			}
			return instance;
		}

		private var mDictionary : Dictionary = new Dictionary();

		private function addListenerHandler() : void
		{
			addHandler(CEmbattle.CMD, onEmbattleHanlder)
			addHandler(CBattle.CMD, onBattleHanlder)
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
				vo = SSingleGameData.getInstance().getRoleByType(position.id);
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
			var heroMonst : Vector.<*> = HeroDataMgr.instance.monsterHashMap.values();
			var list : Vector.<*> = HeroDataMgr.instance.battleHeros.values();
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
				if (heroMonst.length == 0)
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
			;
		}

		private function sendMessage(data : IData) : void
		{
			ViewDispatcher.dispatch(data.getCmd() + "", data);
		}
	}
}