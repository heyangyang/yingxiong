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

    public class MagicRenderBase extends DefaultListItemRenderer
    {
        public var but_bg:Button;
        public var _picture:Image;
        public var _quality:Image;
        public var _selectedImage:Image;
        public var txt_Lv:TextField;

        public function MagicRenderBase()
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
            texture = assetMgr.getTexture('icon_1201')
            _picture = new Image(texture);
            _picture.x = 5;
            _picture.y = 4;
            _picture.width = 89;
            _picture.height = 89;
            this.addQuiackChild(_picture);
            _picture.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            _quality = new Image(texture);
            _quality.width = 98;
            _quality.height = 98;
            this.addQuiackChild(_quality);
            _quality.touchable = false;
            texture = assetMgr.getTexture('ui_kexuanzhuangtai2')
            _selectedImage = new Image(texture);
            _selectedImage.x = 10;
            _selectedImage.y = 17;
            _selectedImage.width = 76;
            _selectedImage.height = 67;
            this.addQuiackChild(_selectedImage);
            _selectedImage.touchable = false;
            txt_Lv = new TextField(75,29,'','',24,0xFFFFFF,false);
            txt_Lv.touchable = false;
            txt_Lv.hAlign= 'left';
            txt_Lv.text= '';
            txt_Lv.x = 10;
            txt_Lv.y = 62;
            this.addQuiackChild(txt_Lv);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            but_bg.dispose();
            super.dispose();
        
}
    }
}
