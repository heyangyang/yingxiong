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
    import feathers.controls.renderers.DefaultListItemRenderer;

    public class SweepResultsViewBase extends DefaultListItemRenderer
    {
        public var ui_zhuangshixianquan01_jiemian00:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian676:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian675:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian639:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian638:Scale9Image;
        public var text_chip:TextField;
        public var text_Round:TextField;
        public var list_goods:List;

        public function SweepResultsViewBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian00Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian00Rect);
            ui_zhuangshixianquan01_jiemian00 = new Scale9Image(ui_zhuangshixianquan01_jiemian009ScaleTexture);
            ui_zhuangshixianquan01_jiemian00.width = 512;
            ui_zhuangshixianquan01_jiemian00.height = 206;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian00);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian676Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian6769ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian676Rect);
            ui_zhuangshixianquan02_jiemian676 = new Scale9Image(ui_zhuangshixianquan02_jiemian6769ScaleTexture);
            ui_zhuangshixianquan02_jiemian676.x = 6;
            ui_zhuangshixianquan02_jiemian676.y = 76;
            ui_zhuangshixianquan02_jiemian676.width = 500;
            ui_zhuangshixianquan02_jiemian676.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian676);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian675Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian6759ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian675Rect);
            ui_zhuangshixianquan02_jiemian675 = new Scale9Image(ui_zhuangshixianquan02_jiemian6759ScaleTexture);
            ui_zhuangshixianquan02_jiemian675.x = 6;
            ui_zhuangshixianquan02_jiemian675.y = 75;
            ui_zhuangshixianquan02_jiemian675.width = 500;
            ui_zhuangshixianquan02_jiemian675.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian675);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian639Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian6399ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian639Rect);
            ui_zhuangshixianquan02_jiemian639 = new Scale9Image(ui_zhuangshixianquan02_jiemian6399ScaleTexture);
            ui_zhuangshixianquan02_jiemian639.x = 6;
            ui_zhuangshixianquan02_jiemian639.y = 39;
            ui_zhuangshixianquan02_jiemian639.width = 500;
            ui_zhuangshixianquan02_jiemian639.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian639);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian638Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian6389ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian638Rect);
            ui_zhuangshixianquan02_jiemian638 = new Scale9Image(ui_zhuangshixianquan02_jiemian6389ScaleTexture);
            ui_zhuangshixianquan02_jiemian638.x = 6;
            ui_zhuangshixianquan02_jiemian638.y = 38;
            ui_zhuangshixianquan02_jiemian638.width = 500;
            ui_zhuangshixianquan02_jiemian638.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian638);
            texture =assetMgr.getTexture('ui_jinbi01_tubiao');
            image = new Image(texture);
            image.x = 200;
            image.y = 44;
            image.width = 25;
            image.height = 26;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            text_chip = new TextField(119,31,'','',24,0xFFCC00,false);
            text_chip.touchable = false;
            text_chip.hAlign= 'center';
            text_chip.text= '';
            text_chip.x = 229;
            text_chip.y = 42;
            this.addQuiackChild(text_chip);
            text_Round = new TextField(324,32,'','',24,0xFFFFFF,false);
            text_Round.touchable = false;
            text_Round.hAlign= 'center';
            text_Round.text= '第1战';
            text_Round.x = 94;
            text_Round.y = 4;
            this.addQuiackChild(text_Round);
            list_goods = new List();
            list_goods.x = 6;
            list_goods.y = 87;
            list_goods.width = 500;
            list_goods.height = 104;
            this.addQuiackChild(list_goods);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            list_goods.dispose();
            super.dispose();
        
}
    }
}
