package game.view.city
{
	import game.view.dispark.DisparkControl;
	import game.view.viewBase.CityMenuBarBase;

	public class CityMenuBar extends CityMenuBarBase
	{
		public function CityMenuBar()
		{
			super();
			configDispark();
		}

		/**配置功能开放对象*/
		private function configDispark():void
		{
			DisparkControl.dicDisplay["btn_pic"]=btn_pic;
			DisparkControl.dicDisplay["btn_bag"]=btn_bag;
			DisparkControl.dicDisplay["btn_mail"]=btn_mail;
			DisparkControl.dicDisplay["btn_reward"]=btn_reward;
			DisparkControl.dicDisplay["btn_xingyun"]=btn_xingyun;
		}
	}
}
