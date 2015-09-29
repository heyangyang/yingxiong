package spriter.core
{
	public class TimelineKey
	{
		public var id:int;
		public var time:int;
		public var spin:int;

        public var pieceName:String;
        public var x:Number;
        public var y:Number;
        public var pivotX:Number = 0;
        public var pivotY:Number = 1;
        public var scaleX:Number = 0;
        public var scaleY:Number = 1;
        public var angle:Number;
        public var alpha:Number;

        public var pixelPivotX:int;
        public var pixelPivotY:int;
	}
}