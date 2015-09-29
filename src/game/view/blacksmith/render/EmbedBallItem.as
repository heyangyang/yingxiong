package game.view.blacksmith.render
{
	import game.manager.AssetMgr;
	import game.view.viewBase.EmbedBallItemBase;

	import starling.display.Image;

	public class EmbedBallItem extends EmbedBallItemBase
	{
		public function EmbedBallItem()
		{
			super();
			bg.touchable=txt.touchable=true;
		}
		private var picture:Image;
		private var _data:Object;

		public function get data():Object
		{
			return _data;
		}

		public function set data(vo:Object):void
		{
			_data=vo;
			switch (vo.statue)
			{
				case 0: //未开启
					ad.texture=AssetMgr.instance.getTexture("ui_zengjia02_anniu");
					ad.width=ad.height=42;
					ad.x=4.5;
					ad.y=5;
					txt.text="未开启";
					txt.color=0xff0000;
					ad.visible=false;
					no.visible=true;
					break;
				case 1: //已开启 未镶嵌
					ad.texture=AssetMgr.instance.getTexture("ui_zengjia02_anniu");
					ad.width=ad.height=42;
					ad.x=4.5;
					ad.y=5;
					txt.text="未镶嵌";
					txt.color=0xffffff;
					ad.visible=true;
					no.visible=false;
					break;
				case 2: //已开启 已镶嵌
					ad.texture=AssetMgr.instance.getTexture(vo.data.picture);
					ad.width=ad.height=86;
					ad.x=-16;
					ad.y=-20;
					txt.text=vo.data.name + " +" + vo.value;
					txt.color=0x00ff00;
					ad.visible=true;
					no.visible=false;
					break;
				case 3: //设置添加宝珠
					if (vo.data.id > 0)
					{
						ad.texture=AssetMgr.instance.getTexture(vo.data.picture);
						ad.width=ad.height=86;
						ad.x=-16;
						ad.y=-20;
						txt.text=vo.data.name + " +" + vo.value;
						txt.color=0xffffff;
						ad.visible=true;
						no.visible=false;
					}
					break;
			}

		}
	}
}
