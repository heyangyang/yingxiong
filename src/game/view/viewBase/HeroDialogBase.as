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

    public class HeroDialogBase extends TabDialog
    {
        public var ui_tanchukuangdi01_jiemian11914:Scale9Image;
        public var tab_1:TabButton;
        public var tab_2:TabButton;
        public var tab_3:TabButton;
        public var btn_close:Button;
        public var ui_zhuangshixianquan02_jiemian161427:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian161428:Scale9Image;
        public var tab_4:TabButton;

        public function HeroDialogBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tanchukuangdi01_jiemian');
            var ui_tanchukuangdi01_jiemian11914Rect:Rectangle = new Rectangle(420,240,4,4);
            var ui_tanchukuangdi01_jiemian119149ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_tanchukuangdi01_jiemian11914Rect);
            ui_tanchukuangdi01_jiemian11914 = new Scale9Image(ui_tanchukuangdi01_jiemian119149ScaleTexture);
            ui_tanchukuangdi01_jiemian11914.x = 119;
            ui_tanchukuangdi01_jiemian11914.y = 14;
            ui_tanchukuangdi01_jiemian11914.width = 856;
            ui_tanchukuangdi01_jiemian11914.height = 580;
            this.addQuiackChild(ui_tanchukuangdi01_jiemian11914);
            tab_1 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_1.y = 82;
            tab_1.width = 173;
            tab_1.height = 86;
            this.addQuiackChild(tab_1);
            tab_1.text= 'lable';
            tab_1.fontColor= 0xFFFFFF;
            tab_1.fontSize= 28;
            tab_2 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_2.y = 158;
            tab_2.width = 173;
            tab_2.height = 86;
            this.addQuiackChild(tab_2);
            tab_2.text= 'lable';
            tab_2.fontColor= 0xFFFFFF;
            tab_2.fontSize= 28;
            tab_3 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_3.y = 231;
            tab_3.width = 173;
            tab_3.height = 86;
            this.addQuiackChild(tab_3);
            tab_3.text= 'lable';
            tab_3.fontColor= 0xFFFFFF;
            tab_3.fontSize= 28;
            texture =assetMgr.getTexture('ui_taitoudi01_jiemian');
            image = new Image(texture);
            image.x = 180;
            image.y = 10;
            image.width = 720;
            image.height = 56;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_guanbi01_anniu');
            btn_close = new Button(texture);
            btn_close.name= 'btn_close';
            btn_close.x = 866;
            btn_close.width = 72;
            btn_close.height = 76;
            this.addQuiackChild(btn_close);
            texture =assetMgr.getTexture('ui_mingzidi01');
            image = new Image(texture);
            image.x = 314;
            image.y = 20;
            image.width = 452;
            image.height = 37;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_xiangyoutishi01_anniu');
            image = new Image(texture);
            image.x = 892;
            image.y = 436;
            image.width = 68;
            image.height = 109;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_xiangzuotishi01_anniu');
            image = new Image(texture);
            image.x = 132;
            image.y = 436;
            image.width = 68;
            image.height = 109;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian161427Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian1614279ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian161427Rect);
            ui_zhuangshixianquan02_jiemian161427 = new Scale9Image(ui_zhuangshixianquan02_jiemian1614279ScaleTexture);
            ui_zhuangshixianquan02_jiemian161427.x = 161;
            ui_zhuangshixianquan02_jiemian161427.y = 427;
            ui_zhuangshixianquan02_jiemian161427.width = 772;
            ui_zhuangshixianquan02_jiemian161427.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian161427);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian161428Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian1614289ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian161428Rect);
            ui_zhuangshixianquan02_jiemian161428 = new Scale9Image(ui_zhuangshixianquan02_jiemian1614289ScaleTexture);
            ui_zhuangshixianquan02_jiemian161428.x = 161;
            ui_zhuangshixianquan02_jiemian161428.y = 428;
            ui_zhuangshixianquan02_jiemian161428.width = 772;
            ui_zhuangshixianquan02_jiemian161428.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian161428);
            tab_4 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_4.y = 302;
            tab_4.width = 173;
            tab_4.height = 86;
            this.addQuiackChild(tab_4);
            tab_4.text= 'lable';
            tab_4.fontColor= 0xFFFFFF;
            tab_4.fontSize= 28;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            tab_1.dispose();
            tab_2.dispose();
            tab_3.dispose();
            btn_close.dispose();
            tab_4.dispose();
            super.dispose();
        
}
    }
}
