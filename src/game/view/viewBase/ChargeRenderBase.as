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
    import game.view.vip.ChargeRenderItem;
    import feathers.controls.renderers.DefaultListItemRenderer;

    public class ChargeRenderBase extends DefaultListItemRenderer
    {
        public var view:ChargeRenderItem;

        public function ChargeRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            view = new ChargeRenderItem();
            this.addQuiackChild(view);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            view.dispose();
            super.dispose();
        
}
    }
}
