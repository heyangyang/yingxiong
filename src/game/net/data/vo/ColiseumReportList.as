package game.net.data.vo
{
	import flash.utils.ByteArray;
	import game.net.data.DataBase;
	import game.net.data.vo.*;
	import game.net.data.IData;

    public class ColiseumReportList extends DataBase
	{
		public var id : int;  
		public var name : String;  
		public var win : int;  
		public var combat : int;  
		public var pic : int;  
		
		public function ColiseumReportList()
		{
		}
		
		/**
		 *
		 * @param data
		 */
		override public function deSerialize(data:ByteArray):void
		{
			super.deSerialize(data);
			id=data.readInt();  
			name=data.readUTF();  
			win=data.readUnsignedByte();  
			combat=data.readInt();  
			pic=data.readInt();  
		}
		
		override public function serialize():ByteArray
		{
			var byte:ByteArray= new ByteArray();
            byte.writeInt(id);  
            byte.writeUTF(name);  
            byte.writeByte(win);  
            byte.writeInt(combat);  
            byte.writeInt(pic);  
			return byte;
		}
	}
}

// vim: filetype=php :
