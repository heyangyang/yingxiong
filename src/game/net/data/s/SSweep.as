package game.net.data.s
{
	import flash.utils.ByteArray;
	import game.net.data.DataBase;
	import game.net.data.vo.*;
	import game.net.data.IData;

	public class SSweep extends DataBase
	{
		public var code : int;  
		public var tried : int;  
		public var sweepResult : Vector.<IData>;  
        public static const CMD : int=22030;
		
		public function SSweep()
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
			tried=data.readInt();  
			sweepResult=readObjectArray(sweepResultVOS);  
		}
		
		override public function serialize():ByteArray
		{
			var byte:ByteArray= new ByteArray();
            byte.writeByte(code);  
            byte.writeInt(tried);  
            writeObjects(sweepResult,byte);  
			return byte;
		}
		
		override public function getCmd():int
		{
			return CMD;
		}
	}
}

// vim: filetype=php :
