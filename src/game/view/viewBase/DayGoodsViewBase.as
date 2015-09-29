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
    import feathers.controls.renderers.DefaultListItemRenderer;

    public class DayGoodsViewBase extends DefaultListItemRenderer
    {
        public var bg:Button;
        public var icon:Image;
        public var quality:Image;
        public var gou:Image;
        public var goods_name:TextField;
        public var goods_num:TextField;

        public function DayGoodsViewBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_daojukuangdi');
            bg = new Button(texture);
            bg.name= 'bg';
            bg.width = 98;
            bg.height = 98;
            this.addQuiackChild(bg);
            texture = assetMgr.getTexture('icon_1208')
            icon = new Image(texture);
            icon.x = 5;
            icon.y = 5;
            icon.width = 89;
            icon.height = 89;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            quality = new Image(texture);
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
            texture = assetMgr.getTexture('ui_kexuanzhuangtai')
            gou = new Image(texture);
            gou.x = 10;
            gou.y = 15;
            gou.width = 76;
            gou.height = 67;
            this.addQuiackChild(gou);
            gou.touchable = false;
            goods_name = new TextField(116,26,'','',18,0x00FF00,false);
            goods_name.touchable = false;
            goods_name.hAlign= 'center';
            goods_name.text= '';
            goods_name.x = -11;
            goods_name.y = 98;
            this.addQuiackChild(goods_name);
            goods_num = new TextField(92,32,'','',20,0xFFFFFF,false);
            goods_num.touchable = false;
            goods_num.hAlign= 'center';
            goods_num.text= '';
            goods_num.x = 3;
            goods_num.y = 60;
            this.addQuiackChild(goods_num);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            bg.dispose();
            super.dispose();
        
}
    }
}
