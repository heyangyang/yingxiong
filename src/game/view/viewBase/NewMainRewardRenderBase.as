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

    public class NewMainRewardRenderBase extends DefaultListItemRenderer
    {
        public var icon:Image;
        public var quality:Image;
        public var txt_name:TextField;

        public function NewMainRewardRenderBase()
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
            texture = assetMgr.getTexture('icon_1201')
            icon = new Image(texture);
            icon.x = 5;
            icon.y = 4;
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
            txt_name = new TextField(147,28,'','',18,0xFFFFFF,false);
            txt_name.touchable = false;
            txt_name.hAlign= 'center';
            txt_name.text= '';
            txt_name.x = -25;
            txt_name.y = 65;
            this.addQuiackChild(txt_name);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
