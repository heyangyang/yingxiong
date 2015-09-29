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
    import com.dialog.TabDialog;

    public class GamePhotoDlgBase extends TabDialog
    {
        public var ui_tipstanchukuangdi01_jiemian00:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian4273:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian42309:Scale9Image;
        public var txt_name:TextField;
        public var list_bag:List;

        public function GamePhotoDlgBase()
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
            ui_tipstanchukuangdi01_jiemian00.width = 614;
            ui_tipstanchukuangdi01_jiemian00.height = 392;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian00);
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
            image.x = 568;
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
            image.y = 347;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1.015869140625;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 568;
            image.y = 347;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1.015869140625;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian4273Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian42739ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian4273Rect);
            ui_zhuangshixianquan02_jiemian4273 = new Scale9Image(ui_zhuangshixianquan02_jiemian42739ScaleTexture);
            ui_zhuangshixianquan02_jiemian4273.x = 42;
            ui_zhuangshixianquan02_jiemian4273.y = 73;
            ui_zhuangshixianquan02_jiemian4273.width = 530;
            ui_zhuangshixianquan02_jiemian4273.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian4273);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian42309Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian423099ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian42309Rect);
            ui_zhuangshixianquan02_jiemian42309 = new Scale9Image(ui_zhuangshixianquan02_jiemian423099ScaleTexture);
            ui_zhuangshixianquan02_jiemian42309.x = 42;
            ui_zhuangshixianquan02_jiemian42309.y = 309;
            ui_zhuangshixianquan02_jiemian42309.width = 530;
            ui_zhuangshixianquan02_jiemian42309.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian42309);
            txt_name = new TextField(286,38,'','',28,0xFFFFFF,false);
            txt_name.touchable = false;
            txt_name.hAlign= 'center';
            txt_name.text= '';
            txt_name.x = 164;
            txt_name.y = 33;
            this.addQuiackChild(txt_name);
            list_bag = new List();
            list_bag.x = 43;
            list_bag.y = 95;
            list_bag.width = 529;
            list_bag.height = 191;
            this.addQuiackChild(list_bag);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 566;
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
            image.x = 50;
            image.y = 342;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 566;
            image.y = 342;
            image.width = 8;
            image.height = 33;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            list_bag.dispose();
            super.dispose();
        
}
    }
}
