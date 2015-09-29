package game.scene
{
	import game.data.MainLineData;
	import game.manager.GameMgr;
	import game.scene.world.MapBase;
	import game.view.dispark.DisparkControl;
	import game.view.dispark.data.ConfigDisparkStep;

	public class FBMapDialog extends MapBase
	{
		private static var _isCache:Boolean;
		private var currentPage:int;


		override protected function show():void
		{
			lineDatas=MainLineData.fbList;
			currentPage=MainLineData.getPageById(GameMgr.instance.tollgateID, 1);
			DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep8);
			if (!_isCache)
			{
				_index=currentPage;
			}
			super.show();
		}

		override protected function hide():void
		{
			super.hide()
			_isCache=_index != MainLineData.getPageById(GameMgr.instance.tollgateID, 1);
		}

	}
}
