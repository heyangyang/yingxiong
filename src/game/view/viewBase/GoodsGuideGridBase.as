package game.view.viewBase {
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

    public class GoodsGuideGridBase extends DefaultListItemRenderer {
        public var but_bg:Button;
        public var ico_equip:Image;
        public var ico_quality:Image;
        public var hun:Image;
        public var txt_name:TextField;
        public var txt_level:TextField;

        public function GoodsGuideGridBase() {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_daojukuangdi');
            but_bg = new Button(texture);
            but_bg.name = 'but_bg';
            but_bg.width = 98;
            but_bg.height = 99;
            this.addQuiackChild(but_bg);
            texture = assetMgr.getTexture('icon_300010')
            ico_equip = new Image(texture);
            ico_equip.x = 3;
            ico_equip.y = 4;
            ico_equip.width = 90;
            ico_equip.height = 90;
            this.addQuiackChild(ico_equip);
            ico_equip.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            ico_quality = new Image(texture);
            ico_quality.width = 98;
            ico_quality.height = 99;
            this.addQuiackChild(ico_quality);
            ico_quality.touchable = false;
            texture = assetMgr.getTexture('ui_yingxionghun_tubiao_02')
            hun = new Image(texture);
            hun.x = 57;
            hun.y = 10;
            hun.width = 30;
            hun.height = 30;
            this.addQuiackChild(hun);
            hun.touchable = false;
            txt_name = new TextField(164, 32, '', '', 21, 0xFFFFFF, false);
            txt_name.touchable = false;
            txt_name.hAlign = 'center';
            txt_name.text = '';
            txt_name.x = -33;
            txt_name.y = 99;
            this.addQuiackChild(txt_name);
            txt_level = new TextField(98, 31, '', '', 20, 0xFFFFFF, false);
            txt_level.touchable = false;
            txt_level.hAlign = 'center';
            txt_level.text = '';
            txt_level.y = 7;
            this.addQuiackChild(txt_level);
        }

        public function get assetMgr():AssetManager {
            return AssetMgr.instance;
        }

        override public function dispose():void {
            but_bg.dispose();
            super.dispose();

        }
    }
}
