package game.view.hero
{
	import com.dialog.DialogMgr;
	import com.mobileLib.utils.ConverURL;
	import com.view.View;

	import flash.system.System;

	import game.data.Goods;
	import game.data.HeroData;
	import game.data.RoleShow;
	import game.data.Val;
	import game.data.WidgetData;
	import game.hero.AnimationCreator;
	import game.view.comm.HeroSkillDialog;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import spriter.SpriterClip;

	import starling.core.Starling;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	/**
	 * 战斗外面，英雄圣殿，英雄酒馆等UI上展示的英雄形象
	 * @author Administrator
	 */
	public class HeroShow extends View
	{
		public static const animationList:Array=["idle", "attack", "move", "win", "underattack"];

		private var _viewHero:SpriterClip;
		private var _isTouchable:Boolean;
		private var _heroData:HeroData;
		private var _assets:AssetManager;
		public var complate:ISignal;
		private var changeIndex:uint=0;
		private var isChage:Boolean=false;


		public function HeroShow()
		{
			super();
			_assets=new AssetManager();
			complate=new Signal(HeroShow);
		}

		/**
		 *
		 * @param heroData 英雄数据模型
		 * @param isTouchable 点击是否显示英雄介绍信息
		 */
		public function updateHero(heroData:HeroData, isTouchable:Boolean=false):void
		{
			disposeCurrent();
			_heroData=heroData;
			_isTouchable=isTouchable;
			if (!_heroData || _heroData.show == 0)
			{
				complate.dispatch(this);
				return;
			}

			AnimationCreator.instance.loadHeroRes(heroData, _assets);
			var weapon:int=heroData.seat1;
			if (weapon > 0)
			{
				var goods:Goods=WidgetData.hash.getValue(weapon);
				if (goods == null)
					goods=Goods.goods.getValue(weapon);
				if (goods && goods.avatar)
				{
					_assets.enqueue(ConverURL.conver("weapon/" + goods.avatar));
				}
			}
			_assets.loadQueue(onLoaded);
		}

		/**
		 *更新装备
		 */
		public function updataWeapon():void
		{
			if (_viewHero == null)
				return;
			var weapon:int=_heroData.seat1;
			if (weapon > 0)
			{
				var goods:Goods=WidgetData.hash.getValue(weapon);
				if (goods == null)
					goods=Goods.goods.getValue(weapon);

				if (goods && goods.avatar)
					_viewHero.swapPieceByTex("role_weapon", _assets.getTexture(goods.avatar));
			}
			else
			{
				_viewHero.unswapPiece("role_weapon");
			}
		}

		/**加载*/
		private function onLoaded(ratio:Number):void
		{
			if (ratio == 1.0)
			{
				if (_assets)
					this.createAvatarHandler();
			}
		}

		/**建立显示模型*/
		public function createAvatarHandler():void
		{
			var roleShow:RoleShow=RoleShow.hash.getValue(_heroData.show) as RoleShow;
			var textureAtlas:TextureAtlas=_assets.getTextureAtlas(roleShow.avatar);
			if (textureAtlas != null)
			{
				_viewHero && _viewHero.removeFromParent(true);
				_viewHero=AnimationCreator.instance.create(roleShow.avatar, _assets, false);
				_viewHero.play(animationList[0]);
				_viewHero.scaleX=_viewHero.scaleY=1.4 * _heroData.size / Val.ROLE_ZISE;

				_viewHero.scaleX*=-1;
				_viewHero.animation.looping=true;
				_viewHero.touchable=true;
				Starling.juggler.add(_viewHero);
				_viewHero.addEventListener(TouchEvent.TOUCH, changeAnimation);
				isChage=false;
				addChild(_viewHero);
				updataWeapon();
				complate.dispatch(this);
			}
		}

		/**停止播放*/
		public function stop():void
		{
			if (_viewHero)
			{
				_viewHero.stop();
				Starling.juggler.remove(_viewHero);
			}
		}

		/**播放默认的待机*/
		public function play():void
		{
			if (_viewHero)
			{
				if (!_viewHero.isPlaying)
				{
					_viewHero.play(animationList[0]);
					Starling.juggler.add(_viewHero);
				}
			}
		}

		/**点击改变动作*/
		private function changeAnimation(e:TouchEvent):void
		{
			var touch:Touch=e.getTouch(stage);
			if (touch == null || isChage)
				return;
			changeIndex=(changeIndex >= 4) ? 0 : changeIndex; //英雄动作的长度
			switch (touch && touch.phase)
			{
				case TouchPhase.BEGAN:
					if (_viewHero)
					{
						changeIndex++;
						_viewHero.play(animationList[changeIndex]);
						Starling.juggler.add(_viewHero);
						_viewHero.animationComplete.addOnce(animationComplete);
						isChage=true;
						if (_isTouchable)
						{
							DialogMgr.instance.open(HeroSkillDialog, _heroData);
						}
					}
					break;
				default:
					break;
			}
		}

		/**播放动作完成*/
		private function animationComplete(sp:SpriterClip):void
		{
			_viewHero.play(animationList[0]);
			_viewHero.animationComplete.remove(animationComplete);
			isChage=false;
		}

		/**释放当前英雄*/
		public function disposeCurrent():void
		{
			_assets && _assets.dispose();
			_viewHero && _viewHero.removeFromParent(true);
			_viewHero=null;
		}

		/**销毁*/
		override public function dispose():void
		{
			_viewHero && _viewHero.removeFromParent(true);
			_assets.dispose();
			_isTouchable=false;
			_heroData=null;
			complate=null;
			changeIndex=0;
			_viewHero=null;
			_assets=null;
			super.dispose();

		}
	}
}



