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
    import feathers.controls.List;
    import com.view.View;

    public class ConvertViewBase extends View
    {
        public var txtfigthNum:TextField;
        public var list_hero:List;

        public function ConvertViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture =assetMgr.getTexture('ui_rongyuzhi_01_tubiao');
            image = new Image(texture);
            image.x = 742;
            image.y = 20;
            image.width = 27;
            image.height = 39;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txtfigthNum = new TextField(100,31,'','',24,0xFFFFFF,false);
            txtfigthNum.touchable = false;
            txtfigthNum.hAlign= 'center';
            txtfigthNum.text= '';
            txtfigthNum.x = 767;
            txtfigthNum.y = 24;
            this.addQuiackChild(txtfigthNum);
            list_hero = new List();
            list_hero.x = 192;
            list_hero.y = 100;
            list_hero.width = 710;
            list_hero.height = 427;
            this.addQuiackChild(list_hero);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            list_hero.dispose();
            super.dispose();
        
}
    }
}
