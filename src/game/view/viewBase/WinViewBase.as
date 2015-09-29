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
    import feathers.controls.List;
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;
    import com.components.Scale9Button;
    import com.dialog.Dialog;

    public class WinViewBase extends Dialog
    {
        public var bgImage:Scale9Image;
        public var list_goods:List;
        public var ui_zhuangshixianquan02_jiemian270100:Scale9Image;
        public var txt_gold:TextField;
        public var return_Scale9Button:Scale9Button;
        public var replay_Scale9Button:Scale9Button;
        public var goods_icon:Image;
        public var coin_icon:Image;
        public var ui_zhuangshixianquan02_jiemian270339:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian270463:Scale9Image;
        public var list_hero:List;

        public function WinViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_zhuangshixianquan04_jiemian');
            var bgImageRect:Rectangle = new Rectangle(40,40,50,50);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.x = 279;
            bgImage.y = 141;
            bgImage.width = 660;
            bgImage.height = 187;
            this.addQuiackChild(bgImage);
            list_goods = new List();
            list_goods.x = 378;
            list_goods.y = 353;
            list_goods.width = 467;
            list_goods.height = 98;
            this.addQuiackChild(list_goods);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian270100Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian2701009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian270100Rect);
            ui_zhuangshixianquan02_jiemian270100 = new Scale9Image(ui_zhuangshixianquan02_jiemian2701009ScaleTexture);
            ui_zhuangshixianquan02_jiemian270100.x = 270;
            ui_zhuangshixianquan02_jiemian270100.y = 100;
            ui_zhuangshixianquan02_jiemian270100.width = 682;
            ui_zhuangshixianquan02_jiemian270100.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian270100);
            txt_gold = new TextField(167,35,'','',28,0xFFFFFF,false);
            txt_gold.touchable = false;
            txt_gold.hAlign= 'center';
            txt_gold.text= '';
            txt_gold.x = 577;
            txt_gold.y = 104;
            this.addQuiackChild(txt_gold);
            texture = assetMgr.getTexture('ui_lan03_01_anniu');
            var return_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            return_Scale9Button = new Scale9Button(texture,return_Scale9ButtonRect);
            return_Scale9Button.x = 636;
            return_Scale9Button.y = 496;
            return_Scale9Button.width = 186;
            return_Scale9Button.height = 70;
            this.addQuiackChild(return_Scale9Button);
            return_Scale9Button.name = 'return_Scale9Button';
            return_Scale9Button.text= 'lable';
            return_Scale9Button.fontColor= 0xFFFFC9;
            return_Scale9Button.fontSize= 28;
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var replay_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            replay_Scale9Button = new Scale9Button(texture,replay_Scale9ButtonRect);
            replay_Scale9Button.x = 398;
            replay_Scale9Button.y = 496;
            replay_Scale9Button.width = 186;
            replay_Scale9Button.height = 70;
            this.addQuiackChild(replay_Scale9Button);
            replay_Scale9Button.name = 'replay_Scale9Button';
            replay_Scale9Button.text= 'lable';
            replay_Scale9Button.fontColor= 0xFFFFC9;
            replay_Scale9Button.fontSize= 28;
            texture = assetMgr.getTexture('ui_rongyuzhi_01_tubiao')
            goods_icon = new Image(texture);
            goods_icon.x = 544;
            goods_icon.y = 103;
            goods_icon.width = 27;
            goods_icon.height = 39;
            this.addQuiackChild(goods_icon);
            goods_icon.touchable = false;
            texture = assetMgr.getTexture('ui_jinbi01_tubiao')
            coin_icon = new Image(texture);
            coin_icon.x = 545;
            coin_icon.y = 110;
            coin_icon.width = 25;
            coin_icon.height = 26;
            this.addQuiackChild(coin_icon);
            coin_icon.touchable = false;
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian270339Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian2703399ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian270339Rect);
            ui_zhuangshixianquan02_jiemian270339 = new Scale9Image(ui_zhuangshixianquan02_jiemian2703399ScaleTexture);
            ui_zhuangshixianquan02_jiemian270339.x = 270;
            ui_zhuangshixianquan02_jiemian270339.y = 339;
            ui_zhuangshixianquan02_jiemian270339.width = 682;
            ui_zhuangshixianquan02_jiemian270339.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian270339);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian270463Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian2704639ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian270463Rect);
            ui_zhuangshixianquan02_jiemian270463 = new Scale9Image(ui_zhuangshixianquan02_jiemian2704639ScaleTexture);
            ui_zhuangshixianquan02_jiemian270463.x = 270;
            ui_zhuangshixianquan02_jiemian270463.y = 463;
            ui_zhuangshixianquan02_jiemian270463.width = 682;
            ui_zhuangshixianquan02_jiemian270463.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian270463);
            list_hero = new List();
            list_hero.x = 309;
            list_hero.y = 150;
            list_hero.width = 600;
            list_hero.height = 170;
            this.addQuiackChild(list_hero);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            list_goods.dispose();
            list_hero.dispose();
            super.dispose();
        
}
    }
}
