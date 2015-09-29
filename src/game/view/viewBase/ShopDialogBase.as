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
    import feathers.controls.List;
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;
    import com.components.Scale9Button;
    import com.dialog.TabDialog;

    public class ShopDialogBase extends TabDialog
    {
        public var ui_tanchukuangdi01_jiemian11914:Scale9Image;
        public var tab_1:TabButton;
        public var tab_2:TabButton;
        public var btn_close:Button;
        public var tab_3:TabButton;
        public var list_shop:List;
        public var changeScale9Button:Scale9Button;

        public function ShopDialogBase()
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
            texture =assetMgr.getTexture('ui_taitoudi01_jiemian');
            image = new Image(texture);
            image.x = 187;
            image.y = 10;
            image.width = 720;
            image.height = 56;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            tab_1 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_1.y = 82;
            tab_1.width = 173;
            tab_1.height = 86;
            this.addQuiackChild(tab_1);
            tab_1.text= 'lable';
            tab_1.fontColor= 0xFFFFFF;
            tab_1.fontSize= 28;
            tab_2 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_2.y = 155;
            tab_2.width = 173;
            tab_2.height = 86;
            this.addQuiackChild(tab_2);
            tab_2.text= 'lable';
            tab_2.fontColor= 0xFFFFFF;
            tab_2.fontSize= 28;
            texture =assetMgr.getTexture('ui_mingzidi01');
            image = new Image(texture);
            image.x = 321;
            image.y = 20;
            image.width = 452;
            image.height = 37;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_guanbi01_anniu');
            btn_close = new Button(texture);
            btn_close.name= 'btn_close';
            btn_close.x = 873;
            btn_close.width = 72;
            btn_close.height = 76;
            this.addQuiackChild(btn_close);
            tab_3 = new TabButton(assetMgr.getTexture('ui_TAB02_anniu'),assetMgr.getTexture('ui_TAB01_anniu'));
            tab_3.y = 229;
            tab_3.width = 173;
            tab_3.height = 86;
            this.addQuiackChild(tab_3);
            tab_3.text= 'lable';
            tab_3.fontColor= 0xFFFFFF;
            tab_3.fontSize= 28;
            texture =assetMgr.getTexture('ui_shangdian_taitou_wenzi');
            image = new Image(texture);
            image.x = 490;
            image.y = 20;
            image.width = 115;
            image.height = 37;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            list_shop = new List();
            list_shop.x = 174;
            list_shop.y = 96;
            list_shop.width = 746;
            list_shop.height = 421;
            this.addQuiackChild(list_shop);
            texture = assetMgr.getTexture('ui_hong02_01_anniu');
            var changeScale9ButtonRect:Rectangle = new Rectangle(46,0,4,38);
            changeScale9Button = new Scale9Button(texture,changeScale9ButtonRect);
            changeScale9Button.x = 215;
            changeScale9Button.y = 18;
            changeScale9Button.width = 152;
            changeScale9Button.height = 39;
            this.addQuiackChild(changeScale9Button);
            changeScale9Button.name = 'changeScale9Button';
            changeScale9Button.text= 'lable';
            changeScale9Button.fontColor= 0xFFFFFFB4;
            changeScale9Button.fontSize= 24;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            tab_1.dispose();
            tab_2.dispose();
            btn_close.dispose();
            tab_3.dispose();
            list_shop.dispose();
            super.dispose();
        
}
    }
}