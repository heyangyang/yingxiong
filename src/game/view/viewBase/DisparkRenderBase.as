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
    import com.view.View;

    public class DisparkRenderBase extends View
    {
        public var txtContent:TextField;
        public var newBtn:Image;

        public function DisparkRenderBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            txtContent = new TextField(330,28,'','',22,0xFFFFFF,false);
            txtContent.touchable = false;
            txtContent.hAlign= 'left';
            txtContent.text= '';
            txtContent.x = 57;
            txtContent.y = 12;
            this.addQuiackChild(txtContent);
            texture = assetMgr.getTexture('ui_renwu_new1')
            newBtn = new Image(texture);
            newBtn.width = 52;
            newBtn.height = 52;
            this.addQuiackChild(newBtn);
            newBtn.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
