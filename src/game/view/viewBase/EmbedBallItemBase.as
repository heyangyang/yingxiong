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
    import game.base.CustomButton;

    public class EmbedBallItemBase extends CustomButton
    {
        public var txt:TextField;
        public var bg:Image;
        public var ad:Image;
        public var no:Image;

        public function EmbedBallItemBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            txt = new TextField(126,32,'','',21,0xffffff,false);
            txt.touchable = false;
            txt.hAlign= 'left';
            txt.text= '';
            txt.x = 52;
            txt.y = 11;
            this.addQuiackChild(txt);
            texture = assetMgr.getTexture('ui_xiangqiancaodi02_01')
            bg = new Image(texture);
            bg.width = 52;
            bg.height = 52;
            this.addQuiackChild(bg);
            bg.touchable = false;
            texture = assetMgr.getTexture('ui_zengjia02_anniu')
            ad = new Image(texture);
            ad.x = 5;
            ad.y = 5;
            ad.width = 42;
            ad.height = 42;
            this.addQuiackChild(ad);
            ad.touchable = false;
            texture = assetMgr.getTexture('ui_bukaifang')
            no = new Image(texture);
            no.x = 5;
            no.y = 5;
            no.width = 42;
            no.height = 42;
            this.addQuiackChild(no);
            no.touchable = false;
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
