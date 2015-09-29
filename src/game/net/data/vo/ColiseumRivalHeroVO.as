package game.net.data.vo
{
	import flash.utils.ByteArray;
	import game.net.data.DataBase;
	import game.net.data.vo.*;
	import game.net.data.IData;

    public class ColiseumRivalHeroVO extends DataBase
	{
		public var type : int;  
		public var seat : int;  
		
		public function ColiseumRivalHeroVO()
		{
		}
		
		/**
		 *
		 * @param data
		 */
		override public function deSerialize(data:ByteArray):void
		{
			super.deSerialize(data);
			type=data.readInt();  
			seat=data.readUnsignedByte();  
		}
		
		override public function serialize():ByteArray
		{
			var byte:ByteArray= new ByteArray();
            byte.writeInt(type);  
            byte.writeByte(seat);  
			return byte;
		}
	}
}

// vim: filetype=php :
