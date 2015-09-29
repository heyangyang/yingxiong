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

    public class MercenaryIconBase extends DefaultListItemRenderer
    {
        public var but_bg:Button;
        public var imageIcon:Image;
        public var qualitybg:Image;
        public var lockImage:Image;
        public var txt_3:TextField;
        public var txt_2:TextField;
        public var txt_1:TextField;

        public function MercenaryIconBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_daojukuangdi');
            but_bg = new Button(texture);
            but_bg.name= 'but_bg';
            but_bg.width = 98;
            but_bg.height = 98;
            this.addQuiackChild(but_bg);
            texture = assetMgr.getTexture('photo_525')
            imageIcon = new Image(texture);
            imageIcon.y = 2;
            imageIcon.width = 96;
            imageIcon.height = 96;
            this.addQuiackChild(imageIcon);
            imageIcon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            qualitybg = new Image(texture);
            qualitybg.width = 98;
            qualitybg.height = 98;
            this.addQuiackChild(qualitybg);
            qualitybg.touchable = false;
            texture = assetMgr.getTexture('ui_world_nandusuo')
            lockImage = new Image(texture);
            lockImage.x = 21;
            lockImage.y = 18;
            lockImage.width = 59;
            lockImage.height = 67;
            this.addQuiackChild(lockImage);
            lockImage.touchable = false;
            txt_3 = new TextField(98,26,'','',20,0xff0000,false);
            txt_3.touchable = false;
            txt_3.hAlign= 'center';
            txt_3.text= '解锁';
            txt_3.y = 66;
            this.addQuiackChild(txt_3);
            txt_2 = new TextField(100,26,'','',20,0x00ff00,false);
            txt_2.touchable = false;
            txt_2.hAlign= 'center';
            txt_2.text= '已购买';
            txt_2.y = 8;
            this.addQuiackChild(txt_2);
            txt_1 = new TextField(98,26,'','',20,0xff0000,false);
            txt_1.touchable = false;
            txt_1.hAlign= 'center';
            txt_1.text= '101关';
            txt_1.y = 8;
            this.addQuiackChild(txt_1);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            but_bg.dispose();
            super.dispose();
        
}
    }
}
