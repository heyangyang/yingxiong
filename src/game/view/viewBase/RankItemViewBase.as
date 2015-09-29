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

    public class RankItemViewBase extends DefaultListItemRenderer
    {
        public var ui_danxiangkuangdi07:Scale9Image;
        public var bgImage:Scale9Image;
        public var hero_icon:ArenaCreateNameRender;
        public var btn_Scale9Button:Scale9Button;
        public var txt_2:TextField;
        public var txt_4:TextField;
        public var txt_3:TextField;
        public var txt_1:TextField;

        public function RankItemViewBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var ui_danxiangkuangdi07Rect:Rectangle = new Rectangle(18,18,35,35);
            var ui_danxiangkuangdi079ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_danxiangkuangdi07Rect);
            ui_danxiangkuangdi07 = new Scale9Image(ui_danxiangkuangdi079ScaleTexture);
            ui_danxiangkuangdi07.y = 7;
            ui_danxiangkuangdi07.width = 760;
            ui_danxiangkuangdi07.height = 69;
            this.addQuiackChild(ui_danxiangkuangdi07);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImageRect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.x = 8;
            bgImage.y = 15;
            bgImage.width = 365;
            bgImage.height = 52;
            this.addQuiackChild(bgImage);
            hero_icon = new ArenaCreateNameRender();
            hero_icon.x = 128;
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
            txt_2 = new TextField(157,31,'','',24,0xFFFFFF,false);
            txt_2.touchable = false;
            txt_2.hAlign= 'center';
            txt_2.text= '';
            txt_2.x = 212;
            txt_2.y = 26;
            this.addQuiackChild(txt_2);
            txt_4 = new TextField(151,31,'','',24,0x5E0000,false);
            txt_4.touchable = false;
            txt_4.hAlign= 'left';
            txt_4.text= '';
            txt_4.x = 457;
            txt_4.y = 27;
            this.addQuiackChild(txt_4);
            txt_3 = new TextField(81,28,'','',21,0x5E0000,false);
            txt_3.touchable = false;
            txt_3.hAlign= 'left';
            txt_3.text= ' ';
            txt_3.x = 375;
            txt_3.y = 28;
            this.addQuiackChild(txt_3);
            txt_1 = new TextField(26,31,'','',24,0xFFFFFF,false);
            txt_1.touchable = false;
            txt_1.hAlign= 'center';
            txt_1.text= '';
            txt_1.x = 57;
            txt_1.y = 24;
            this.addQuiackChild(txt_1);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            hero_icon.dispose();
            super.dispose();
        
}
    }
}
