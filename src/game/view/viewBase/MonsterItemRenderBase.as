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

    public class MonsterItemRenderBase extends DefaultListItemRenderer
    {
        public var head:Image;
        public var headBtn2:Button;
        public var headBtn1:Button;

        public function MonsterItemRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture =assetMgr.getTexture('ui_touxiangdi02_01');
            image = new Image(texture);
            image.x = -1;
            image.y = -2;
            image.width = 86;
            image.height = 84;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('photo_101')
            head = new Image(texture);
            head.x = 11;
            head.y = 8;
            head.width = 67;
            head.height = 67;
            this.addQuiackChild(head);
            head.touchable = false;
            texture = assetMgr.getTexture('ui_touxiangdi02_03');
            headBtn2 = new Button(texture);
            headBtn2.name= 'headBtn2';
            headBtn2.width = 86;
            headBtn2.height = 84;
            this.addQuiackChild(headBtn2);
            texture = assetMgr.getTexture('ui_touxiangdi02_02');
            headBtn1 = new Button(texture);
            headBtn1.name= 'headBtn1';
            headBtn1.width = 86;
            headBtn1.height = 84;
            this.addQuiackChild(headBtn1);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            headBtn2.dispose();
            headBtn1.dispose();
            super.dispose();
        
}
    }
}
