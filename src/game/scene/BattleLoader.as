package game.scene
{
	import com.dialog.DialogMgr;
	import com.langue.Langue;
	import com.mobileLib.utils.ConverURL;
	import com.mvc.core.Facade;
	import com.mvc.interfaces.INotification;
	import com.mvc.interfaces.IObserver;
	import com.scene.SceneMgr;
	import com.singleton.Singleton;

	import flash.utils.getQualifiedClassName;

	import game.common.JTGlobalDef;
	import game.data.MainLineData;
	import game.data.StoryConfigData;
	import game.data.TollgateData;
	import game.dialog.MsgDialog;
	import game.dialog.ShowLoader;
	import game.hero.AnimationCreator;
	import game.manager.BattleAssets;
	import game.manager.GameMgr;
	import game.manager.HeroDataMgr;
	import game.managers.JTFunctionManager;
	import game.net.GameSocket;
	import game.net.data.c.CGet_tired;
	import game.net.data.s.SGet_tired;
	import game.net.message.GoodsMessage;
	import game.view.city.CityFace;
	import game.view.new2Guide.NewGuide2Manager;

	public class BattleLoader implements IObserver
	{
		private var _pointID:int;
		private var _pos:int;

		/**
		 *
		 * @return
		 */
		public function getName():String
		{
			return (getQualifiedClassName(this));
		}

		/**
		 *
		 */
		public function removeObserver():void
		{
			var vector:Vector.<String>=listNotificationName();
			var len:int=vector.length;

			for (var i:int=0; i < len; i++)
			{
				var name:String=vector[i];
				Facade.removeObserver(name, this);
			}
		}

		/**
		 *
		 * @param _arg1
		 */
		public function handleNotification(arg1:INotification):void
		{
			switch (arg1.getName())
			{
				// 更新疲劳
				case SGet_tired.CMD + "":
					GameMgr.instance.tired=(arg1 as SGet_tired).tired;
					GameMgr.instance.time=(arg1 as SGet_tired).time;

					var tollgate:TollgateData=TollgateData.hash.getValue(_pointID);

					if (GameMgr.instance.tired >= tollgate.tired)
					{
						loadMonster();
					}
					else
					{
						GoodsMessage.onBuyTiredClick();
					}
					break;
				default:
					break;
			}
			ShowLoader.remove();
		}

		/**
		 *
		 * @return
		 */
		public function listNotificationName():Vector.<String>
		{
			var vector:Vector.<String>=new Vector.<String>();
			vector.push(SGet_tired.CMD);
			return vector;
		}

		public function dispose():void
		{
			removeObserver();
			Singleton.remove(this);
		}

		/**
		 *
		 * @param pointID   关卡ID
		 * @param pos   副本位置，如果是主线，副本ID为O，只要点击副本地图的时候传副本位置
		 *
		 */
		public function load(pointID:int, pos:int=0, name:int=0):void
		{
            HeroDataMgr.instance.battleHeros.clear();
			NewGuide2Manager.isLoading=true;
			NewGuide2Manager.gotoNext();
			_pointID=pointID;
			_pos=pos;
			var tollgate:TollgateData=TollgateData.hash.getValue(_pointID);

			if (!tollgate && pos == GameMgr.MAIN_LINE)
			{
				DialogMgr.instance.open(MsgDialog, Langue.getLangue("NOSL"), function():void
					{
						DialogMgr.instance.closeAllDialog();
						SceneMgr.instance.changeScene(CityFace);
						DialogMgr.instance.open(MainMapDialog);
						JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
					});
				return;
			}

			if (tollgate && GameMgr.instance.tired < tollgate.tired)
			{
				initObserver();
				var cmd:CGet_tired=new CGet_tired();
				GameSocket.instance.sendData(cmd);
				ShowLoader.add();
			}
			else
			{
				loadStory();
                AnimationCreator.instance.loadMeSelfBattleHeros(HeroDataMgr.instance.getOnBattleHero(), BattleAssets.instance);
				loadMonster();
			}
		}

		private function loadStory():void
		{
			var tmp_arr:Array=StoryConfigData.getAllHalfPhoto(_pointID);
			var len:int=tmp_arr.length;
			for (var i:int=0; i < len; i++)
			{
				BattleAssets.instance.enqueue(ConverURL.conver("portrait/" + tmp_arr[i]));
			}
		}

		/**
		 *
		 */
		protected function initObserver():void
		{
			var vector:Vector.<String>=listNotificationName();
			var len:int=vector.length;

			for (var i:int=0; i < len; i++)
			{
				var name:String=vector[i];
				Facade.addObserver(name, this);
			}
		}

		private function loadMonster():void
		{
			var tollgate:TollgateData=TollgateData.hash.getValue(_pointID);

			HeroDataMgr.instance.createMonsters(tollgate);
			var mainLineData:MainLineData=MainLineData.getPoint(tollgate.id);
			loadMap(mainLineData.scene, mainLineData.bgm, onMapLoaded);
			loadStory();

		}

		private function onMapLoaded():void
		{
			var tollgate:TollgateData=TollgateData.hash.getValue(_pointID);
			AnimationCreator.instance.loadMonsters(tollgate, onLoaded, BattleAssets.instance);
		}

		private function onLoaded():void
		{
			dispose();
            ShowLoader.remove();
			DialogMgr.instance.closeAllDialog();
			var tollgate:TollgateData=TollgateData.hash.getValue(_pointID);
			GameMgr.instance.tollgateData=tollgate;
			SceneMgr.instance.changeScene(BattleScene, {"tollgate": tollgate, "pos": _pos});
			NewGuide2Manager.isLoading=false;
			NewGuide2Manager.gotoNext();
		}


		protected function loadMap(scene:String, bgm:String, callback:Function):void
		{
			BattleAssets.instance.enqueue(ConverURL.conver("scene/" + scene));
			BattleAssets.instance.enqueue(ConverURL.conver("battleBgm/" + bgm + ".mp3"));
			BattleAssets.instance.loadQueue(onComplete);
			function onComplete(ratio:Number):void
			{
				if (ratio == 1.0)
				{
					callback != null && callback();
				}
			}
		}
	}
}


