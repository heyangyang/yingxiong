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

    public class WinHeroIcoRenderBase extends DefaultListItemRenderer
    {
        public var txt_exp:TextField;
        public var exp:Image;

        public function WinHeroIcoRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            txt_exp = new TextField(102,32,'','',20,0xFFCC66,false);
            txt_exp.touchable = false;
            txt_exp.hAlign= 'center';
            txt_exp.text= '';
            txt_exp.y = 122;
            this.addQuiackChild(txt_exp);
            texture =assetMgr.getTexture('ui_jingyan_01_jindutiao');
            image = new Image(texture);
            image.y = 100;
            image.width = 102;
            image.height = 21;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_jingyan_02_jindutiao')
            exp = new Image(texture);
            exp.y = 100;
            exp.width = 102;
            exp.height = 21;
            this.addQuiackChild(exp);
            exp.touchable = false;
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
