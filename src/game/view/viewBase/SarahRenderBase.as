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

    public class SarahRenderBase extends DefaultListItemRenderer {
        public var btn_bg:Button;
        public var goodsValue:TextField;
        public var Chips:Image;
        public var Icon:Image;

        public function SarahRenderBase() {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_baozhuchouqu_01_anniu');
            btn_bg = new Button(texture);
            btn_bg.name = 'btn_bg';
            btn_bg.y = 4;
            btn_bg.width = 99;
            btn_bg.height = 112;
            this.addQuiackChild(btn_bg);
            goodsValue = new TextField(68, 31, '', '', 24, 0xFFFFFF, false);
            goodsValue.touchable = false;
            goodsValue.hAlign = 'center';
            goodsValue.text = '';
            goodsValue.x = 5;
            goodsValue.y = 81;
            this.addQuiackChild(goodsValue);
            texture = assetMgr.getTexture('ui_jinbi01_tubiao')
            Chips = new Image(texture);
            Chips.x = 68;
            Chips.y = 79;
            Chips.width = 25;
            Chips.height = 26;
            this.addQuiackChild(Chips);
            Chips.touchable = false;
            texture = assetMgr.getTexture('icon_1201')
            Icon = new Image(texture);
            Icon.x = 6;
            Icon.y = -4;
            Icon.width = 89;
            Icon.height = 89;
            this.addQuiackChild(Icon);
            Icon.touchable = false;
        }

        public function get assetMgr():AssetManager {
            return AssetMgr.instance;
        }

        override public function dispose():void {
            btn_bg.dispose();
            super.dispose();

        }
    }
}
