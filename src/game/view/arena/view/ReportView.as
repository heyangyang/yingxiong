package game.view.arena.view
{
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;

	import game.common.JTGlobalDef;
	import game.dialog.ShowLoader;
	import game.managers.JTFunctionManager;
	import game.managers.JTPvpInfoManager;
	import game.managers.JTSingleManager;
	import game.net.GameSocket;
	import game.net.data.c.CColiseumReport;
	import game.view.arena.render.ReportItemView;
	import game.view.viewBase.ReportViewBase;

	public class ReportView extends ReportViewBase
	{
		public function ReportView()
		{
			super();
		}

		override protected function init():void
		{
			const layout:TiledRowsLayout=new TiledRowsLayout();
			layout.useSquareTiles=false;
			layout.useVirtualLayout=true;
			layout.tileVerticalAlign=TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
			layout.tileHorizontalAlign=TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
			layout.paddingTop=5;
			list_hero.layout=layout;
			list_hero.verticalScrollPolicy=Scroller.SCROLL_POLICY_ON;
			list_hero.horizontalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
			list_hero.itemRendererFactory=tileListItemRendererFactory;
			function tileListItemRendererFactory():ReportItemView
			{
				var itemRender:ReportItemView=new ReportItemView();
				itemRender.setSize(761, 88);
				return itemRender;
			}

		}

		override protected function addListenerHandler():void
		{
			JTFunctionManager.registerFunction(JTGlobalDef.PVP_REVENGES_LIST, onRevengesResponse);
		}


		override protected function show():void
		{
			var sendFightPackage:CColiseumReport=new CColiseumReport();
			GameSocket.instance.sendData(sendFightPackage);
			ShowLoader.add();
		}

		private function onRevengesResponse(reuslt:Object):void
		{
			ShowLoader.remove();
			var pvpInfoManager:JTPvpInfoManager=JTSingleManager.instance.pvpInfoManager;
			list_hero.dataProvider=new ListCollection(pvpInfoManager.fightInfos);
		}


		override public function dispose():void
		{
			JTFunctionManager.removeFunction(JTGlobalDef.PVP_REVENGES_LIST, onRevengesResponse);
			list_hero.removeFromParent(true);
			super.dispose();
		}
	}

}
