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

    public class SystemSetDlgBase extends Dialog
    {
        public var ui_tipstanchukuangdi01_jiemian00:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian83191:Scale9Image;
        public var ui_zhuangshixianquan03_jiemian65127:Scale9Image;
        public var ui_zhuangshixianquan01_jiemian79141:Scale9Image;
        public var ico_hero:Button;
        public var name_01:TextField;
        public var txt_association:TextField;
        public var txt_name:TextField;
        public var txt_association_Name:TextField;
        public var btn_offMusic:Button;
        public var ui_zhuangshixianquan02_jiemian4373:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian43270:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian43450:Scale9Image;
        public var txt_des7:TextField;
        public var txt_code:TextField;
        public var change_Scale9Button:Scale9Button;
        public var feed_Scale9Button:Scale9Button;
        public var redemption_Scale9Button:Scale9Button;
        public var out_Scale9Button:Scale9Button;
        public var head:Image;
        public var mask:Image;
        public var txt_vip:TextField;
        public var text_version_number:TextField;
        public var text_number:TextField;

        public function SystemSetDlgBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var ui_tipstanchukuangdi01_jiemian00Rect:Rectangle = new Rectangle(68,64,6,6);
            var ui_tipstanchukuangdi01_jiemian009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_tipstanchukuangdi01_jiemian00Rect);
            ui_tipstanchukuangdi01_jiemian00 = new Scale9Image(ui_tipstanchukuangdi01_jiemian009ScaleTexture);
            ui_tipstanchukuangdi01_jiemian00.width = 686;
            ui_tipstanchukuangdi01_jiemian00.height = 530;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian00);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian83191Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian831919ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian83191Rect);
            ui_zhuangshixianquan02_jiemian83191 = new Scale9Image(ui_zhuangshixianquan02_jiemian831919ScaleTexture);
            ui_zhuangshixianquan02_jiemian83191.x = 83;
            ui_zhuangshixianquan02_jiemian83191.y = 191;
            ui_zhuangshixianquan02_jiemian83191.width = 446;
            ui_zhuangshixianquan02_jiemian83191.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian83191);
            texture = assetMgr.getTexture('ui_zhuangshixianquan03_jiemian');
            var ui_zhuangshixianquan03_jiemian65127Rect:Rectangle = new Rectangle(30,30,10,10);
            var ui_zhuangshixianquan03_jiemian651279ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan03_jiemian65127Rect);
            ui_zhuangshixianquan03_jiemian65127 = new Scale9Image(ui_zhuangshixianquan03_jiemian651279ScaleTexture);
            ui_zhuangshixianquan03_jiemian65127.x = 65;
            ui_zhuangshixianquan03_jiemian65127.y = 127;
            ui_zhuangshixianquan03_jiemian65127.width = 484;
            ui_zhuangshixianquan03_jiemian65127.height = 130;
            this.addQuiackChild(ui_zhuangshixianquan03_jiemian65127);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian79141Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian791419ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian79141Rect);
            ui_zhuangshixianquan01_jiemian79141 = new Scale9Image(ui_zhuangshixianquan01_jiemian791419ScaleTexture);
            ui_zhuangshixianquan01_jiemian79141.x = 79;
            ui_zhuangshixianquan01_jiemian79141.y = 141;
            ui_zhuangshixianquan01_jiemian79141.width = 456;
            ui_zhuangshixianquan01_jiemian79141.height = 102;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian79141);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 526;
            image.y = 144;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 526;
            image.y = 240;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_touxiangdi01_01');
            ico_hero = new Button(texture);
            ico_hero.name= 'ico_hero';
            ico_hero.x = 47;
            ico_hero.y = 129;
            ico_hero.width = 84;
            ico_hero.height = 84;
            this.addQuiackChild(ico_hero);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 48;
            image.y = 38;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 638;
            image.y = 38;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 48;
            image.y = 485;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1.015869140625;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 638;
            image.y = 485;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1.015869140625;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_juesexinxi_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 292;
            image.y = 39;
            image.width = 102;
            image.height = 30;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            name_01 = new TextField(72,32,'','',24,0x999999,false);
            name_01.touchable = false;
            name_01.hAlign= 'right';
            name_01.text= '';
            name_01.x = 151;
            name_01.y = 150;
            this.addQuiackChild(name_01);
            txt_association = new TextField(72,32,'','',24,0x999999,false);
            txt_association.touchable = false;
            txt_association.hAlign= 'right';
            txt_association.text= '';
            txt_association.x = 151;
            txt_association.y = 200;
            this.addQuiackChild(txt_association);
            txt_name = new TextField(234,32,'','',24,0xFFFFFF,false);
            txt_name.touchable = false;
            txt_name.hAlign= 'center';
            txt_name.text= '';
            txt_name.x = 231;
            txt_name.y = 150;
            this.addQuiackChild(txt_name);
            txt_association_Name = new TextField(234,32,'','',24,0xFFFFFF,false);
            txt_association_Name.touchable = false;
            txt_association_Name.hAlign= 'center';
            txt_association_Name.text= '';
            txt_association_Name.x = 231;
            txt_association_Name.y = 200;
            this.addQuiackChild(txt_association_Name);
            texture = assetMgr.getTexture('ui_shengyin01_anniu');
            btn_offMusic = new Button(texture);
            btn_offMusic.name= 'btn_offMusic';
            btn_offMusic.x = 561;
            btn_offMusic.y = 151;
            btn_offMusic.width = 78;
            btn_offMusic.height = 82;
            this.addQuiackChild(btn_offMusic);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian4373Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian43739ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian4373Rect);
            ui_zhuangshixianquan02_jiemian4373 = new Scale9Image(ui_zhuangshixianquan02_jiemian43739ScaleTexture);
            ui_zhuangshixianquan02_jiemian4373.x = 43;
            ui_zhuangshixianquan02_jiemian4373.y = 73;
            ui_zhuangshixianquan02_jiemian4373.width = 600;
            ui_zhuangshixianquan02_jiemian4373.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian4373);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian43270Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian432709ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian43270Rect);
            ui_zhuangshixianquan02_jiemian43270 = new Scale9Image(ui_zhuangshixianquan02_jiemian432709ScaleTexture);
            ui_zhuangshixianquan02_jiemian43270.x = 43;
            ui_zhuangshixianquan02_jiemian43270.y = 270;
            ui_zhuangshixianquan02_jiemian43270.width = 600;
            ui_zhuangshixianquan02_jiemian43270.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian43270);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian43450Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian434509ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian43450Rect);
            ui_zhuangshixianquan02_jiemian43450 = new Scale9Image(ui_zhuangshixianquan02_jiemian434509ScaleTexture);
            ui_zhuangshixianquan02_jiemian43450.x = 43;
            ui_zhuangshixianquan02_jiemian43450.y = 450;
            ui_zhuangshixianquan02_jiemian43450.width = 600;
            ui_zhuangshixianquan02_jiemian43450.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian43450);
            txt_des7 = new TextField(150,32,'','',24,0x999999,false);
            txt_des7.touchable = false;
            txt_des7.hAlign= 'right';
            txt_des7.text= '';
            txt_des7.x = 165;
            txt_des7.y = 457;
            this.addQuiackChild(txt_des7);
            txt_code = new TextField(200,32,'','',24,0xFFFFFF,false);
            txt_code.touchable = false;
            txt_code.hAlign= 'center';
            txt_code.text= '';
            txt_code.x = 321;
            txt_code.y = 457;
            this.addQuiackChild(txt_code);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var change_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            change_Scale9Button = new Scale9Button(texture,change_Scale9ButtonRect);
            change_Scale9Button.x = 125;
            change_Scale9Button.y = 290;
            change_Scale9Button.width = 186;
            change_Scale9Button.height = 70;
            this.addQuiackChild(change_Scale9Button);
            change_Scale9Button.name = 'change_Scale9Button';
            change_Scale9Button.text= 'lable';
            change_Scale9Button.fontColor= 0xFFFFFF;
            change_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var feed_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            feed_Scale9Button = new Scale9Button(texture,feed_Scale9ButtonRect);
            feed_Scale9Button.x = 125;
            feed_Scale9Button.y = 372;
            feed_Scale9Button.width = 186;
            feed_Scale9Button.height = 70;
            this.addQuiackChild(feed_Scale9Button);
            feed_Scale9Button.name = 'feed_Scale9Button';
            feed_Scale9Button.text= 'lable';
            feed_Scale9Button.fontColor= 0xFFFFFF;
            feed_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var redemption_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            redemption_Scale9Button = new Scale9Button(texture,redemption_Scale9ButtonRect);
            redemption_Scale9Button.x = 376;
            redemption_Scale9Button.y = 290;
            redemption_Scale9Button.width = 186;
            redemption_Scale9Button.height = 70;
            this.addQuiackChild(redemption_Scale9Button);
            redemption_Scale9Button.name = 'redemption_Scale9Button';
            redemption_Scale9Button.text= 'lable';
            redemption_Scale9Button.fontColor= 0xFFFFFF;
            redemption_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var out_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            out_Scale9Button = new Scale9Button(texture,out_Scale9ButtonRect);
            out_Scale9Button.x = 376;
            out_Scale9Button.y = 372;
            out_Scale9Button.width = 186;
            out_Scale9Button.height = 70;
            this.addQuiackChild(out_Scale9Button);
            out_Scale9Button.name = 'out_Scale9Button';
            out_Scale9Button.text= 'lable';
            out_Scale9Button.fontColor= 0xFFFFFF;
            out_Scale9Button.fontSize= 24;
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 636;
            image.y = 43;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 50;
            image.y = 43;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 524;
            image.y = 149;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 636;
            image.y = 480;
            image.width = 8;
            image.height = 33;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 524;
            image.y = 235;
            image.width = 8;
            image.height = 33;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 50;
            image.y = 480;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('photo_100')
            head = new Image(texture);
            head.x = 53;
            head.y = 135;
            head.width = 72;
            head.height = 72;
            this.addQuiackChild(head);
            head.touchable = false;
            texture = assetMgr.getTexture('ui_touxiangdi01_02')
            mask = new Image(texture);
            mask.x = 47;
            mask.y = 129;
            mask.width = 84;
            mask.height = 84;
            this.addQuiackChild(mask);
            mask.touchable = false;
            texture =assetMgr.getTexture('ui_vipzuoshang01_tubiao');
            image = new Image(texture);
            image.x = 64;
            image.y = 198;
            image.width = 50;
            image.height = 59;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_vip = new TextField(50,31,'','',24,0xFFFFFF,false);
            txt_vip.touchable = false;
            txt_vip.hAlign= 'center';
            txt_vip.text= '0';
            txt_vip.x = 64;
            txt_vip.y = 214;
            this.addQuiackChild(txt_vip);
            text_version_number = new TextField(125,38,'','',26,0xFFFFFF,false);
            text_version_number.touchable = false;
            text_version_number.hAlign= 'center';
            text_version_number.text= '';
            text_version_number.x = 49;
            text_version_number.y = 80;
            this.addQuiackChild(text_version_number);
            text_number = new TextField(182,38,'','',24,0xFFFFFF,false);
            text_number.touchable = false;
            text_number.hAlign= 'left';
            text_number.text= '';
            text_number.x = 181;
            text_number.y = 80;
            this.addQuiackChild(text_number);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            ico_hero.dispose();
            btn_offMusic.dispose();
            super.dispose();
        
}
    }
}