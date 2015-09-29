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

    public class BuyRenderBase extends DefaultListItemRenderer
    {
        public var bg:Button;
        public var icon:Image;
        public var quality:Image;

        public function BuyRenderBase()
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
            texture = assetMgr.getTexture('icon_3')
            icon = new Image(texture);
            icon.x = 1;
            icon.y = 4;
            icon.width = 94;
            icon.height = 90;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            quality = new Image(texture);
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            bg.dispose();
            super.dispose();
        
}
    }
}
