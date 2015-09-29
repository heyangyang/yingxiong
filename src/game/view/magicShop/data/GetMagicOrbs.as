package game.view.magicShop.data
{
	import game.net.data.s.SGetMagicOrbs;

	public class GetMagicOrbs extends SGetMagicOrbs
	{
		public var state:Boolean=false; //是否被确定吞噬状态宝珠
		public var selected:Boolean=false; //选中
		public var rock:Boolean=false; //抖动
		public var animation:Boolean=false; //特效
		public var pile:int; //堆叠数
		public var exp:int;
		public var quality:int;
	}
}
