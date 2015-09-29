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

    public class BallRenderBase extends DefaultListItemRenderer
    {
        public var bgBut:Button;
        public var icon:Image;
        public var quality:Image;
        public var lv:TextField;

        public function BallRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_daojukuangdi');
            bgBut = new Button(texture);
            bgBut.name= 'bgBut';
            bgBut.width = 98;
            bgBut.height = 98;
            this.addQuiackChild(bgBut);
            texture = assetMgr.getTexture('icon_101001')
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
            lv = new TextField(75,28,'','',21,0xffffff,false);
            lv.touchable = false;
            lv.hAlign= 'left';
            lv.text= '';
            lv.x = 10;
            lv.y = 62;
            this.addQuiackChild(lv);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            bgBut.dispose();
            super.dispose();
        
}
    }
}
