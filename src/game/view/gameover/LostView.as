package game.view.gameover
{
	import com.dialog.DialogMgr;
	import com.langue.Langue;
	import com.scene.SceneMgr;
	import com.sound.SoundManager;
	
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;
	
	import game.common.JTGlobalDef;
	import game.data.MainLineData;
	import game.hero.AnimationCreator;
	import game.manager.AssetMgr;
	import game.manager.GameMgr;
	import game.manager.HeroDataMgr;
	import game.managers.JTFunctionManager;
	import game.net.message.GameMessage;
	import game.scene.FBMapDialog;
	import game.scene.MainMapDialog;
	import game.view.arena.ArenaDialog;
	import game.view.city.CityFace;
	import game.view.viewBase.LostViewBase;
	
	import spriter.SpriterClip;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;

	/**
	 * 结算失败界面
	 * @author hyy
	 *
	 */
	public class LostView extends LostViewBase
	{
		private var animation:SpriterClip;

		public function LostView()
		{
			super();
		}

		override protected function init():void
		{
			replay_Scale9Button.text=Langue.getLangue("Battles_back"); //再战一回
			
			var arr:Array = Langue.getLans("Return_to_town");
			if(GameMgr.instance.game_type == GameMgr.MAIN_LINE){
				return_Scale9Button.text=arr[0]; //返回城镇
			}else if (GameMgr.instance.game_type == GameMgr.FB) {
				return_Scale9Button.text=arr[1];
			} else if (GameMgr.instance.game_type == GameMgr.Arena) {
				return_Scale9Button.text=arr[2];
			}

			const layout:TiledRowsLayout=new TiledRowsLayout();
			layout.verticalGap=15;
			layout.useSquareTiles=false;
			layout.useVirtualLayout=true;
			layout.tileVerticalAlign=TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
			layout.tileHorizontalAlign=TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
			list_view.layout=layout;
			list_view.verticalScrollPolicy=Scroller.SCROLL_POLICY_ON;
			list_view.horizontalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
			list_view.itemRendererFactory=tileListItemRendererFactory;
		}

		private function tileListItemRendererFactory():LostRender
		{
			const itemRender:LostRender=new LostRender();
			itemRender.setSize(684, 126);
			return itemRender;
		}

		override protected function addListenerHandler():void
		{
			super.addListenerHandler();
			this.addViewListener(replay_Scale9Button, Event.TRIGGERED, onNextHandler);
			this.addViewListener(return_Scale9Button, Event.TRIGGERED, onQuitHandler);
		}

		override public function open(container:DisplayObjectContainer, parameter:Object=null, okFun:Function=null, cancelFun:Function=null):void
		{
			super.open(container, parameter, okFun, cancelFun);
			createAnimation();
			replay_Scale9Button.visible=GameMgr.instance.battle_type != 3;
			SoundManager.instance.stopAllSounds();
			SoundManager.instance.playSound("BGM_Lose");
			updateList();
			setToCenter();
		}

		private function updateList():void
		{
			var mainLineData:MainLineData=MainLineData.getPoint(int(_parameter));
			if (mainLineData == null)
			{
				return;
			}
			var heroDataMg:HeroDataMgr=HeroDataMgr.instance;
			var tmp_list:Vector.<Object>=new Vector.<Object>;

			//英雄数量|装备等级|强化等级|英雄品质|宝珠品质|宝珠等级
			if (heroDataMg.getOnBattleHeroCount() < HeroDataMgr.instance.seatMax)
			{
				tmp_list.push({type: 0});
			}

			if (heroDataMg.getAllHeroEquipFieldByType("limitLevel") < mainLineData.guide_equip)
			{
				tmp_list.push({type: 1});
			}

			if (heroDataMg.getAllHeroEquipFieldByType("level") < mainLineData.guide_strengthen)
			{
				tmp_list.push({type: 2});
			}

			if (heroDataMg.getAllHeroFieldByType("quality") < mainLineData.guide_quality)
			{
				tmp_list.push({type: 3});
			}

			if (heroDataMg.getAllHeroEquipGemFieldByType("quality") < mainLineData.guide_gem)
			{
				tmp_list.push({type: 4});
			}

			if (heroDataMg.getAllHeroEquipGemFieldByType("level") < mainLineData.guide_gem_level)
			{
				tmp_list.push({type: 5});
			}
			if (tmp_list.length > 2)
			{
				tmp_list.length=2;
			}
			else if (tmp_list.length < 2)
			{
				tmp_list.push({type: 6});
			}
			list_view.dataProvider=new ListCollection(tmp_list);
		}

		private function onNextHandler():void
		{
			if (_okFunction != null)
			{
				_okFunction.call(null, 3, "agin", "agin");
			}
			close();
		}

		private function onQuitHandler():void
		{
			if (GameMessage.gotoTollgateBack())
			{
				trace("GameMessage.gotoTollgateBack");
				return;
			}
			switch (GameMgr.instance.game_type)
			{
				case GameMgr.MAIN_LINE:
					DialogMgr.instance.closeAllDialog();
					SceneMgr.instance.changeScene(CityFace);
					DialogMgr.instance.open(MainMapDialog);
					JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
					break;
				case GameMgr.FB:
					DialogMgr.instance.closeAllDialog();
					SceneMgr.instance.changeScene(CityFace);
					DialogMgr.instance.open(FBMapDialog);
					JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
					break;
				case GameMgr.Arena:
					SceneMgr.instance.changeScene(CityFace);
					DialogMgr.instance.open(ArenaDialog);
					break;
				default:
					break;
			}
			close();
		}


		/**
		 * 创建动画
		 */
		private function createAnimation():void
		{
			if (animation == null)
			{
				animation=AnimationCreator.instance.create("effect_shibaixiaoguo", AssetMgr.instance);
			}
			animation.play("effect_shibaixiaoguo");
			animation.x = 20;
			animation.animation.looping=true;
			addQuiackChild(animation);
			Starling.juggler.add(animation);
		}

		override public function dispose():void
		{
			animation && animation.removeFromParent(true);
			animation=null;
			super.dispose();
		}
	}
}


