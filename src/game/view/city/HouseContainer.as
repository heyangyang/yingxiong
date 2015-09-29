package game.view.city
{
import com.langue.Langue;
import com.utils.Constants;
import com.utils.ObjectUtil;

import game.hero.AnimationCreator;
import game.manager.AssetMgr;
import game.view.dispark.DisparkControl;

import spriter.SpriterClip;

import starling.core.Starling;
import starling.display.DisplayObjectContainer;
import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.TextureAtlas;

/**
	 * ...
	 * @author ...
	 */
	public class HouseContainer extends Sprite
	{
		private var _callback:Function;
		private var _bg:Image;
		private var weibing_index:int=0;
		private var arrow_animation:SpriterClip;

		public function HouseContainer(callback:Function)
		{
			_callback=callback;
			_bg=new Image(AssetMgr.instance.getTexture("town_bg"));
            addQuiackChild(_bg);
			createCloud();

			createImage(this, "effcet_society_house", 110, 146);
			createImage(this, "effcet_lion_house", 623, 150);
			createImage(this, "effcet_pvp_house", 929, 230);

			createHouse(this, "effcet_transcript_house", 1416, 154);
			createHouse(this, "effcet_shop_house", 23, 330);
			createHouse(this, "effcet_magicball_house", 271, 387);
			createHouse(this, "effcet_hero_house",1200 , 419);

            createHouse(this, "effcet_hecheng",950, 478);
			createHouse(this, "effcet_tavern_house",603 , 407);

			createHouse(this, "effcet_mainline_house", 1542, 427);

			arrow_animation=AnimationCreator.instance.create("effect_zhuxianjiantou", AssetMgr.instance);
			arrow_animation.x=Constants.standardWidth + 750;
			arrow_animation.y=577
			addQuiackChild(arrow_animation);
			arrow_animation.play("effect_zhuxianjiantou");
			arrow_animation.animation.looping=true;
			arrow_animation.touchable=false;

			createLabel(Langue.getLans("TOWN_HOUSE_NAME"), [{x: 147, y: 395}, {x: 258, y: 173}, {x: 448, y: 416}, {x: 720, y: 430}, {x: 617, y: 255}, {x: 1074, y: 442}, {x: 1137, y: 272}, {x: 1382, y: 442}, {x: 1614, y: 248}, {x: 1608, y:434 }]);

		}

		override  public function set x(value:Number):void
		{
            super .x = value;
			if (x >  (-this.width +Constants.virtualWidth) + 100)
				arrow_animation.x=Constants.virtualWidth - x - 40;
			else
				arrow_animation.x=Constants.standardWidth + 750;
		}
		private function createCloud():void
		{
            addQuiackChild(new Cloud(_bg.width, _bg.height, "town_cloud_layer1"));
            addQuiackChild(new Cloud(_bg.width, _bg.height, "town_cloud_layer2"));
            addQuiackChild(new Cloud(_bg.width, _bg.height, "town_cloud_layer1"));
            addQuiackChild(new Cloud(_bg.width, _bg.height, "town_cloud_layer2"));
		}

		private function createLabel(label:Array, position:Array):void
		{
			var len:int=label.length;
			var lab:Sprite=null;

			for (var i:int=0; i < len; i++)
			{
				lab=new Sprite();
				var bg:Image=new Image(AssetMgr.instance.getTexture("house_label"));
				var txt:TextField=new TextField(bg.width, bg.height, label[i], "", 24, 0xffb400, true);
				var pos:Object=position[i];
				lab.x=pos.x;
				lab.y=pos.y;
				ObjectUtil.setToCenter(bg, txt);
				lab.addQuiackChild(bg);
				lab.addQuiackChild(txt);
                addQuiackChild(lab);

				lab.touchable=false;
				bg.touchable=false;
				txt.touchable=false;

				DisparkControl.dicDisplay["house_label_" + i]=lab;
			}

			var obj:Object=AssetMgr.instance.getObject("role_100");
			var t:TextureAtlas=AssetMgr.instance.getTextureAtlas("role_100");
			var spriterClip:SpriterClip=new SpriterClip(obj, t);
			spriterClip.play("idle");
			Starling.juggler.add(spriterClip);
			addQuiackChild(spriterClip);

		}

		private function createImage(container:DisplayObjectContainer, houseName:String, x:int, y:int):void
		{
			var image:HouseImage=new HouseImage(houseName);
			image.x=x;
			image.y=y;
			image.name=houseName;
			container.addQuiackChild(image);
			image.onClick.add(function(house:HouseImage):void
				{
					_callback(houseName)
				});
		}


		private function createHouse(container:DisplayObjectContainer, houseName:String, x:int, y:int):void
		{
			var house:House=AnimationCreator.instance.createHouse(houseName, AssetMgr.instance);
			house.play();

			house.x=x;
			house.y=y;
			house.name=houseName;
			container.addQuiackChild(house);
			house.onClick.add(function(house:House):void
				{
					_callback(houseName)
				});
		}

		override public function dispose():void
		{
			super.dispose();
			_callback=null;
			_bg=null;
		}
	}
}
