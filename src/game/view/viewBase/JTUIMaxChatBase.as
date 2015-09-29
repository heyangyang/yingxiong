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
    import com.components.TabButton;
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;
    import com.components.Scale9Button;
    import com.dialog.TabDialog;

    public class JTUIMaxChatBase extends TabDialog
    {
        public var btn_close:Button;
        public var bgImage:Scale9Image;
        public var bgImage1:Scale9Image;
        public var ui_danxiangkuangdi1300:Scale9Image;
        public var bgImage0:Scale9Image;
        public var ui_zhuangshixianquan01_jiemian14512:Scale9Image;
        public var enter_Scale9Button:Scale9Button;
        public var tab_1:TabButton;
        public var tab_2:TabButton;
        public var tab_3:TabButton;
        public var text_horn:TextField;

        public function JTUIMaxChatBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('icon_liaotianguanbi_tubiao');
            btn_close = new Button(texture);
            btn_close.name= 'btn_close';
            btn_close.x = 64;
            btn_close.y = 420;
            btn_close.width = 80;
            btn_close.height = 98;
            this.addQuiackChild(btn_close);
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var bgImageRect:Rectangle = new Rectangle(68,64,6,6);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.x = 119;
            bgImage.y = 4;
            bgImage.width = 856;
            bgImage.height = 580;
            this.addQuiackChild(bgImage);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage1Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage19ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage1Rect);
            bgImage1 = new Scale9Image(bgImage19ScaleTexture);
            bgImage1.x = 168;
            bgImage1.y = 71;
            bgImage1.width = 758;
            bgImage1.height = 458;
            this.addQuiackChild(bgImage1);
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var ui_danxiangkuangdi1300Rect:Rectangle = new Rectangle(18,32,34,2);
            var ui_danxiangkuangdi13009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_danxiangkuangdi1300Rect);
            ui_danxiangkuangdi1300 = new Scale9Image(ui_danxiangkuangdi13009ScaleTexture);
            ui_danxiangkuangdi1300.x = 130;
            ui_danxiangkuangdi1300.width = 834;
            ui_danxiangkuangdi1300.height = 69;
            this.addQuiackChild(ui_danxiangkuangdi1300);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage0Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage09ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage0Rect);
            bgImage0 = new Scale9Image(bgImage09ScaleTexture);
            bgImage0.x = 149;
            bgImage0.y = 16;
            bgImage0.width = 686;
            bgImage0.height = 36;
            this.addQuiackChild(bgImage0);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian14512Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian145129ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian14512Rect);
            ui_zhuangshixianquan01_jiemian14512 = new Scale9Image(ui_zhuangshixianquan01_jiemian145129ScaleTexture);
            ui_zhuangshixianquan01_jiemian14512.x = 145;
            ui_zhuangshixianquan01_jiemian14512.y = 12;
            ui_zhuangshixianquan01_jiemian14512.width = 694;
            ui_zhuangshixianquan01_jiemian14512.height = 44;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian14512);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var enter_Scale9ButtonRect:Rectangle = new Rectangle(29,16,58,31);
            enter_Scale9Button = new Scale9Button(texture,enter_Scale9ButtonRect);
            enter_Scale9Button.x = 843;
            enter_Scale9Button.y = 5;
            enter_Scale9Button.width = 116;
            enter_Scale9Button.height = 62;
            this.addQuiackChild(enter_Scale9Button);
            enter_Scale9Button.name = 'enter_Scale9Button';
            enter_Scale9Button.text= 'lable';
            enter_Scale9Button.fontColor= 0xFFFFFF;
            enter_Scale9Button.fontSize= 24;
            tab_1 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_1.y = 78;
            tab_1.width = 173;
            tab_1.height = 86;
            this.addQuiackChild(tab_1);
            tab_1.text= 'lable';
            tab_1.fontColor= 0xFFFFFF;
            tab_1.fontSize= 28;
            tab_2 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_2.y = 154;
            tab_2.width = 173;
            tab_2.height = 86;
            this.addQuiackChild(tab_2);
            tab_2.text= 'lable';
            tab_2.fontColor= 0xFFFFFF;
            tab_2.fontSize= 28;
            tab_3 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_3.y = 227;
            tab_3.width = 173;
            tab_3.height = 86;
            this.addQuiackChild(tab_3);
            tab_3.text= 'lable';
            tab_3.fontColor= 0xFFFFFF;
            tab_3.fontSize= 28;
            text_horn = new TextField(145,37,'','',30,0xFFFFCC,false);
            text_horn.touchable = false;
            text_horn.hAlign= 'center';
            text_horn.text= '';
            text_horn.x = 802;
            text_horn.y = 71;
            this.addQuiackChild(text_horn);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btn_close.dispose();
            tab_1.dispose();
            tab_2.dispose();
            tab_3.dispose();
            super.dispose();
        
}
    }
}
