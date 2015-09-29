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
    import com.dialog.Dialog;

    public class AlipayAndroidBase extends Dialog
    {
        public var alipay:Button;
        public var yinlian:Button;

        public function AlipayAndroidBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture =assetMgr.getTexture('ui_dimian');
            image = new Image(texture);
            image.width = 584;
            image.height = 290;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('zhifubao');
            alipay = new Button(texture);
            alipay.name= 'alipay';
            alipay.x = 338;
            alipay.y = 101;
            alipay.width = 100;
            alipay.height = 100;
            this.addQuiackChild(alipay);
            texture = assetMgr.getTexture('yinlian');
            yinlian = new Button(texture);
            yinlian.name= 'yinlian';
            yinlian.x = 132;
            yinlian.y = 101;
            yinlian.width = 100;
            yinlian.height = 100;
            this.addQuiackChild(yinlian);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            alipay.dispose();
            yinlian.dispose();
            super.dispose();
        
}
    }
}
