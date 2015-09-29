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

    public class PictureRenderBase extends DefaultListItemRenderer
    {
        public var txt_name:TextField;
        public var bg:Button;
        public var ico_hero:Image;

        public function PictureRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            txt_name = new TextField(164,27,'','',21,0xCC6600,false);
            txt_name.touchable = false;
            txt_name.hAlign= 'center';
            txt_name.text= '';
            txt_name.x = -32;
            txt_name.y = 103;
            this.addQuiackChild(txt_name);
            texture = assetMgr.getTexture('ui_daojukuangdi');
            bg = new Button(texture);
            bg.name= 'bg';
            bg.width = 98;
            bg.height = 98;
            this.addQuiackChild(bg);
            texture = assetMgr.getTexture('ui_touxiangkuang_01')
            ico_hero = new Image(texture);
            ico_hero.width = 100;
            ico_hero.height = 100;
            this.addQuiackChild(ico_hero);
            ico_hero.touchable = false;
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            bg.dispose();
            super.dispose();
        
}
    }
}
