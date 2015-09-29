package game.net.data.s
{
	import flash.utils.ByteArray;
	import game.net.data.DataBase;
	import game.net.data.vo.*;
	import game.net.data.IData;

	public class SColiseumRivalHero extends DataBase
	{
		public var name : String;  
		public var guild : String;  
		public var rank : int;  
		public var wins : int;  
		public var combat : int;  
		public var pic : int;  
		public var vip : int;  
		public var heroes : Vector.<IData>;  
        public static const CMD : int=33035;
		
		public function SColiseumRivalHero()
		{
		}
		
		/**
		 *
		 * @param data
		 */
		override public function deSerialize(data:ByteArray):void
		{
			super.deSerialize(data);
			name=data.readUTF();  
			guild=data.readUTF();  
			rank=data.readInt();  
			wins=data.readInt();  
			combat=data.readInt();  
			pic=data.readUnsignedByte();  
			vip=data.readUnsignedByte();  
			heroes=readObjectArray(ColiseumRivalHeroVO);  
		}
		
		override public function serialize():ByteArray
		{
			var byte:ByteArray= new ByteArray();
            byte.writeUTF(name);  
            byte.writeUTF(guild);  
            byte.writeInt(rank);  
            byte.writeInt(wins);  
            byte.writeInt(combat);  
            byte.writeByte(pic);  
            byte.writeByte(vip);  
            writeObjects(heroes,byte);  
			return byte;
		}
		
		override public function getCmd():int
		{
			return CMD;
		}
	}
}

// vim: filetype=php :
