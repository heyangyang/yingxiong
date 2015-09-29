package  game.view.viewBase
{
    import starling.display.Image;
    import game.manager.AssetMgr;
    import starling.utils.AssetManager;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.text.TextField;
    import starling.display.Button;
    import flash.geom.Rectangle;
    import com.utils.Constants;
    import feathers.controls.TextInput;
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;
    import com.components.Scale9Button;
    import com.view.View;

    public class EngageViewBase extends View
    {
        public var ui_zhuangshixianquan01_jiemian620224:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian624261:Scale9Image;
        public var ui_zhuangshixianquan01_jiemian44485:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian448122:Scale9Image;
        public var ui_zhuangshixianquan01_jiemian444224:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian448257:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian162427:Scale9Image;
        public var skill_0:Button;
        public var skill_1:Button;
        public var skill_2:Button;
        public var diamond_Scale9Button:Scale9Button;
        public var diaIcon:Image;
        public var text_HabitWeapon:TextField;
        public var text_HabitWeaponValue:TextField;
        public var text_expertValue:TextField;
        public var text_expert:TextField;
        public var textSkill_0:TextField;
        public var textSkill_1:TextField;
        public var textSkill_2:TextField;
        public var text_heroInfo:TextField;

        public function EngageViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian620224Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian6202249ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian620224Rect);
            ui_zhuangshixianquan01_jiemian620224 = new Scale9Image(ui_zhuangshixianquan01_jiemian6202249ScaleTexture);
            ui_zhuangshixianquan01_jiemian620224.x = 620;
            ui_zhuangshixianquan01_jiemian620224.y = 224;
            ui_zhuangshixianquan01_jiemian620224.width = 294;
            ui_zhuangshixianquan01_jiemian620224.height = 110;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian620224);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian624261Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian6242619ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian624261Rect);
            ui_zhuangshixianquan02_jiemian624261 = new Scale9Image(ui_zhuangshixianquan02_jiemian6242619ScaleTexture);
            ui_zhuangshixianquan02_jiemian624261.x = 624;
            ui_zhuangshixianquan02_jiemian624261.y = 261;
            ui_zhuangshixianquan02_jiemian624261.width = 286;
            ui_zhuangshixianquan02_jiemian624261.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian624261);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 629;
            image.y = 227;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 905;
            image.y = 227;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 714;
            image.y = 260;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 820;
            image.y = 260;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_yingxiongtexing_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 716;
            image.y = 229;
            image.width = 102;
            image.height = 31;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian44485Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian444859ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian44485Rect);
            ui_zhuangshixianquan01_jiemian44485 = new Scale9Image(ui_zhuangshixianquan01_jiemian444859ScaleTexture);
            ui_zhuangshixianquan01_jiemian44485.x = 444;
            ui_zhuangshixianquan01_jiemian44485.y = 85;
            ui_zhuangshixianquan01_jiemian44485.width = 470;
            ui_zhuangshixianquan01_jiemian44485.height = 134;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian44485);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian448122Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian4481229ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian448122Rect);
            ui_zhuangshixianquan02_jiemian448122 = new Scale9Image(ui_zhuangshixianquan02_jiemian4481229ScaleTexture);
            ui_zhuangshixianquan02_jiemian448122.x = 448;
            ui_zhuangshixianquan02_jiemian448122.y = 122;
            ui_zhuangshixianquan02_jiemian448122.width = 462;
            ui_zhuangshixianquan02_jiemian448122.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian448122);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 453;
            image.y = 88;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 905;
            image.y = 88;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 627;
            image.y = 121;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 733;
            image.y = 121;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_yingxiongjianjie_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 629;
            image.y = 91;
            image.width = 102;
            image.height = 31;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian444224Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian4442249ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian444224Rect);
            ui_zhuangshixianquan01_jiemian444224 = new Scale9Image(ui_zhuangshixianquan01_jiemian4442249ScaleTexture);
            ui_zhuangshixianquan01_jiemian444224.x = 444;
            ui_zhuangshixianquan01_jiemian444224.y = 224;
            ui_zhuangshixianquan01_jiemian444224.width = 168;
            ui_zhuangshixianquan01_jiemian444224.height = 188;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian444224);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian448257Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian4482579ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian448257Rect);
            ui_zhuangshixianquan02_jiemian448257 = new Scale9Image(ui_zhuangshixianquan02_jiemian4482579ScaleTexture);
            ui_zhuangshixianquan02_jiemian448257.x = 448;
            ui_zhuangshixianquan02_jiemian448257.y = 257;
            ui_zhuangshixianquan02_jiemian448257.width = 160;
            ui_zhuangshixianquan02_jiemian448257.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian448257);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 453;
            image.y = 227;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 603;
            image.y = 227;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_jineng_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 502;
            image.y = 227;
            image.width = 53;
            image.height = 30;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 492;
            image.y = 256;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 564;
            image.y = 256;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian162427Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian1624279ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian162427Rect);
            ui_zhuangshixianquan02_jiemian162427 = new Scale9Image(ui_zhuangshixianquan02_jiemian1624279ScaleTexture);
            ui_zhuangshixianquan02_jiemian162427.x = 162;
            ui_zhuangshixianquan02_jiemian162427.y = 427;
            ui_zhuangshixianquan02_jiemian162427.width = 772;
            ui_zhuangshixianquan02_jiemian162427.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian162427);
            texture =assetMgr.getTexture('ui_xiangyoutishi01_anniu');
            image = new Image(texture);
            image.x = 900;
            image.y = 436;
            image.width = 68;
            image.height = 109;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_xiangzuotishi01_anniu');
            image = new Image(texture);
            image.x = 127;
            image.y = 436;
            image.width = 68;
            image.height = 109;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_jinengkuangdi01');
            skill_0 = new Button(texture);
            skill_0.name= 'skill_0';
            skill_0.x = 450;
            skill_0.y = 262;
            skill_0.width = 46;
            skill_0.height = 46;
            this.addQuiackChild(skill_0);
            texture = assetMgr.getTexture('ui_jinengkuangdi01');
            skill_1 = new Button(texture);
            skill_1.name= 'skill_1';
            skill_1.x = 450;
            skill_1.y = 311;
            skill_1.width = 46;
            skill_1.height = 46;
            this.addQuiackChild(skill_1);
            texture = assetMgr.getTexture('ui_jinengkuangdi01');
            skill_2 = new Button(texture);
            skill_2.name= 'skill_2';
            skill_2.x = 450;
            skill_2.y = 360;
            skill_2.width = 46;
            skill_2.height = 46;
            this.addQuiackChild(skill_2);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var diamond_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            diamond_Scale9Button = new Scale9Button(texture,diamond_Scale9ButtonRect);
            diamond_Scale9Button.x = 680;
            diamond_Scale9Button.y = 347;
            diamond_Scale9Button.width = 200;
            diamond_Scale9Button.height = 70;
            this.addQuiackChild(diamond_Scale9Button);
            diamond_Scale9Button.name = 'diamond_Scale9Button';
            diamond_Scale9Button.text= '0';
            diamond_Scale9Button.fontColor= 0xffffff;
            diamond_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_jinbi01_tubiao')
            diaIcon = new Image(texture);
            diaIcon.x = 828;
            diaIcon.y = 367;
            diaIcon.width = 25;
            diaIcon.height = 26;
            this.addQuiackChild(diaIcon);
            diaIcon.touchable = false;
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 601;
            image.y = 232;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 454;
            image.y = 232;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 454;
            image.y = 93;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 903;
            image.y = 232;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 903;
            image.y = 93;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 630;
            image.y = 232;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            text_HabitWeapon = new TextField(124,32,'','',21,0xffffff,false);
            text_HabitWeapon.touchable = false;
            text_HabitWeapon.hAlign= 'center';
            text_HabitWeapon.text= '';
            text_HabitWeapon.x = 624;
            text_HabitWeapon.y = 297;
            this.addQuiackChild(text_HabitWeapon);
            text_HabitWeaponValue = new TextField(156,32,'','',21,0xff33ff,false);
            text_HabitWeaponValue.touchable = false;
            text_HabitWeaponValue.hAlign= 'center';
            text_HabitWeaponValue.text= '';
            text_HabitWeaponValue.x = 751;
            text_HabitWeaponValue.y = 297;
            this.addQuiackChild(text_HabitWeaponValue);
            text_expertValue = new TextField(156,32,'','',21,0xff6600,false);
            text_expertValue.touchable = false;
            text_expertValue.hAlign= 'center';
            text_expertValue.text= '';
            text_expertValue.x = 751;
            text_expertValue.y = 264;
            this.addQuiackChild(text_expertValue);
            text_expert = new TextField(124,32,'','',21,0xffffff,false);
            text_expert.touchable = false;
            text_expert.hAlign= 'center';
            text_expert.text= '';
            text_expert.x = 624;
            text_expert.y = 264;
            this.addQuiackChild(text_expert);
            textSkill_0 = new TextField(106,31,'','',20,0xffffff,false);
            textSkill_0.touchable = false;
            textSkill_0.hAlign= 'center';
            textSkill_0.text= '';
            textSkill_0.x = 499;
            textSkill_0.y = 269;
            this.addQuiackChild(textSkill_0);
            textSkill_1 = new TextField(106,31,'','',20,0xffffff,false);
            textSkill_1.touchable = false;
            textSkill_1.hAlign= 'center';
            textSkill_1.text= '';
            textSkill_1.x = 499;
            textSkill_1.y = 318;
            this.addQuiackChild(textSkill_1);
            textSkill_2 = new TextField(106,31,'','',20,0xffffff,false);
            textSkill_2.touchable = false;
            textSkill_2.hAlign= 'center';
            textSkill_2.text= '';
            textSkill_2.x = 499;
            textSkill_2.y = 367;
            this.addQuiackChild(textSkill_2);
            text_heroInfo = new TextField(460,90,'','',24,0xffffff,false);
            text_heroInfo.touchable = false;
            text_heroInfo.hAlign= 'left';
            text_heroInfo.text= '';
            text_heroInfo.x = 449;
            text_heroInfo.y = 126;
            this.addQuiackChild(text_heroInfo);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            skill_0.dispose();
            skill_1.dispose();
            skill_2.dispose();
            super.dispose();
        
}
    }
}
