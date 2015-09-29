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

    public class MapSelectButtonBase extends View
    {
        public var txt:TextField;

        public function MapSelectButtonBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshi');
            image = new Image(texture);
            image.x = 114;
            image.width = 53;
            image.height = 36;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 87;
            image.y = 7;
            image.width = 22;
            image.height = 22;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt = new TextField(68,27,'','',20,0x66FF00,false);
            txt.touchable = false;
            txt.hAlign= 'right';
            txt.text= '';
            txt.x = -4;
            txt.y = 5;
            this.addQuiackChild(txt);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
