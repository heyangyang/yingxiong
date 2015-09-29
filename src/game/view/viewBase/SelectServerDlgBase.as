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
    import com.dialog.Dialog;

    public class SelectServerDlgBase extends Dialog
    {
        public var bgImage0:Scale9Image;
        public var bgImage1:Scale9Image;
        public var login_Scale9Button:Scale9Button;
        public var registered_Scale9Button:Scale9Button;
        public var ui_zhuangshixianquan03_jiemian590:Scale9Image;
        public var BgServer:Scale9Image;
        public var txt_des:TextField;
        public var txt_servername:TextField;
        public var text_change:TextField;
        public var tag_new:Image;
        public var tag_hot:Image;

        public function SelectServerDlgBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage0Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage09ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage0Rect);
            bgImage0 = new Scale9Image(bgImage09ScaleTexture);
            bgImage0.width = 550;
            bgImage0.height = 174;
            this.addQuiackChild(bgImage0);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage1Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage19ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage1Rect);
            bgImage1 = new Scale9Image(bgImage19ScaleTexture);
            bgImage1.x = 16;
            bgImage1.y = 100;
            bgImage1.width = 518;
            bgImage1.height = 56;
            this.addQuiackChild(bgImage1);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var login_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            login_Scale9Button = new Scale9Button(texture,login_Scale9ButtonRect);
            login_Scale9Button.x = 311;
            login_Scale9Button.y = 16;
            login_Scale9Button.width = 186;
            login_Scale9Button.height = 70;
            this.addQuiackChild(login_Scale9Button);
            login_Scale9Button.name = 'login_Scale9Button';
            login_Scale9Button.text= 'lable';
            login_Scale9Button.fontColor= 0xFFFFC9;
            login_Scale9Button.fontSize= 28;
            texture = assetMgr.getTexture('ui_lan03_01_anniu');
            var registered_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            registered_Scale9Button = new Scale9Button(texture,registered_Scale9ButtonRect);
            registered_Scale9Button.x = 53;
            registered_Scale9Button.y = 16;
            registered_Scale9Button.width = 186;
            registered_Scale9Button.height = 70;
            this.addQuiackChild(registered_Scale9Button);
            registered_Scale9Button.name = 'registered_Scale9Button';
            registered_Scale9Button.text= 'lable';
            registered_Scale9Button.fontColor= 0xFFFFC9;
            registered_Scale9Button.fontSize= 28;
            texture = assetMgr.getTexture('ui_zhuangshixianquan03_jiemian');
            var ui_zhuangshixianquan03_jiemian590Rect:Rectangle = new Rectangle(30,30,10,10);
            var ui_zhuangshixianquan03_jiemian5909ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan03_jiemian590Rect);
            ui_zhuangshixianquan03_jiemian590 = new Scale9Image(ui_zhuangshixianquan03_jiemian5909ScaleTexture);
            ui_zhuangshixianquan03_jiemian590.x = 5;
            ui_zhuangshixianquan03_jiemian590.y = 90;
            ui_zhuangshixianquan03_jiemian590.width = 540;
            ui_zhuangshixianquan03_jiemian590.height = 78;
            this.addQuiackChild(ui_zhuangshixianquan03_jiemian590);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var BgServerRect:Rectangle = new Rectangle(12,12,20,20);
            var BgServer9ScaleTexture:Scale9Textures = new Scale9Textures(texture,BgServerRect);
            BgServer = new Scale9Image(BgServer9ScaleTexture);
            BgServer.x = 19;
            BgServer.y = 104;
            BgServer.width = 512;
            BgServer.height = 50;
            this.addQuiackChild(BgServer);
            txt_des = new TextField(145,44,'','',24,0x00FB01,false);
            txt_des.touchable = false;
            txt_des.hAlign= 'center';
            txt_des.text= '';
            txt_des.x = 28;
            txt_des.y = 107;
            this.addQuiackChild(txt_des);
            txt_servername = new TextField(200,44,'','',28,0xFFFFC9,false);
            txt_servername.touchable = false;
            txt_servername.hAlign= 'center';
            txt_servername.text= '';
            txt_servername.x = 175;
            txt_servername.y = 107;
            this.addQuiackChild(txt_servername);
            text_change = new TextField(144,44,'','',24,0xFFFFFF,false);
            text_change.touchable = false;
            text_change.hAlign= 'center';
            text_change.text= '';
            text_change.x = 378;
            text_change.y = 107;
            this.addQuiackChild(text_change);
            texture = assetMgr.getTexture('ui_district_iocn_xinqu')
            tag_new = new Image(texture);
            tag_new.x = 488;
            tag_new.y = 76;
            tag_new.width = 61;
            tag_new.height = 47;
            this.addQuiackChild(tag_new);
            tag_new.touchable = false;
            texture = assetMgr.getTexture('ui_district_iocn_huobao')
            tag_hot = new Image(texture);
            tag_hot.x = 488;
            tag_hot.y = 76;
            tag_hot.width = 61;
            tag_hot.height = 47;
            this.addQuiackChild(tag_hot);
            tag_hot.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
