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
    import game.view.arena.render.ArenaCreateNameRender;
    import feathers.controls.renderers.DefaultListItemRenderer;

    public class ReportItemViewBase extends DefaultListItemRenderer
    {
        public var ui_danxiangkuangdi08:Scale9Image;
        public var bgImage:Scale9Image;
        public var hero_icon:ArenaCreateNameRender;
        public var btn_Scale9Button:Scale9Button;
        public var txt_2:TextField;
        public var txt_1:TextField;
        public var sbSprite:Sprite;
        public var slSprite:Sprite;

        public function ReportItemViewBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var ui_danxiangkuangdi08Rect:Rectangle = new Rectangle(18,18,35,35);
            var ui_danxiangkuangdi089ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_danxiangkuangdi08Rect);
            ui_danxiangkuangdi08 = new Scale9Image(ui_danxiangkuangdi089ScaleTexture);
            ui_danxiangkuangdi08.y = 8;
            ui_danxiangkuangdi08.width = 760;
            ui_danxiangkuangdi08.height = 69;
            this.addQuiackChild(ui_danxiangkuangdi08);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImageRect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.x = 360;
            bgImage.y = 16;
            bgImage.width = 220;
            bgImage.height = 52;
            this.addQuiackChild(bgImage);
            hero_icon = new ArenaCreateNameRender();
            hero_icon.x = 307;
            this.addQuiackChild(hero_icon);
            texture = assetMgr.getTexture('ui_hong02_01_anniu');
            var btn_Scale9ButtonRect:Rectangle = new Rectangle(25,10,50,20);
            btn_Scale9Button = new Scale9Button(texture,btn_Scale9ButtonRect);
            btn_Scale9Button.x = 598;
            btn_Scale9Button.y = 22;
            btn_Scale9Button.width = 150;
            btn_Scale9Button.height = 39;
            this.addQuiackChild(btn_Scale9Button);
            btn_Scale9Button.name = 'btn_Scale9Button';
            btn_Scale9Button.text= 'lable';
            btn_Scale9Button.fontColor= 0xFFFFFFB4;
            btn_Scale9Button.fontSize= 24;
            txt_2 = new TextField(173,31,'','',24,0xFFFFFF,false);
            txt_2.touchable = false;
            txt_2.hAlign= 'left';
            txt_2.text= '';
            txt_2.x = 398;
            txt_2.y = 27;
            this.addQuiackChild(txt_2);
            txt_1 = new TextField(142,31,'','',24,0xCADCF0,false);
            txt_1.touchable = false;
            txt_1.hAlign= 'center';
            txt_1.text= '';
            txt_1.x = 161;
            txt_1.y = 30;
            this.addQuiackChild(txt_1);
            sbSprite = new Sprite();
            sbSprite.x = 40;
            sbSprite.y = 18;
            sbSprite.width = 117;
            sbSprite.height = 48;
            this.addQuiackChild(sbSprite);
            sbSprite.name= 'sbSprite';
            texture =assetMgr.getTexture('ui_shibaidi');
            image = new Image(texture);
            image.width = 86;
            image.height = 48;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            sbSprite.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_shibaizi_01');
            image = new Image(texture);
            image.x = 35;
            image.y = 3;
            image.width = 45;
            image.height = 41;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            sbSprite.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_shibaidi_jiantou');
            image = new Image(texture);
            image.x = 90;
            image.y = 5;
            image.width = 27;
            image.height = 38;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            sbSprite.addQuiackChild(image);
            slSprite = new Sprite();
            slSprite.x = 40;
            slSprite.y = 18;
            slSprite.width = 117;
            slSprite.height = 48;
            this.addQuiackChild(slSprite);
            slSprite.name= 'slSprite';
            texture =assetMgr.getTexture('ui_shenglidi');
            image = new Image(texture);
            image.width = 86;
            image.height = 48;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            slSprite.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_shenglizi_01');
            image = new Image(texture);
            image.x = 35;
            image.y = 3;
            image.width = 45;
            image.height = 41;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            slSprite.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_shenglidi_jiantou');
            image = new Image(texture);
            image.x = 90;
            image.y = 5;
            image.width = 27;
            image.height = 38;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            slSprite.addQuiackChild(image);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            hero_icon.dispose();
            sbSprite.dispose();
            slSprite.dispose();
            super.dispose();
        
}
    }
}
