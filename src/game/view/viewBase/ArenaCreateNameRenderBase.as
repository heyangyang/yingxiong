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

    public class ArenaCreateNameRenderBase extends DefaultListItemRenderer
    {
        public var ico_hero:Button;
        public var head:Image;
        public var mask:Image;

        public function ArenaCreateNameRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_touxiangdi01_01');
            ico_hero = new Button(texture);
            ico_hero.name= 'ico_hero';
            ico_hero.width = 84;
            ico_hero.height = 84;
            this.addQuiackChild(ico_hero);
            texture = assetMgr.getTexture('photo_100')
            head = new Image(texture);
            head.x = 6;
            head.y = 6;
            head.width = 72;
            head.height = 72;
            this.addQuiackChild(head);
            head.touchable = false;
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
            ico_hero.dispose();
            super.dispose();
        
}
    }
}
