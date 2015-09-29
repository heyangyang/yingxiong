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

    public class SinglePhotoViewBase extends DefaultListItemRenderer
    {
        public var potoBg:Button;
        public var imagePh:Image;
        public var mask:Image;

        public function SinglePhotoViewBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_touxiangdi01_01');
            potoBg = new Button(texture);
            potoBg.name= 'potoBg';
            potoBg.width = 84;
            potoBg.height = 84;
            this.addQuiackChild(potoBg);
            texture = assetMgr.getTexture('photo_100')
            imagePh = new Image(texture);
            imagePh.x = 6;
            imagePh.y = 6;
            imagePh.width = 72;
            imagePh.height = 72;
            this.addQuiackChild(imagePh);
            imagePh.touchable = false;
            texture = assetMgr.getTexture('ui_touxiangdi01_02')
            mask = new Image(texture);
            mask.width = 84;
            mask.height = 84;
            this.addQuiackChild(mask);
            mask.touchable = false;
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            potoBg.dispose();
            super.dispose();
        
}
    }
}
