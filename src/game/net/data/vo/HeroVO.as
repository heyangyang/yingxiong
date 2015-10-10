package game.net.data.vo
{
	import flash.utils.ByteArray;
	
	import game.common.JTFormulaUtil;
	import game.common.JTLogger;
	import game.data.HeroData;
	import game.data.HeroQualityData;
	import game.data.HeroStarData;
	import game.data.Val;
	import game.net.data.DataBase;

	public class HeroVO extends DataBase
	{
		public var id : int;
		public var type : int;
		public var seat : int;
		public var quality : int;
		public var level : int;
		public var exp : int;
		public var foster : int;
		public var hp : int;
		public var attack : int;
		public var defend : int;
		public var puncture : int;
		public var hit : int;
		public var dodge : int;
		public var crit : int;
		public var critPercentage : int;
		public var anitCrit : int;
		public var toughness : int;
		public var seat1 : int;
		public var seat2 : int;
		public var seat3 : int;
		public var seat4 : int;
		public var seat5 : int;

		public function HeroVO()
		{
		}

		/**
		 *
		 * @param data
		 */
		override public function deSerialize(data : ByteArray) : void
		{
			super.deSerialize(data);
			id = data.readInt();
			type = data.readInt();
			seat = data.readUnsignedByte();
			quality = data.readUnsignedByte();
			level = data.readUnsignedByte();
			exp = data.readInt();
			foster = data.readUnsignedByte();
			hp = data.readInt();
			attack = data.readInt();
			defend = data.readInt();
			puncture = data.readInt();
			hit = data.readInt();
			dodge = data.readInt();
			crit = data.readInt();
			critPercentage = data.readInt();
			anitCrit = data.readInt();
			toughness = data.readInt();
			seat1 = data.readInt();
			seat2 = data.readInt();
			seat3 = data.readInt();
			seat4 = data.readInt();
			seat5 = data.readInt();
		}

		override public function serialize() : ByteArray
		{
			var byte : ByteArray = new ByteArray();
			byte.writeInt(id);
			byte.writeInt(type);
			byte.writeByte(seat);
			byte.writeByte(quality);
			byte.writeByte(level);
			byte.writeInt(exp);
			byte.writeByte(foster);
			byte.writeInt(hp);
			byte.writeInt(attack);
			byte.writeInt(defend);
			byte.writeInt(puncture);
			byte.writeInt(hit);
			byte.writeInt(dodge);
			byte.writeInt(crit);
			byte.writeInt(critPercentage);
			byte.writeInt(anitCrit);
			byte.writeInt(toughness);
			byte.writeInt(seat1);
			byte.writeInt(seat2);
			byte.writeInt(seat3);
			byte.writeInt(seat4);
			byte.writeInt(seat5);
			return byte;
		}

		/**
		 * 升星成功  增加当前英雄的 属性
		 * @param star
		 *
		 */
		private function updateStarPropertys(star : int) : void
		{
			var heroStar : HeroStarData = HeroStarData.hash.getValue(this.type);
			var propertys : Array = getPropertys;
			var i : int = 0;
			var length : int = propertys.length;
			var key : Array = Val.MAGICBALL;

			for (i; i < length; i++)
			{
				var property : String = key[i];
				var baseValue : Number = this[property];
				var nextValue : int = JTFormulaUtil.getStarValue(baseValue, star, heroStar);
				this[property] = nextValue;
			}

		}

		/**
		 * 进阶成功 当前英雄属性
		 * @param qualityID
		 *
		 */
		public function updateQualityPropertys(qualityID : int) : void
		{
			var nextHeroData : HeroQualityData = HeroQualityData.hash.getValue(qualityID);
			var baseHeroInfo : HeroData = HeroData.hero.getValue(type);

			if (!baseHeroInfo)
			{
				JTLogger.error("[HeroData.getNextUpgradePropertys] Cant Find ID Hero:" + this.id);
			}
			var propertys : Array = getPropertys;
			var i : int = 0;
			var length : int = propertys.length;
			var key : Array = Val.MAGICBALL;

			for (i; i < length; i++)
			{
				var property : String = key[i];

				if (!baseHeroInfo.hasOwnProperty(property))
				{
					JTLogger.error("");
				}
				var bvaseValue : int = baseHeroInfo[property];
				var currValue : int = JTFormulaUtil.getNextPurgeDeff(bvaseValue, 1, nextHeroData.arg);
				this[property] = currValue;
			}
			this.updateStarPropertys(foster);
		}

		public function get getPropertys() : Array
		{
			return [attack, hp, defend, puncture, hit, dodge, crit, critPercentage, anitCrit, toughness];
		}

	}
}

// vim: filetype=php :
