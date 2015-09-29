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

    public class ExtractViewBase extends View
    {
        public var ui_dicengying01_jiemian378480:Scale9Image;
        public var textfree:TextField;
        public var text_time:TextField;
        public var btn_Refresh:Button;
        public var freetipTxt:TextField;
        public var ui_zhuangshixianquan02_jiemian161461:Scale9Image;
        public var buyHero1_Scale9Button:Scale9Button;
        public var buyHero2_Scale9Button:Scale9Button;
        public var buyHero0_Scale9Button:Scale9Button;
        public var diaIcon_0:Image;
        public var diaIcon_1:Image;
        public var diaIcon_2:Image;

        public function ExtractViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_dicengying01_jiemian');
            var ui_dicengying01_jiemian378480Rect:Rectangle = new Rectangle(26,17,12,1);
            var ui_dicengying01_jiemian3784809ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_dicengying01_jiemian378480Rect);
            ui_dicengying01_jiemian378480 = new Scale9Image(ui_dicengying01_jiemian3784809ScaleTexture);
            ui_dicengying01_jiemian378480.x = 378;
            ui_dicengying01_jiemian378480.y = 480;
            ui_dicengying01_jiemian378480.width = 300;
            ui_dicengying01_jiemian378480.height = 48;
            this.addQuiackChild(ui_dicengying01_jiemian378480);
            textfree = new TextField(175,28,'','',21,0xffffff,false);
            textfree.touchable = false;
            textfree.hAlign= 'right';
            textfree.text= '';
            textfree.x = 382;
            textfree.y = 490;
            this.addQuiackChild(textfree);
            text_time = new TextField(148,28,'','',21,0x00ff00,false);
            text_time.touchable = false;
            text_time.hAlign= 'center';
            text_time.text= '';
            text_time.x = 534;
            text_time.y = 490;
            this.addQuiackChild(text_time);
            texture = assetMgr.getTexture('ui_shuaxin01_01_anniu');
            btn_Refresh = new Button(texture);
            btn_Refresh.name= 'btn_Refresh';
            btn_Refresh.x = 683;
            btn_Refresh.y = 478;
            btn_Refresh.width = 68;
            btn_Refresh.height = 52;
            this.addQuiackChild(btn_Refresh);
            freetipTxt = new TextField(228,31,'','',24,0x00ff00,false);
            freetipTxt.touchable = false;
            freetipTxt.hAlign= 'left';
            freetipTxt.text= '';
            freetipTxt.x = 421;
            freetipTxt.y = 489;
            this.addQuiackChild(freetipTxt);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian161461Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian1614619ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian161461Rect);
            ui_zhuangshixianquan02_jiemian161461 = new Scale9Image(ui_zhuangshixianquan02_jiemian1614619ScaleTexture);
            ui_zhuangshixianquan02_jiemian161461.x = 161;
            ui_zhuangshixianquan02_jiemian161461.y = 461;
            ui_zhuangshixianquan02_jiemian161461.width = 772;
            ui_zhuangshixianquan02_jiemian161461.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian161461);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var buyHero1_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            buyHero1_Scale9Button = new Scale9Button(texture,buyHero1_Scale9ButtonRect);
            buyHero1_Scale9Button.x = 454;
            buyHero1_Scale9Button.y = 381;
            buyHero1_Scale9Button.width = 200;
            buyHero1_Scale9Button.height = 70;
            this.addQuiackChild(buyHero1_Scale9Button);
            buyHero1_Scale9Button.name = 'buyHero1_Scale9Button';
            buyHero1_Scale9Button.text= '0';
            buyHero1_Scale9Button.fontColor= 0xffffff;
            buyHero1_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var buyHero2_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            buyHero2_Scale9Button = new Scale9Button(texture,buyHero2_Scale9ButtonRect);
            buyHero2_Scale9Button.x = 712;
            buyHero2_Scale9Button.y = 381;
            buyHero2_Scale9Button.width = 200;
            buyHero2_Scale9Button.height = 70;
            this.addQuiackChild(buyHero2_Scale9Button);
            buyHero2_Scale9Button.name = 'buyHero2_Scale9Button';
            buyHero2_Scale9Button.text= '0';
            buyHero2_Scale9Button.fontColor= 0xffffff;
            buyHero2_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var buyHero0_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            buyHero0_Scale9Button = new Scale9Button(texture,buyHero0_Scale9ButtonRect);
            buyHero0_Scale9Button.x = 196;
            buyHero0_Scale9Button.y = 381;
            buyHero0_Scale9Button.width = 200;
            buyHero0_Scale9Button.height = 70;
            this.addQuiackChild(buyHero0_Scale9Button);
            buyHero0_Scale9Button.name = 'buyHero0_Scale9Button';
            buyHero0_Scale9Button.text= '0';
            buyHero0_Scale9Button.fontColor= 0xffffff;
            buyHero0_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_zuanshi01_tubiao')
            diaIcon_0 = new Image(texture);
            diaIcon_0.x = 339;
            diaIcon_0.y = 401;
            diaIcon_0.width = 25;
            diaIcon_0.height = 26;
            this.addQuiackChild(diaIcon_0);
            diaIcon_0.touchable = false;
            texture = assetMgr.getTexture('ui_zuanshi01_tubiao')
            diaIcon_1 = new Image(texture);
            diaIcon_1.x = 597;
            diaIcon_1.y = 401;
            diaIcon_1.width = 25;
            diaIcon_1.height = 26;
            this.addQuiackChild(diaIcon_1);
            diaIcon_1.touchable = false;
            texture = assetMgr.getTexture('ui_zuanshi01_tubiao')
            diaIcon_2 = new Image(texture);
            diaIcon_2.x = 856;
            diaIcon_2.y = 401;
            diaIcon_2.width = 25;
            diaIcon_2.height = 26;
            this.addQuiackChild(diaIcon_2);
            diaIcon_2.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btn_Refresh.dispose();
            super.dispose();
        
}
    }
}
