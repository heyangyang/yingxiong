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

    public class EquipContainerBase extends View
    {
        public var btnBg:Button;
        public var icon:Image;
        public var quality:Image;
        public var ad:Image;
        public var txt:TextField;

        public function EquipContainerBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_daojukuangdi');
            btnBg = new Button(texture);
            btnBg.name= 'btnBg';
            btnBg.width = 98;
            btnBg.height = 98;
            this.addQuiackChild(btnBg);
            texture = assetMgr.getTexture('icon_20001')
            icon = new Image(texture);
            icon.x = 5;
            icon.y = 5;
            icon.width = 89;
            icon.height = 89;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            quality = new Image(texture);
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
            texture = assetMgr.getTexture('ui_zengjia02_anniu')
            ad = new Image(texture);
            ad.x = 28;
            ad.y = 28;
            ad.width = 42;
            ad.height = 42;
            this.addQuiackChild(ad);
            ad.touchable = false;
            txt = new TextField(80,28,'','',21,0x00ff00,false);
            txt.touchable = false;
            txt.hAlign= 'right';
            txt.text= '';
            txt.x = 5;
            txt.y = 60;
            this.addQuiackChild(txt);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btnBg.dispose();
            super.dispose();
        
}
    }
}
