package game.view.city
{
	import com.components.RollTips;
	import com.dialog.DialogMgr;
	import com.langue.Langue;
	import com.scene.BaseScene;
	import com.sound.SoundManager;
	import com.utils.Constants;
	import com.utils.ObjectUtil;
	import com.view.base.event.EventType;

import flash.system.System;

import flash.utils.getTimer;

	import feathers.system.DeviceCapabilities;

	import game.common.JTGlobalDef;
	import game.data.Val;
	import game.dialog.ShowLoader;
	import game.manager.AssetMgr;
	import game.manager.GameMgr;
	import game.managers.JTFunctionManager;
	import game.managers.JTSingleManager;
	import game.net.data.c.CAttain_init;
	import game.net.message.GameMessage;
	import game.scene.FBMapDialog;
	import game.scene.MainMapDialog;
	import game.view.achievement.data.AchievementData;
	import game.view.arena.ArenaCreateNameDlg;
	import game.view.arena.ArenaDialog;
	import game.view.blacksmith.BlacksmithDialog;
	import game.view.chat.component.JTChatControllerComponent;
	import game.view.chat.component.JTMessageSystemComponent;
	import game.view.dispark.DisparkControl;
	import game.view.dispark.data.ConfigDisparkStep;
	import game.view.heroHall.HeroDialog;
	import game.view.magicShop.MagicOrbDia;
	import game.view.new2Guide.NewGuide2Manager;
	import game.view.rank.RankDlg;
	import game.view.shop.ShopDlg;
	import game.view.tavern.TavernDialog;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * 游戏大厅
	 */
	public class CityFace extends BaseScene
	{
		public var icon:CityIcon;
		private var _container1:HouseContainer;
		private var _animationList:Array=[];
		/**
		 * 新手引导
		 */
		public static var isNewGuideInit:Boolean;
		/**
		 * 功能引导
		 */
		public static var isViewGuideInit:Boolean;



		override protected function init():void
		{
			var singleManager:JTSingleManager=JTSingleManager.instance;
			singleManager.tollgateInfoManager.current_TollgateID=GameMgr.instance.tollgateprize;
			AchievementData.instance;
			_container1=new HouseContainer(onTouch);
			addChild(_container1);
			_container1.x=-(_container1.width - Constants.virtualWidth);
			icon=new CityIcon();
			addChild(icon);

			SoundManager.instance.playSound("city_bgm", true, 0, 99999);
			SoundManager.instance.tweenVolume("city_bgm", 0.75, 2);
			JTSingleManager.initialize();
			JTChatControllerComponent.open(this); //添加聊天
			ShowLoader.remove();

		}

		override protected function addListenerHandler():void
		{
			JTFunctionManager.registerFunction(JTGlobalDef.STOP_CITY_ANIMATABLE, onStopAnimatable);
			JTFunctionManager.registerFunction(JTGlobalDef.PLAY_CITY_ANIMATABLE, onPlayAnimatable);
			JTFunctionManager.registerFunction(JTGlobalDef.SHOW_CHAT_PANEL, onShowChatPanelHandler);
			this.addContextListener(EventType.OPEN_ARENA, onPvp);

			_container1.addEventListener(TouchEvent.TOUCH, onScrollTouch);
		}

		private var mIsDown:Boolean;
		protected static const MAX_DRAG_DIST:int=DeviceCapabilities.dpi * 0.5;
		protected static const MAX_DRAG_TIME:int=1000;
		private var _oldPos:int;
		private var _oldTime:int;

		protected var _movePos:int;
		protected var _oldMovePos:int;

		public function onScrollTouch(event:TouchEvent):void
		{
			var touch:Touch=event.getTouch(_container1);
			if (touch == null)
				return;
			if (touch.phase == TouchPhase.BEGAN && !mIsDown)
			{
				_oldPos=touch.globalX;
				_oldTime=getTimer();
				mIsDown=true;

				_movePos=0;
			}
			else if (touch.phase == TouchPhase.MOVED && mIsDown)
			{
//
				_movePos=touch.globalX;


			}
			else if (touch.phase == TouchPhase.ENDED && mIsDown)
			{
				_movePos=0;

				mIsDown=false;
				var gap:int=touch.globalX - _oldPos;
				var gapTime:int=getTimer() - _oldTime;
				if (Math.abs(gap) > MAX_DRAG_DIST && gapTime < MAX_DRAG_TIME)
				{
					if (gap > 0) // 往右
					{
						_speed=(gap / 2) * (100 / gapTime);
//                    trace("往右",_speed);
					}
					else // 往左
					{
						_speed=(gap / 2) * (100 / gapTime);
//                    trace("往左",_speed);
					}
				}
			}
		}

		override public function advanceTime(time:Number):void
		{
			if (Math.abs(_speed) > 2)
			{
				_container1.x+=_speed;
				_speed*=0.85;

				if (_container1.x < -(_container1.width - Constants.virtualWidth))
				{
					_container1.x=-(_container1.width - Constants.virtualWidth);
					_speed=0;
				}
				else if (_container1.x > 0)
				{
					_container1.x=0;
					_speed=0;
				}
			}
			else
			{
				_speed=0;

				if (_movePos > 0 && _oldMovePos > 0)
				{
					var gap:int=_movePos - _oldMovePos;
					_container1.x+=(gap * Constants.scale);

					if (_container1.x < -(_container1.width - Constants.virtualWidth))
					{
						_container1.x=-(_container1.width - Constants.virtualWidth);
					}
					else if (_container1.x > 0)
					{
						_container1.x=0;
					}
				}
				_oldMovePos=_movePos;
			}
		}

		private var _speed:int;

		override protected function show():void
		{
			if (!isNewGuideInit)
			{
				sendMessage(new CAttain_init());
				isNewGuideInit=true;
				NewGuide2Manager.start();
			}

			AssetMgr.instance.removeTexture("progressbar_home");

			if (!isViewGuideInit)
			{
				isViewGuideInit=true;
			}
			JTMessageSystemComponent.checkMsg();
			DisparkControl.instance.checkMajorOpen();

			Starling.juggler.add(this);
		}

		private function onPlayAnimatable():void
		{
			this.icon.visibleElements(true);
			this.unflatten();
			ObjectUtil.resumeAnimation(_animationList);
		}

		private function onStopAnimatable(visible:Boolean=true):void
		{
			this.icon.visibleElements(false);
			this.flatten();
			ObjectUtil.stopAnimation(_animationList, this);
		}

		private function onShowChatPanelHandler():void
		{
			JTChatControllerComponent.open(this);
		}

		private function onTouch(sp:String):void
		{
			if (!touchable)
				return;

			switch (sp)
			{
				case "effcet_mainline_house":
					JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
					DialogMgr.instance.open(MainMapDialog, null, null, cancelHandler);
					DisparkControl.instance.checkMajorOpen(); //检查功能开放
					break;
				case "effcet_shop_house":
					if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep11)) //商店功能是否开启
						return;
					JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
					DialogMgr.instance.open(ShopDlg, null, null, cancelHandler);
					break;
				case "effcet_magicball_house":
					if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep14)) //宝珠功能是否开启
						return;
					DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep14);
					JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
					DialogMgr.instance.open(MagicOrbDia, null, null, cancelHandler);
					break;
				case "effcet_hero_house":
					JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
					DialogMgr.instance.open(HeroDialog, null, null, cancelHandler);
					break;
				case "effcet_tavern_house":
					if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep3)) //酒馆功能是否开启
						return;
					JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
					DialogMgr.instance.open(TavernDialog, null, null, cancelHandler);
					break;
				case "effcet_transcript_house":
					if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep8)) //试练 副本功能是否开启
						return;
					JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
					DialogMgr.instance.open(FBMapDialog, null, null, cancelHandler);
					break;
				case "effcet_hecheng":
					if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep1))
						return;
					DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep1);
					JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
					DialogMgr.instance.open(BlacksmithDialog, null, null, cancelHandler);
					break;
				case "effcet_pvp_house":
					if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep7)) //角斗场能是否开启
						return;
					DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep7);
					onPvp();
					break;
				case "effcet_society_house":
					RollTips.add(Langue.getLangue("functionWait"));
					break;
				case "effcet_lion_house":
					JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
					DialogMgr.instance.open(RankDlg, null, null, cancelHandler);
					break;
				default:
					break;
			}
		}

		/**改变时显示元素*/
		private function cancelHandler(e:*):void
		{
			JTFunctionManager.executeFunction(JTGlobalDef.PLAY_CITY_ANIMATABLE);
		}

		/**
		 *pvp
		 *
		 */
		private function onPvp(event:Event=null, value:String=Val.DROP_PVP):void
		{
			if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep7))
			{
				return;
			}
			if (GameMgr.instance.arenaname == "" || GameMgr.instance.arenaname == null) //创建玩家名字
			{
				DialogMgr.instance.open(ArenaCreateNameDlg, false);
			}
			else
			{
				JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
				DialogMgr.instance.open(ArenaDialog, null, null, cancelHandler);
			}
		}


		/**
		 * 新手引导
		 * @param name
		 * @return
		 *
		 */
		override public function getGuideDisplay(name:String):*
		{
			switch (name)
			{
				case "下拉列表":
					return icon;
					break;
				case "福利":
					_container1.touchable=false;
					break;
				case "主线按钮":
					_container1.touchable=false;
					return super.getGuideDisplay("icon,btn_main");
					break;
				case "签到按钮":
//					var dialog:WelfareView=WelfareView(DialogMgr.instance.getDlg(WelfareView));
//					return dialog ? dialog.btn_sign : null;
					break;
				case "英雄之家":
					var effcet_hero_house:House=getHouseByName("effcet_hero_house");
					effcet_hero_house.onClick.addOnce(gotoNext);
//					_scroller.setPosition(-600);
					function gotoNext():void
				{
					NewGuide2Manager.gotoNext();
				}
					return effcet_hero_house;
					break;
				case "成就按钮":
//					dialog=WelfareView(DialogMgr.instance.getDlg(WelfareView));
//					return dialog ? dialog.btn_reward : null;
					break;
				case "背包按钮":
					return icon.cityMenubar.btn_bag;
					break;
				default:
					break;
			}
			return null;
		}


		/**
		 * 新手引导专用函数
		 * @param id
		 * type 1 转换场景
		 * type 2加载场景
		 */
		override public function executeGuideFun(name:String):void
		{
			if (name.indexOf("加载关卡") >= 0)
				GameMessage.gotoTollgateData(int(name.split(",")[1]));
		}

		/**
		 * 功能引导
		 * @param name
		 * @return
		 *
		 */
		override public function getViewGuideDisplay(name:String):*
		{
			switch (name)
			{
				case "宝珠商店":
					var effcet_magicball_house:House=getHouseByName("effcet_magicball_house");
					effcet_magicball_house.onClick.addOnce(gotoNext);
					icon.touchable=false;
					return effcet_magicball_house;
					break;
				case "英雄酒馆":
					var effcet_tavern_house:House=getHouseByName("effcet_tavern_house");
					if (effcet_tavern_house == null)
						return null;
					icon.touchable=false;
					effcet_tavern_house.onClick.addOnce(gotoNext);
					return effcet_tavern_house;
					break;
				case "活动按钮":
					break;
				case "铁匠铺":
					var effcet_hecheng:House=getHouseByName("effcet_hecheng");
					if (effcet_hecheng == null)
						return null;
					icon.touchable=false;
					effcet_hecheng.onClick.addOnce(gotoNext);
					return effcet_hecheng;
					break;
				case "竞技场":
					var effcet_pvp_house:HouseImage=_container1.getChildByName("effcet_pvp_house") as HouseImage;
					if (effcet_pvp_house == null)
						return null;
					icon.touchable=false;
					effcet_pvp_house.onClick.addOnce(gotoNext);
					return effcet_pvp_house;
					break;
			}

			function gotoNext():void
			{
				getHouseByName("effcet_hero_house").touchable=true;
			}
		}

		public function getHouseByName(name:String):House
		{
			return _container1.getChildByName(name) as House;
		}

		override public function dispose():void
		{
			JTFunctionManager.removeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE, onStopAnimatable);
			JTFunctionManager.removeFunction(JTGlobalDef.PLAY_CITY_ANIMATABLE, onPlayAnimatable);
			JTFunctionManager.removeFunction(JTGlobalDef.SHOW_CHAT_PANEL, onShowChatPanelHandler);
			JTChatControllerComponent.close();
			SoundManager.instance.stopAllSounds();
			SoundManager.instance.tweenVolumeSmall("city_bgm", 0.0, 1);
			Starling.juggler.remove(this);
			super.dispose();

            // now would be a good time for a clean-up
            System.pauseForGCIfCollectionImminent(0);
            System.gc();
		}
	}
}
