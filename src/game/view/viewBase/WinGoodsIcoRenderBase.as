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

    public class WinGoodsIcoRenderBase extends DefaultListItemRenderer
    {
        public var icon:Image;
        public var icon_quality:Image;
        public var goodsName:TextField;

        public function WinGoodsIcoRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture =assetMgr.getTexture('ui_daojukuangdi');
            image = new Image(texture);
            image.width = 98;
            image.height = 98;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_button_mail')
            icon = new Image(texture);
            icon.x = 5;
            icon.y = 5;
            icon.width = 89;
            icon.height = 89;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            icon_quality = new Image(texture);
            icon_quality.width = 98;
            icon_quality.height = 98;
            this.addQuiackChild(icon_quality);
            icon_quality.touchable = false;
            goodsName = new TextField(98,32,'','',18,0xFFCC66,false);
            goodsName.touchable = false;
            goodsName.hAlign= 'center';
            goodsName.text= '';
            goodsName.x = 1;
            goodsName.y = 96;
            this.addQuiackChild(goodsName);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
