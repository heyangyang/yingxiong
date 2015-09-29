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
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;
    import com.components.Scale9Button;

    public class DialogBackgroundBase extends Sprite
    {
        public var ui_dicengying02_jiemian00:Scale9Image;

        public function DialogBackgroundBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var ui_dicengying02_jiemian00Rect:Rectangle = new Rectangle(11,11,22,22);
            var ui_dicengying02_jiemian009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_dicengying02_jiemian00Rect);
            ui_dicengying02_jiemian00 = new Scale9Image(ui_dicengying02_jiemian009ScaleTexture);
            ui_dicengying02_jiemian00.width = 960;
            ui_dicengying02_jiemian00.height = 640;
            this.addQuiackChild(ui_dicengying02_jiemian00);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
