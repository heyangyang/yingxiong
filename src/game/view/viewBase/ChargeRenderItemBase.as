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
    import game.base.CustomButton;

    public class ChargeRenderItemBase extends CustomButton
    {
        public var ui_danxiangkuangdi00:Scale9Image;
        public var container:Image;
        public var bgImage:Scale9Image;
        public var dValue:TextField;
        public var cost:TextField;

        public function ChargeRenderItemBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var ui_danxiangkuangdi00Rect:Rectangle = new Rectangle(18,32,34,2);
            var ui_danxiangkuangdi009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_danxiangkuangdi00Rect);
            ui_danxiangkuangdi00 = new Scale9Image(ui_danxiangkuangdi009ScaleTexture);
            ui_danxiangkuangdi00.width = 284;
            ui_danxiangkuangdi00.height = 109;
            this.addQuiackChild(ui_danxiangkuangdi00);
            texture = assetMgr.getTexture('ui_daojukuangdi')
            container = new Image(texture);
            container.x = 6;
            container.y = 6;
            container.width = 99;
            container.height = 98;
            this.addQuiackChild(container);
            container.touchable = false;
            texture =assetMgr.getTexture('ui_daojukuang01');
            image = new Image(texture);
            image.x = 6;
            image.y = 6;
            image.width = 99;
            image.height = 98;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImageRect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.x = 102;
            bgImage.y = 9;
            bgImage.width = 177;
            bgImage.height = 48;
            this.addQuiackChild(bgImage);
            dValue = new TextField(172,40,'','',32,0xFFFFFF,false);
            dValue.touchable = false;
            dValue.hAlign= 'center';
            dValue.text= '';
            dValue.x = 105;
            dValue.y = 13;
            this.addQuiackChild(dValue);
            cost = new TextField(172,45,'','',30,0x3333FF,false);
            cost.touchable = false;
            cost.hAlign= 'center';
            cost.text= '';
            cost.x = 105;
            cost.y = 60;
            this.addQuiackChild(cost);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
