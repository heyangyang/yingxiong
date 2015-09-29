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

    public class StoneRenderBase extends DefaultListItemRenderer
    {
        public var btn_bg:Button;
        public var icon:Image;
        public var quality:Image;
        public var count:TextField;

        public function StoneRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_daojukuangdi');
            btn_bg = new Button(texture);
            btn_bg.name= 'btn_bg';
            btn_bg.width = 98;
            btn_bg.height = 98;
            this.addQuiackChild(btn_bg);
            texture = assetMgr.getTexture('icon_101001')
            icon = new Image(texture);
            icon.x = 5;
            icon.y = 3;
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
            count = new TextField(75,28,'','',21,0xffffff,false);
            count.touchable = false;
            count.hAlign= 'right';
            count.text= '';
            count.x = 10;
            count.y = 62;
            this.addQuiackChild(count);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btn_bg.dispose();
            super.dispose();
        
}
    }
}
