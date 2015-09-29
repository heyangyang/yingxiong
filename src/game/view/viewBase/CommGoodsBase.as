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
    import com.view.View;

    public class CommGoodsBase extends View
    {
        public var btn_bg:Button;
        public var txt:TextField;
        public var icon_type:Image;
        public var addGoods:Image;

        public function CommGoodsBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_dingbuxinxi_01_anniu');
            btn_bg = new Button(texture);
            btn_bg.name= 'btn_bg';
            btn_bg.width = 184;
            btn_bg.height = 56;
            this.addQuiackChild(btn_bg);
            txt = new TextField(106,38,'','',30,0xFFFFFF,false);
            txt.touchable = false;
            txt.hAlign= 'center';
            txt.text= '';
            txt.x = 33;
            txt.y = 9;
            this.addQuiackChild(txt);
            texture = assetMgr.getTexture('ui_jinbi01_tubiao')
            icon_type = new Image(texture);
            icon_type.x = 8;
            icon_type.y = 16;
            icon_type.width = 25;
            icon_type.height = 26;
            this.addQuiackChild(icon_type);
            icon_type.touchable = false;
            texture = assetMgr.getTexture('ui_zengjia01_anniu')
            addGoods = new Image(texture);
            addGoods.x = 141;
            addGoods.y = 10;
            addGoods.width = 36;
            addGoods.height = 36;
            this.addQuiackChild(addGoods);
            addGoods.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btn_bg.dispose();
            super.dispose();
        
}
    }
}
