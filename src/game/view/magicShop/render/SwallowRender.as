package game.view.magicShop.render
{
	import com.view.base.event.EventType;
	
	import game.view.magicShop.data.MagicData;
	
	import spriter.SpriterClip;
	
	import starling.events.Event;

	public class SwallowRender extends MagicRender
	{

		private var _select:Boolean;

		public function SwallowRender()
		{
			super();
		}

		public function get select():Boolean
		{
			return _select;
		}

		public function set select(value:Boolean):void
		{
			_select=value;
		}

		override public function set isSelected(value:Boolean):void
		{
			super.isSelected=value;
			if (index == 0 && !_select) //第一次打开时默认选择
			{
				_select=true;
				owner && owner.dispatchEventWith(EventType.SELECTED_DEFAULT, false, {type: 1, data: this});
			}
			
			if(MagicData.magicData){
				if(getMagicOrbs.id!=MagicData.magicData.id){
					var sp:SpriterClip = this.getChildByName("selectIco") as SpriterClip;
					sp&&sp.removeFromParent(true);
				}else{
					owner && owner.dispatchEventWith(EventType.SELECTED_DEFAULT, false, {type: 1, data: this});
				}
			}
		}

		override protected function selected(e:Event):void
		{
			if (!owner.isScrolling && getMagicOrbs.type > 0)
			{
				if (!MagicData.magicData || !MagicData.magicData.state)
				{
					owner && owner.dispatchEventWith(EventType.SELECTED_DEFAULT, false, {type: 1, data: this})
				}
				else
				{
					if (MagicData.magicData.id != getMagicOrbs.id)
					{
						selectedItem=!getMagicOrbs.selected;
						owner && owner.dispatchEventWith(EventType.SELECTED_DEFAULT, false, {type: 2, data: this});
					}
				}

			}
		}

		/**打钩*/
		public function set selectedItem(value:Boolean):void
		{
			getMagicOrbs.selected=value;
			_selectedImage.visible=value;
		}

		override public function dispose():void
		{
			super.dispose();
		}
	}
}

