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

    public class HeroExpGridRenderBase extends DefaultListItemRenderer
    {
        public var btn_bg:Button;
        public var icon:Image;
        public var quality:Image;
        public var txt_add:TextField;
        public var txt_count:TextField;

        public function HeroExpGridRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_daojukuangdi');
            btn_bg = new Button(texture);
            btn_bg.name= 'btn_bg';
            btn_bg.x = 1;
            btn_bg.y = 1;
            btn_bg.width = 96;
            btn_bg.height = 96;
            this.addQuiackChild(btn_bg);
            texture = assetMgr.getTexture('icon_20001')
            icon = new Image(texture);
            icon.x = 5;
            icon.y = 5;
            icon.width = 87;
            icon.height = 87;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            quality = new Image(texture);
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
            txt_add = new TextField(87,31,'','',21,0xCC0066,false);
            txt_add.touchable = false;
            txt_add.hAlign= 'left';
            txt_add.text= '';
            txt_add.x = 8;
            txt_add.y = 9;
            this.addQuiackChild(txt_add);
            txt_count = new TextField(85,31,'','',21,0xFF0000,false);
            txt_count.touchable = false;
            txt_count.hAlign= 'right';
            txt_count.text= '';
            txt_count.x = 3;
            txt_count.y = 63;
            this.addQuiackChild(txt_count);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btn_bg.dispose();
            super.dispose();
        
}
    }
}
