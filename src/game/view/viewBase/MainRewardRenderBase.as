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

    public class MainRewardRenderBase extends DefaultListItemRenderer
    {
        public var but_bg:Button;
        public var icon:Image;
        public var quality:Image;
        public var txt_name:TextField;
        public var hun:Image;

        public function MainRewardRenderBase()
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
            icon = new Image(texture);
            icon.x = 3;
            icon.y = 4;
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
            txt_name = new TextField(150,28,'','',18,0xFFFFFF,false);
            txt_name.touchable = false;
            txt_name.hAlign= 'center';
            txt_name.text= '';
            txt_name.x = -26;
            txt_name.y = 64;
            this.addQuiackChild(txt_name);
            texture = assetMgr.getTexture('ui_yingxionghun_tubiao_02')
            hun = new Image(texture);
            hun.x = 58;
            hun.y = 11;
            hun.width = 30;
            hun.height = 30;
            this.addQuiackChild(hun);
            hun.touchable = false;
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            but_bg.dispose();
            super.dispose();
        
}
    }
}
