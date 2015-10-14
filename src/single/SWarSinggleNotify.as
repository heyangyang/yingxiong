package single
{
	import com.utils.ArrayUtil;

	import flash.utils.Dictionary;

	import game.data.HeroData;
	import game.data.SkillData;
	import game.data.TollgateData;
	import game.manager.HeroDataMgr;
	import game.net.data.IData;
	import game.net.data.c.CBattle;
	import game.net.data.s.SBattle;
	import game.net.data.vo.BattleTarget;
	import game.net.data.vo.BattleVo;

	/**
	 * 战斗协议
	 * @author hyy
	 *
	 */
	public class SWarSinggleNotify extends SSingleNotify
	{
		public function SWarSinggleNotify()
		{
			super();
			mCmdId = 22;
		}

		override protected function addListenerHandler() : void
		{
			addHandler(CBattle.CMD, onBattleHanlder);
		}

		private var triggerDictionary : Dictionary = new Dictionary();
		private var cmdDictionary : Dictionary = new Dictionary();

		/**
		 * 战斗
		 * @param data
		 *
		 */
		private function onBattleHanlder(data : CBattle) : void
		{
			var sendData : SBattle = new SBattle();
			var tollgateData : TollgateData = TollgateData.hash.getValue(data.currentCheckPoint);
			var friendList : Array = HeroDataMgr.instance.getOnBattleHero();
			var enemeyList : Array = ArrayUtil.change2Array(HeroDataMgr.instance.battleHeros.values());
			var list : Array = [].concat(friendList, enemeyList);
			var heroData : HeroData;
			var battleVo : BattleVo;
			var skillData : SkillData;
			//回合数量
			var warCount : int = 0;
			initGuanghuan(list, friendList, enemeyList);
			sendData.battleCommands = new Vector.<IData>();
			//最大30回合
			while (warCount <= 30)
			{
				warCount++;
				for each (heroData in list)
				{
					if (heroData.currenthp <= 0)
						continue;
					battleVo = new BattleVo();
					battleVo.bout = warCount;
					battleVo.sponsor = heroData.seat;
					battleVo.buffid = new Vector.<int>();
					skillData = getSpell(heroData);
					skillData = null;
					if (!skillData)
					{
						battleVo.targets = changeListToVector(heroData, getFirstTarget(heroData.team == HeroData.BLUE ? enemeyList : friendList), null);
					}
					else
					{
						battleVo.skill = skillData.id;
						battleVo.targets = changeListToVector(heroData, getTargetList(heroData, skillData, friendList, enemeyList), skillData);
					}
					if (battleVo.targets.length == 0)
					{
						sendData.success = heroData.team == HeroData.BLUE ? 1 : 0;
						mSingleGameMgr.mGameData.tollgateid += sendData.success == 1 ? 1 : 0;
						sendData.currentCheckPoint = mSingleGameMgr.mGameData.tollgateid;
						mSingleGameMgr.mGameData.tired -= sendData.success == 1 ? tollgateData.tired : 0;
						sendData.tried = mSingleGameMgr.mGameData.tired;
						warCount = 99;
						break;
					}
					sendData.battleCommands.push(battleVo);
				}
			}
			sendData.equip = new Vector.<IData>();
			sendData.props = new Vector.<IData>();
			sendData.battleHeroes = new Vector.<IData>();
			sendData.upgrade = new Vector.<IData>();
			sendMessage(sendData);

			function changeListToVector(caster : HeroData, list : Array, skill : SkillData) : Vector.<IData>
			{
				var vector : Vector.<IData> = new Vector.<IData>();
				var vo : BattleTarget;
				for each (var data : HeroData in list)
				{
					vo = new BattleTarget();
					attackHanlder(caster, data, skill);
					vo.id = data.seat;
					vo.hp = data.currenthp;
					vo.buffid = new Vector.<int>();
					vector.push(vo);
				}
				return vector;
			}
		}


		private function getSpell(heroData : HeroData) : SkillData
		{
			var index : int = Math.random() * 3;
			if (index == 0)
				return null;
			return SkillData.getSkill(heroData["skill" + index]);
		}

		/**
		 * 初始化光环
		 *
		 */
		private function initGuanghuan(list : Array, friendList : Array, enemeyList : Array) : void
		{
			for each (var heroData : HeroData in list)
			{
				updateSkill(heroData.skill1);
				updateSkill(heroData.skill2);
				updateSkill(heroData.skill3);
			}

			function updateSkill(id : int) : void
			{
				var skill : SkillData = SkillData.getSkill(id);
				if (!skill)
					return;
				if (triggerDictionary[skill.id] == null)
				{
					triggerDictionary[skill.id] = getTriggerType(skill.trigger);
					cmdDictionary[skill.id] = getCmdData(skill.cmd);
				}
				var trigger : Object = triggerDictionary[skill.id];
				var cmdData : Object = cmdDictionary[skill.id];
				//光环初始化
				if (trigger == TRIGGER_2)
				{
					var targetList : Array = getTargetList(heroData, skill, friendList, enemeyList);
					var cmd : String = match(skill.cmd, "{", "}");
					switch (cmdData.id)
					{
						case CMD1:
							updateFiled("currenthp", targetList, cmd);
						case CMD3:
							updateFiled("defend", targetList, cmd);
						case CMD4:
							updateFiled("hit", targetList, cmd);
						case CMD5:
							updateFiled("dodge", targetList, cmd);
						case CMD6:
							updateFiled("anitCrit", targetList, cmd);
						case CMD7:
							updateFiled("attack", targetList, cmd);
							break;
						default:
							trace("光环：", cmd);
							break;
					}
				}
			}

			function updateFiled(filed : String, targetList : Array, cmd : String) : void
			{
				var tArray : Array = cmd.split(",");
				for each (var heroData : HeroData in targetList)
				{
					switch (tArray[0])
					{
						case "+":
							heroData[filed] += tArray[1];
							break;
						case "-":
							heroData[filed] -= tArray[1];
							break;
						case "*":
							heroData[filed] *= tArray[1];
							break;
					}
				}
			}
		}

		private static const TRIGGER_1 : String = "主动触发";
		private static const TRIGGER_2 : String = "战斗初始化时触发(光环)";
		private static const TRIGGER_3 : String = "血量少于X%时触发(觉醒技)";
		private static const TRIGGER_4 : String = "攻击时有X*%概率触发";
		private static const TRIGGER_6 : String = "攻击的在炫晕状态的目标时触发";
		private static const TRIGGER_7 : String = "受到攻击时有X%概率触发";
		private static const TRIGGER_8 : String = "受到攻击时自己血量少于X时触发";
		private static const TRIGGER_9 : String = "受到技能攻击时有X%概率触发";
		private static const TRIGGER_10 : String = "施放技能时有X%概率触发";
		private static const TRIGGER_11 : String = "自身增加BUFF时有X%概率触发";
		private static const TRIGGER_13 : String = "被攻击后并且血量小于30%时觉醒触发";
		private static const TRIGGER_14 : String = "死亡后";
		private static const TRIGGER_15 : String = "每次攻击后";
		private static const TRIGGER_16 : String = "击杀一个敌人";

		private function getTriggerType(trigger : String) : String
		{
			trigger = match(trigger, "{", "}");
			if (trigger.indexOf("active") == 0)
				return TRIGGER_1;
			if (trigger.indexOf("init") == 0)
				return TRIGGER_2;
			if (trigger.indexOf("wake") == 0)
				return TRIGGER_3;
			if (trigger.indexOf("atk,{rate") == 0)
				return TRIGGER_4;
			if (trigger.indexOf("atk,dizzy") == 0)
				return TRIGGER_6;
			if (trigger.indexOf("atked,{rate") == 0)
				return TRIGGER_7;
			if (trigger.indexOf("atked,{self_hp") == 0)
				return TRIGGER_8;
			if (trigger.indexOf("atked,wake") == 0)
				return TRIGGER_13;
			if (trigger.indexOf("skill_atked") == 0)
				return TRIGGER_9;
			if (trigger.indexOf("skill_atk,") == 0)
				return TRIGGER_10;
			if (trigger.indexOf("set_buff") == 0)
				return TRIGGER_11;
			if (trigger.indexOf("die") == 0)
				return TRIGGER_14;
			if (trigger.indexOf("after_atk") == 0)
				return TRIGGER_15;
			if (trigger.indexOf("after_kill") == 0)
				return TRIGGER_16;
			throw new Error(trigger);
			return null;
		}

		private static const TARGET_1 : String = "自己";
		private static const TARGET_2 : String = "友方";
		private static const TARGET_3 : String = "敌方";

		/**
		 * 目标西悉尼
		 * @param target
		 * @return id敌方|友方|自己
		 * 		   number数量，数字|all
		 * 		   type过滤条件
		 * type: 	hp_live_min
		   died
		   col
		   behind
		   front_row
		   rand
		   col_leader
		 */
		private function getTargetData(target : String) : Object
		{
			var tData : Object = {};
			if (target == "self")
				tData.id = TARGET_1;
			else if (target.indexOf("friend") >= 0)
				tData.id = TARGET_2;
			else if (target == "enemy")
			{
				tData.id = TARGET_3;
				tData.number = "all";
			}
			else if (target.indexOf("enemy") >= 0)
				tData.id = TARGET_3;
			tData.number = 1;
			target = match(target, "{", "}");
			if (target)
			{
				var tArray : Array = target.split(",");
				if (tArray.length > 1)
				{
					tData.number = tArray[1];
					if (tArray.length > 2)
						tData.type = tArray[2];
					if (tData.number == "no_self")
						tData.type = "no_self";
					if (tData.number.indexOf("all") >= 0)
						tData.type = "all";
				}
			}
			return tData;
		}

		/**
		 * 计算攻击
		 * @param caster
		 * @param target
		 * @param skill
		 *
		 */
		private function attackHanlder(caster : HeroData, target : HeroData, skill : SkillData) : void
		{
			if (!skill)
			{
				target.currenthp -= caster.attack;
				return;
			}
		}

		/**
		 * 获得最近的一个攻击英雄
		 * @param enemeyList
		 * @return
		 *
		 */
		private function getFirstTarget(enemeyList : Array) : Array
		{
			enemeyList.sortOn("seat");
			var heroData : HeroData, len : int = enemeyList.length;
			for (var i : int = 0; i < len; i++)
			{
				heroData = enemeyList[i];
				if (heroData.currenthp > 0)
					return [heroData];
			}
			return null;
		}

		private function getTargetList(caster : HeroData, skillData : SkillData, friendList : Array, enemeyList : Array) : Array
		{
			var targetList : Array = [];
			var tData : Object = getTargetData(skillData.target);
			var list : Array;
			var i : int, len : int;
			var heroData : HeroData;
			switch (tData.id)
			{
				case TARGET_1:
					targetList.push(caster);
					list = [];
					break;
				case TARGET_2:
					list = friendList;
					break;
				case TARGET_3:
					list = enemeyList;
					break;
			}
			len = list.length;
			var needCount : int = tData.number;
			if (tData.number == "all")
				needCount = len;
			for each (heroData in list)
			{
				//自己除外
				if (tData.number == "no_self" && caster == heroData)
					continue;
				if (needCount == 0)
					break;
				if (heroData.currenthp == 0)
					continue;
				targetList.push(heroData);
				needCount--;
			}
			return targetList;
		}

		private static const CMD1 : String = "加血";
		private static const CMD2 : String = "设置穿透";
		private static const CMD3 : String = "设置防御";
		private static const CMD4 : String = "设置命中";
		private static const CMD5 : String = "设置闪避";
		private static const CMD6 : String = "设置抗暴";
		private static const CMD7 : String = "设置攻击";
		private static const CMD8 : String = "设置BUFF";
		private static const CMD9 : String = "免疫BUFF";
		private static const CMD10 : String = "每减少X%生命,增加1%攻击";

		private function getCmdData(cmd : String) : Object
		{
			if (!cmd)
				return null;
			cmd = match(cmd, "[", "]");
			var tData : Object = {};
			var tArray : Array;
			if (cmd.indexOf("add_hp") == 1)
				tData.id = CMD1;
			else if (cmd.indexOf("set_pun") == 1)
				tData.id = CMD2;
			else if (cmd.indexOf("set_def") == 1)
				tData.id = CMD3;
			else if (cmd.indexOf("set_hit") == 1)
				tData.id = CMD4;
			else if (cmd.indexOf("set_dod") == 1)
				tData.id = CMD5;
			else if (cmd.indexOf("set_crit_anti") == 1)
				tData.id = CMD6;
			else if (cmd.indexOf("set_damaged") == 1)
				tData.id = CMD7;
			else if (cmd.indexOf("set_buff") == 1)
				tData.id = CMD8;
			else if (cmd.indexOf("anti_buff") == 1)
				tData.id = CMD9;
			else if (cmd.indexOf("atked2atk") == 1)
				tData.id = CMD10;
			else
				throw new Error(cmd);

			if (match(cmd, "{", "}"))
			{
				cmd = match(cmd, "{", "}");
				tArray = cmd.split(",");
				tData.type = tArray[0];
				tData.number = tArray[1];
			}
			return tData;

		}

		private function match(str : String, start : String, end : String) : String
		{
			var startIndex : int = str.indexOf(start);
			var count : int = 1;
			var index : int = 0;
			var endIndex : int = str.lastIndexOf(end);
			if (startIndex == -1 || endIndex == -1)
				return null;
			var len : int = str.length;
			var char : String;
			for (var i : int = 0; i < len; i++)
			{
				char = str.charAt(i);
				if (char == start)
					count++;
				if (char == end)
					count--;
				if (char == end && count == 1)
					break;
			}
			return str.substring(startIndex + 1, i);
		}
	}
}