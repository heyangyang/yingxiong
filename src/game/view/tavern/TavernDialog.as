package game.view.tavern
{
	import com.langue.Langue;
	import com.view.base.event.EventType;

	import game.view.dispark.DisparkControl;
	import game.view.dispark.data.ConfigDisparkStep;
	import game.view.tavern.view.DestinyView;
	import game.view.tavern.view.EngageView;
	import game.view.tavern.view.ExtractView;
	import game.view.viewBase.TavernDialogBase;

	import starling.display.DisplayObjectContainer;
	import starling.events.Event;

	/**
	 * 酒馆
	 * @author Samuel
	 */
	public class TavernDialog extends TavernDialogBase
	{
		private var curPage:int=0;

		public function TavernDialog()
		{
			super();
		}

		override protected function init():void
		{
			_closeButton=btn_close;
			configDisparkStep();
		}

		/**列出按钮*/
		override protected function listTabButton():Array
		{
			var arr:Array=Langue.getLans("tavernLables");
			tab_1.text=arr[0];
			tab_2.text=arr[1];
			tab_3.text=arr[2];
			return [tab_1, tab_2, tab_3];
		}

		/**列出引用的类名*/
		override protected function listTabReference():Array
		{
			return [game.view.tavern.view.ExtractView, game.view.tavern.view.EngageView, game.view.tavern.view.DestinyView];
		}

		override protected function addListenerHandler():void
		{
			super.addListenerHandler();
			//选中标签页
			this.addContextListener(EventType.SELECTTAB, onSelectTab);
		}

		/**选中标签页*/
		private function onSelectTab(evt:Event=null, index:int=0):void
		{
			switch (index)
			{
				case 0:
					if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep3))
					{
						select(curPage);
						return;
					}
					curPage=defaultSelect;
					DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep3);
					break;
				case 1:
					if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep4))
					{
						select(curPage);
						return;
					}
					curPage=defaultSelect;
					DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep4);
					break;
				case 2:
					if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep21))
					{
						select(curPage);
						return;
					}
					curPage=defaultSelect;
					DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep21);
					break;
			}

			this.setChildIndex(_closeButton, this.numChildren - 1);
			this.setChildIndex(tab_1, this.numChildren - 1);
			this.setChildIndex(tab_2, this.numChildren - 1);
			this.setChildIndex(tab_3, this.numChildren - 1);
		}

		/**配置功能开放*/
		protected function configDisparkStep():void
		{
			//功能开放引导
			DisparkControl.dicDisplay["tavern_table_0"]=tab_1;
			DisparkControl.dicDisplay["tavern_table_1"]=tab_2;
			DisparkControl.dicDisplay["tavern_table_2"]=tab_3;

			//智能判断是否添加功能开放提示图标（酒馆购买）
			DisparkControl.instance.addDisparkHandler(ConfigDisparkStep.DisparkStep3);
			//智能判断是否添加功能开放提示图标（雇佣兵）
			DisparkControl.instance.addDisparkHandler(ConfigDisparkStep.DisparkStep4);
			//智能判断是否添加功能开放提示图标（命运之轮）
			DisparkControl.instance.addDisparkHandler(ConfigDisparkStep.DisparkStep21);
		}

		override public function open(container:DisplayObjectContainer, parameter:Object=null, okFun:Function=null, cancelFun:Function=null):void
		{
			if (parameter && parameter is int)
			{
				defaultSelect=parameter as int;
			}
			super.open(container, parameter, okFun, cancelFun);
			setToCenter();
		}

		public function get extractView():ExtractView
		{
			return getPanel(0) as ExtractView;
		}

		public function get engageView():EngageView
		{
			return getPanel(1) as EngageView;
		}

		public function get destinyView():DestinyView
		{
			return getPanel(2) as DestinyView;
		}

		/**销毁*/
		override public function dispose():void
		{
			extractView && extractView.removeFromParent(true);
			engageView && engageView.removeFromParent(true);
			destinyView && destinyView.removeFromParent(true);
			super.dispose();
		}
	}
}


