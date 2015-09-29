package com.utils
{

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	/**
		 * 位图数字
		 * @author Michael
		 *
		 */
	public class NumberDisplay extends Sprite
	{
		private var _texture:Vector.<Texture>;
		/**
		 * 0=左对齐，1=居中，2=右对齐
		 */
		public var align:int;

		public static const LEFT:int=0;
		public static const CENTER:int=1;
		public static const RIGHT:int=2;
		private var _num:*;
		private var _gap:int;
		private var _container:Sprite;

		public function NumberDisplay(texture:Vector.<Texture>, gap:int=22, align:int=0)
		{
			_gap=gap;
			_texture=texture;
			this.align=align;
			_container=new Sprite();
			addQuiackChild(_container);
		}

		public static function create(asstes:AssetManager, prefixName:String, gap:int=22, align:int=0):NumberDisplay
		{
			var vector:Vector.<Texture>=new Vector.<Texture>();
			for (var i:int=0; i < 10; i++)
			{
				var texture:Texture=asstes.getTexture(prefixName + i);
				vector[i]=texture;
			}
			var numberDisplay:NumberDisplay=new NumberDisplay(vector, gap, align);
			return numberDisplay;
		}

		public function get number():*
		{
			return _num;
		}

		public function set number(str:*):void
		{
			_num=str;
			_container.clearChild();
			if (str == null)
				return;
			if (str is int || str is Number)
			{
				str=str + "";
			}
			var strLen:int=str.length;

			for (var i:int=0; i < strLen; i++)
			{
				var subStr:String;
				if (i < strLen)
					subStr=str.charAt(i);
				else
					subStr=null;
				if (subStr)
				{
					if (subStr == "-")
					{
						var texture:Texture=_texture[10];
						var image:Image=new Image(texture);
						image.x=_gap * i;
						_container.addQuiackChild(image);
					}
					else if (subStr == "+")
					{
						texture=_texture[11];
						image=new Image(texture);
						image.x=_gap * i;
						_container.addQuiackChild(image);
					}
					else
					{
						texture=_texture[int(subStr)];
						image=new Image(texture);
						image.x=_gap * i;
						_container.addQuiackChild(image);
					}
				}
			}

			if (align == CENTER)
			{
				_container.x=-_container.width / 2;
			}
			else if (align == RIGHT)
			{
				_container.x=-_container.width;
			}

		}

		override public function dispose():void{
			_texture = null;
			align = 0;
			_num = null;
			_gap = 0;
			 _container.removeFromParent(true);
			super.dispose();
		} 
		
	}
}
