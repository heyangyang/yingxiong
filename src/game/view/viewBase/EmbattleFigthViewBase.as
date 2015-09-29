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

    public class EmbattleFigthViewBase extends View
    {
        public var bg:Scale9Image;
        public var txt_power1:TextField;
        public var txt_des3:TextField;
        public var txt_des4:TextField;
        public var txt_count:TextField;
        public var txt_tired:TextField;
        public var txt_des1:TextField;
        public var txt_des2:TextField;
        public var txt_des5:TextField;
        public var txt_power:TextField;
        public var txt_des6:TextField;
        public var auto__Scale9Button:Scale9Button;
        public var battle__Scale9Button:Scale9Button;

        public function EmbattleFigthViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var bgRect:Rectangle = new Rectangle(68,64,6,6);
            var bg9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgRect);
            bg = new Scale9Image(bg9ScaleTexture);
            bg.width = 984;
            bg.height = 214;
            this.addQuiackChild(bg);
            texture =assetMgr.getTexture('ui_tubiao_rongyufenleianniu_zhandong');
            image = new Image(texture);
            image.x = 287;
            image.y = 54;
            image.width = 40;
            image.height = 38;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_power1 = new TextField(162,38,'','',26,0xFFFDD9,false);
            txt_power1.touchable = false;
            txt_power1.hAlign= 'left';
            txt_power1.text= '';
            txt_power1.x = 620;
            txt_power1.y = 111;
            this.addQuiackChild(txt_power1);
            texture =assetMgr.getTexture('ui_gongyong_iocn_zhandouli');
            image = new Image(texture);
            image.x = 579;
            image.y = 115;
            image.width = 32;
            image.height = 28;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_des3 = new TextField(120,38,'','',26,0xFFFDD9,false);
            txt_des3.touchable = false;
            txt_des3.hAlign= 'right';
            txt_des3.text= '';
            txt_des3.x = 450;
            txt_des3.y = 52;
            this.addQuiackChild(txt_des3);
            txt_des4 = new TextField(120,38,'','',26,0xFFFDD9,false);
            txt_des4.touchable = false;
            txt_des4.hAlign= 'right';
            txt_des4.text= '';
            txt_des4.x = 450;
            txt_des4.y = 111;
            this.addQuiackChild(txt_des4);
            txt_count = new TextField(113,38,'','',26,0xFFFDD9,false);
            txt_count.touchable = false;
            txt_count.hAlign= 'left';
            txt_count.text= '';
            txt_count.x = 330;
            txt_count.y = 52;
            this.addQuiackChild(txt_count);
            txt_tired = new TextField(111,38,'','',26,0xFFFDD9,false);
            txt_tired.touchable = false;
            txt_tired.hAlign= 'left';
            txt_tired.text= '';
            txt_tired.x = 330;
            txt_tired.y = 111;
            this.addQuiackChild(txt_tired);
            txt_des1 = new TextField(72,36,'','',24,0xFFFDD9,false);
            txt_des1.touchable = false;
            txt_des1.hAlign= 'right';
            txt_des1.text= '';
            txt_des1.x = 211;
            txt_des1.y = 52;
            this.addQuiackChild(txt_des1);
            txt_des2 = new TextField(72,36,'','',24,0xFFFDD9,false);
            txt_des2.touchable = false;
            txt_des2.hAlign= 'right';
            txt_des2.text= '';
            txt_des2.x = 211;
            txt_des2.y = 111;
            this.addQuiackChild(txt_des2);
            texture =assetMgr.getTexture('ui_gongyong_iocn_zhandouli');
            image = new Image(texture);
            image.x = 580;
            image.y = 56;
            image.width = 32;
            image.height = 28;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_des5 = new TextField(30,24,'','',14,0xFFFF00,false);
            txt_des5.touchable = false;
            txt_des5.hAlign= 'center';
            txt_des5.text= '';
            txt_des5.x = 582;
            txt_des5.y = 62;
            this.addQuiackChild(txt_des5);
            txt_power = new TextField(162,38,'','',26,0xFFFDD9,false);
            txt_power.touchable = false;
            txt_power.hAlign= 'left';
            txt_power.text= '';
            txt_power.x = 620;
            txt_power.y = 52;
            this.addQuiackChild(txt_power);
            txt_des6 = new TextField(42,22,'','',14,0xFFFF00,false);
            txt_des6.touchable = false;
            txt_des6.hAlign= 'center';
            txt_des6.text= '';
            txt_des6.x = 575;
            txt_des6.y = 122;
            this.addQuiackChild(txt_des6);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var auto__Scale9ButtonRect:Rectangle = new Rectangle(29,16,58,31);
            auto__Scale9Button = new Scale9Button(texture,auto__Scale9ButtonRect);
            auto__Scale9Button.x = 38;
            auto__Scale9Button.y = 70;
            auto__Scale9Button.width = 150;
            auto__Scale9Button.height = 64;
            this.addQuiackChild(auto__Scale9Button);
            auto__Scale9Button.name = 'auto__Scale9Button';
            auto__Scale9Button.text= 'lable';
            auto__Scale9Button.fontColor= 0xFFFFCC;
            auto__Scale9Button.fontSize= 21;
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var battle__Scale9ButtonRect:Rectangle = new Rectangle(29,16,58,31);
            battle__Scale9Button = new Scale9Button(texture,battle__Scale9ButtonRect);
            battle__Scale9Button.x = 794;
            battle__Scale9Button.y = 70;
            battle__Scale9Button.width = 150;
            battle__Scale9Button.height = 64;
            this.addQuiackChild(battle__Scale9Button);
            battle__Scale9Button.name = 'battle__Scale9Button';
            battle__Scale9Button.text= 'lable';
            battle__Scale9Button.fontColor= 0xFFFFCC;
            battle__Scale9Button.fontSize= 21;
            texture =assetMgr.getTexture('ui_tili01_tubiao');
            image = new Image(texture);
            image.x = 295;
            image.y = 117;
            image.width = 25;
            image.height = 26;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
