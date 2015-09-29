package game.view.viewBase {
    import starling.display.Image;
    import game.manager.AssetMgr;
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
    import feathers.controls.renderers.DefaultListItemRenderer;

    public class NewLostRenderBase extends DefaultListItemRenderer {
        public var bg:Scale9Image;
        public var txt_des:TextField;
        public var btn_ok:Button;
        public var icon:Image;
        public var quality:Image;
        public var txt_level:TextField;

        public function NewLostRenderBase() {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            var assetMgr:AssetMgr = AssetMgr.instance;
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var bgRect:Rectangle = new Rectangle(18, 18, 35, 35);
            var bg9ScaleTexture:Scale9Textures = new Scale9Textures(texture, bgRect);
            bg = new Scale9Image(bg9ScaleTexture);
            bg.width = 662;
            bg.height = 156;
            this.addQuiackChild(bg);
            txt_des = new TextField(349, 104, '', '', 25, 0xFFFFFF, false);
            txt_des.touchable = false;
            txt_des.hAlign = 'left';
            txt_des.text = '';
            txt_des.x = 150;
            txt_des.y = 28;
            this.addQuiackChild(txt_des);
            texture = assetMgr.getTexture('ui_daojukuangdi');
            image = new Image(texture);
            image.x = 38;
            image.y = 28;
            image.width = 98;
            image.height = 98;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            btn_ok = new Button(texture);
            btn_ok.name = 'btn_ok';
            btn_ok.x = 506;
            btn_ok.y = 49;
            btn_ok.width = 116;
            btn_ok.height = 62;
            this.addQuiackChild(btn_ok);
            btn_ok.text = 'lable';
            btn_ok.fontColor = 0xFFCC66;
            btn_ok.fontSize = 21;
            texture = assetMgr.getTexture('icon_201002')
            icon = new Image(texture);
            icon.x = 41;
            icon.y = 31;
            icon.width = 89;
            icon.height = 89;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang07')
            quality = new Image(texture);
            quality.x = 38;
            quality.y = 28;
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
            txt_level = new TextField(61, 36, '', '', 24, 0xFFCC66, false);
            txt_level.touchable = false;
            txt_level.hAlign = 'right';
            txt_level.text = '+15';
            txt_level.x = 64;
            txt_level.y = 84;
            this.addQuiackChild(txt_level);
        }

        override public function dispose():void {
            btn_ok.dispose();
            super.dispose();

        }
    }
}
