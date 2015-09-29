package game.net.data.s
{
	import flash.utils.ByteArray;
	import game.net.data.DataBase;
	import game.net.data.vo.*;
	import game.net.data.IData;

	public class SHeroDismissal extends DataBase
	{
		public var code : int;  
        public static const CMD : int=14034;
		
		public function SHeroDismissal()
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
		}
		
		override public function serialize():ByteArray
		{
			var byte:ByteArray= new ByteArray();
            byte.writeByte(code);  
			return byte;
		}
		
		override public function getCmd():int
		{
			return CMD;
		}
	}
}

// vim: filetype=php :
