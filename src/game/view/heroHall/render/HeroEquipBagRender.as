package game.view.heroHall.render
{

	import com.langue.Langue;
	import com.view.base.event.EventType;
	import com.view.base.event.ViewDispatcher;

	import spriter.SpriterClip;

	import starling.events.Event;
	import starling.text.TextField;

	public class HeroEquipBagRender extends HeroEquipRender
	{
		private var txt_get:TextField=null;

		public function HeroEquipBagRender(sp:SpriterClip)
		{
			super(sp);
			txt_get=new TextField(80, 30, Langue.getLangue("get_goods"), '', 21, 0x00FF00, false);
			txt_get.touchable=false;
			txt_get.hAlign='center';
			txt_get.x=10;
			txt_get.y=40;
			addChild(txt_get);
			but_bg.container.addChild(txt_get);
			tag_add.visible=false;
		}

		override public function set data(value:Object):void
		{
			super.data=value;
			if (data == null)
				return;
			txt_get.visible=!data.isPack;
			tag_equip.visible=data.isPack;
			if (data.id > 0)
			{
				tag_equip.visible=false;
			}
			tag_add.visible=false;
		}

		override protected function onClick(event:Event):void
		{
			ViewDispatcher.dispatch(EventType.SELECT_HERO_EQUIP, data);
		}
	}
}
