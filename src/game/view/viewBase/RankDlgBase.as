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

    public class RankDlgBase extends TabDialog
    {
        public var ui_tanchukuangdi01_jiemian11914:Scale9Image;
        public var tab_1:TabButton;
        public var tab_2:TabButton;
        public var btn_close:Button;
        public var ui_zhuangshixianquan02_jiemian154456:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian154455:Scale9Image;
        public var list_pvp:List;
        public var list_rich:List;

        public function RankDlgBase()
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
            texture =assetMgr.getTexture('ui_taitoudi01_jiemian');
            image = new Image(texture);
            image.x = 180;
            image.y = 10;
            image.width = 720;
            image.height = 56;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhezhaoyinyingdi');
            image = new Image(texture);
            image.x = 149;
            image.y = 88;
            image.width = 796;
            image.height = 22;
            image.scaleY = -1;
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
            texture =assetMgr.getTexture('ui_paihangbang_taitou_wenzi');
            image = new Image(texture);
            image.x = 483;
            image.y = 20;
            image.width = 115;
            image.height = 37;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian154456Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian1544569ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian154456Rect);
            ui_zhuangshixianquan02_jiemian154456 = new Scale9Image(ui_zhuangshixianquan02_jiemian1544569ScaleTexture);
            ui_zhuangshixianquan02_jiemian154456.x = 154;
            ui_zhuangshixianquan02_jiemian154456.y = 456;
            ui_zhuangshixianquan02_jiemian154456.width = 772;
            ui_zhuangshixianquan02_jiemian154456.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian154456);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian154455Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian1544559ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian154455Rect);
            ui_zhuangshixianquan02_jiemian154455 = new Scale9Image(ui_zhuangshixianquan02_jiemian1544559ScaleTexture);
            ui_zhuangshixianquan02_jiemian154455.x = 154;
            ui_zhuangshixianquan02_jiemian154455.y = 455;
            ui_zhuangshixianquan02_jiemian154455.width = 772;
            ui_zhuangshixianquan02_jiemian154455.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian154455);
            texture =assetMgr.getTexture('ui_zhezhaoyinyingdi');
            image = new Image(texture);
            image.x = 149;
            image.y = 433;
            image.width = 796;
            image.height = 22;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            list_pvp = new List();
            list_pvp.x = 176;
            list_pvp.y = 91;
            list_pvp.width = 738;
            list_pvp.height = 342;
            this.addQuiackChild(list_pvp);
            list_rich = new List();
            list_rich.x = 176;
            list_rich.y = 91;
            list_rich.width = 738;
            list_rich.height = 342;
            this.addQuiackChild(list_rich);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            tab_1.dispose();
            tab_2.dispose();
            btn_close.dispose();
            list_pvp.dispose();
            list_rich.dispose();
            super.dispose();
        
}
    }
}
