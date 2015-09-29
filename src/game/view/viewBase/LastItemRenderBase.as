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

    public class LastItemRenderBase extends Sprite
    {
        public var bgImage:Scale9Image;
        public var nameTxt:TextField;
        public var awardTxt:TextField;

        public function LastItemRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImageRect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.width = 504;
            bgImage.height = 30;
            this.addQuiackChild(bgImage);
            nameTxt = new TextField(200,28,'','',20,0xFFFFFF,false);
            nameTxt.touchable = false;
            nameTxt.hAlign= 'center';
            nameTxt.text= '';
            nameTxt.x = 1;
            this.addQuiackChild(nameTxt);
            awardTxt = new TextField(253,28,'','',20,0xFFFFFF,false);
            awardTxt.touchable = false;
            awardTxt.hAlign= 'center';
            awardTxt.text= '';
            awardTxt.x = 247;
            this.addQuiackChild(awardTxt);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
