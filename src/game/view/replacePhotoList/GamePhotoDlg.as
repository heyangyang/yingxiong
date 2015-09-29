package game.view.replacePhotoList
{
	import com.components.RollTips;
	import com.langue.Langue;
	import com.utils.ArrayUtil;
	import com.view.base.event.EventType;

	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;

	import game.common.JTGlobalDef;
	import game.data.ConfigData;
	import game.data.GamePhotoData;
	import game.manager.GameMgr;
	import game.managers.JTFunctionManager;
	import game.net.message.RoleInfomationMessage;
	import game.view.viewBase.GamePhotoDlgBase;

	import starling.events.Event;

	/**
	 * 更换头像
	 * @author liufurong
	 */
	public class GamePhotoDlg extends GamePhotoDlgBase
	{
		public function GamePhotoDlg()
		{
			super();
		}

		override protected function init():void
		{
			enableTween=true;
			txt_name.text=Langue.getLangue("SelectAvatar");
			var heroPhotoArray:Array=ArrayUtil.change2Array(GamePhotoData.hashMapPhoto.values());
			list_bag.dataProvider=new ListCollection(heroPhotoArray);

			const layout:TiledRowsLayout=new TiledRowsLayout();
			layout.gap=5;
			layout.useSquareTiles=false;
			layout.useVirtualLayout=true;
			layout.tileVerticalAlign=TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
			layout.tileHorizontalAlign=TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
			list_bag.layout=layout;
			list_bag.itemRendererFactory=itemRendererFactory;

			clickBackroundClose();
		}

		private function itemRendererFactory():NewGamePhotoRender
		{
			const renderer:NewGamePhotoRender=new NewGamePhotoRender();
			return renderer;
		}

		override protected function addListenerHandler():void
		{
			super.addListenerHandler();
			this.addViewListener(list_bag, Event.CHANGE, onListHeroPhoto);
			this.addContextListener(EventType.UP_HEROPHOTO, updateHeroPhotoList);
		}

		/**
		 * 点击头像的操作，更换头像是否成功
		 */
		private function onListHeroPhoto(event:Event):void
		{
			var heroPhotoData:GamePhotoData=list_bag.selectedItem as GamePhotoData;
			// 角斗场关卡小于限制等级不可以更换头像
			if (GameMgr.instance.tollgateID <= ConfigData.instance.arenaGuide)
			{
				RollTips.add(Langue.getLangue("didNotReach"));
				return;
			}
			// 现在使用的头像已经使用了 不可以更换
			if (GameMgr.instance.picture == heroPhotoData.id)
			{
				RollTips.add(Langue.getLangue("useTheirOwnAvatar"));
				return;
			}
			else
			{
				// 请求更新头像
				RoleInfomationMessage.sendeHeroPhoto(heroPhotoData.id);
			}
		}

		/**
		 * 成功更换头像,关闭窗口
		 */
		private function updateHeroPhotoList():void
		{
			close();
		}

	}
}
