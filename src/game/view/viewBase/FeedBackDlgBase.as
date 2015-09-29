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

    public class FeedBackDlgBase extends TabDialog
    {
        public var ui_tipstanchukuangdi01_jiemian1200:Scale9Image;
        public var submit_Scale9Button:Scale9Button;
        public var ui_zhuangshixianquan02_jiemian16275:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian162498:Scale9Image;
        public var infoTxt:TextField;
        public var closeBtn:Button;
        public var tips1:TextField;
        public var tips2:TextField;
        public var tab_1:TabButton;
        public var tab_2:TabButton;

        public function FeedBackDlgBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var ui_tipstanchukuangdi01_jiemian1200Rect:Rectangle = new Rectangle(48,46,44,43);
            var ui_tipstanchukuangdi01_jiemian12009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_tipstanchukuangdi01_jiemian1200Rect);
            ui_tipstanchukuangdi01_jiemian1200 = new Scale9Image(ui_tipstanchukuangdi01_jiemian12009ScaleTexture);
            ui_tipstanchukuangdi01_jiemian1200.x = 120;
            ui_tipstanchukuangdi01_jiemian1200.width = 856;
            ui_tipstanchukuangdi01_jiemian1200.height = 600;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian1200);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var submit_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            submit_Scale9Button = new Scale9Button(texture,submit_Scale9ButtonRect);
            submit_Scale9Button.x = 458;
            submit_Scale9Button.y = 501;
            submit_Scale9Button.width = 180;
            submit_Scale9Button.height = 70;
            this.addQuiackChild(submit_Scale9Button);
            submit_Scale9Button.name = 'submit_Scale9Button';
            submit_Scale9Button.text= 'lable';
            submit_Scale9Button.fontColor= 0xFFFFFF;
            submit_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian16275Rect:Rectangle = new Rectangle(3,0,3,2);
            var ui_zhuangshixianquan02_jiemian162759ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian16275Rect);
            ui_zhuangshixianquan02_jiemian16275 = new Scale9Image(ui_zhuangshixianquan02_jiemian162759ScaleTexture);
            ui_zhuangshixianquan02_jiemian16275.x = 162;
            ui_zhuangshixianquan02_jiemian16275.y = 75;
            ui_zhuangshixianquan02_jiemian16275.width = 772;
            ui_zhuangshixianquan02_jiemian16275.height = 3;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian16275);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian162498Rect:Rectangle = new Rectangle(3,0,3,2);
            var ui_zhuangshixianquan02_jiemian1624989ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian162498Rect);
            ui_zhuangshixianquan02_jiemian162498 = new Scale9Image(ui_zhuangshixianquan02_jiemian1624989ScaleTexture);
            ui_zhuangshixianquan02_jiemian162498.x = 162;
            ui_zhuangshixianquan02_jiemian162498.y = 498;
            ui_zhuangshixianquan02_jiemian162498.width = 772;
            ui_zhuangshixianquan02_jiemian162498.height = 3;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian162498);
            infoTxt = new TextField(720,316,'','',24,0xFFFFFF,false);
            infoTxt.touchable = false;
            infoTxt.hAlign= 'left';
            infoTxt.text= '';
            infoTxt.x = 188;
            infoTxt.y = 91;
            this.addQuiackChild(infoTxt);
            texture =assetMgr.getTexture('ui_yijianfankui_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 497;
            image.y = 38;
            image.width = 102;
            image.height = 30;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_guanbi01_anniu');
            closeBtn = new Button(texture);
            closeBtn.name= 'closeBtn';
            closeBtn.x = 884;
            closeBtn.width = 72;
            closeBtn.height = 76;
            this.addQuiackChild(closeBtn);
            tips1 = new TextField(772,50,'','',24,0xFFF6E3,false);
            tips1.touchable = false;
            tips1.hAlign= 'center';
            tips1.text= '';
            tips1.x = 162;
            tips1.y = 411;
            this.addQuiackChild(tips1);
            tips2 = new TextField(772,36,'','',24,0x00FF00,false);
            tips2.touchable = false;
            tips2.hAlign= 'center';
            tips2.text= '';
            tips2.x = 162;
            tips2.y = 465;
            this.addQuiackChild(tips2);
            tab_1 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_1.y = 101;
            tab_1.width = 173;
            tab_1.height = 86;
            this.addQuiackChild(tab_1);
            tab_1.text= 'lable';
            tab_1.fontColor= 0xFFFFFF;
            tab_1.fontSize= 24;
            tab_2 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_2.y = 179;
            tab_2.width = 173;
            tab_2.height = 86;
            this.addQuiackChild(tab_2);
            tab_2.text= 'lable';
            tab_2.fontColor= 0xFFFFFF;
            tab_2.fontSize= 24;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            closeBtn.dispose();
            tab_1.dispose();
            tab_2.dispose();
            super.dispose();
        
}
    }
}
