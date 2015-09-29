package game.net.data.s
{
	import flash.utils.ByteArray;
	import game.net.data.DataBase;
	import game.net.data.vo.*;
	import game.net.data.IData;

	public class SWeixinShare extends DataBase
	{
		public var code : int;  
		public var id : int;  
		public var num : int;  
        public static const CMD : int=25030;
		
		public function SWeixinShare()
		{
		}
		
		/**
		 *
		 * @param data
		 */
		override public function deSerialize(data:ByteArray):void
		{
			super.deSerialize(data);
			code=data.readUnsignedByte();  
			id=data.readUnsignedByte();  
			num=data.readInt();  
		}
		
		override public function serialize():ByteArray
		{
			var byte:ByteArray= new ByteArray();
            byte.writeByte(code);  
            byte.writeByte(id);  
            byte.writeInt(num);  
			return byte;
		}
		
		override public function getCmd():int
		{
			return CMD;
		}
	}
}

// vim: filetype=php :
