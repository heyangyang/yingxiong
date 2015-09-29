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
    import com.view.View;

    public class JTUIMessageNoticeBase extends View
    {
        public var bgImage:Scale9Image;
        public var txt_noticeTxt:TextField;

        public function JTUIMessageNoticeBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImageRect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.width = 960;
            bgImage.height = 45;
            this.addQuiackChild(bgImage);
            txt_noticeTxt = new TextField(960,45,'','',32,0xFFFFCC,false);
            txt_noticeTxt.touchable = false;
            txt_noticeTxt.hAlign= 'left';
            txt_noticeTxt.text= '';
            this.addQuiackChild(txt_noticeTxt);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
