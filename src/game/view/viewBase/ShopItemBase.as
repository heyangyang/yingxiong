package game.view.viewBase {
    import com.components.Scale9Button;
    import com.utils.Constants;

    import flash.geom.Rectangle;

    import feathers.controls.TextInput;
    import feathers.controls.renderers.DefaultListItemRenderer;

    import game.manager.AssetMgr;

    import starling.display.Button;
    import starling.display.Image;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.AssetManager;

    public class ShopItemBase extends DefaultListItemRenderer {
        public var costValue:TextField;
        public var goodsName:TextField;
        public var buy_Scale9Button:Scale9Button;
        public var count:TextField;
        public var icon:Image;
        public var goods_quality:Image;

        public function ShopItemBase() {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_shangchengyeqian01_jiemian');
            image = new Image(texture);
            image.width = 242;
            image.height = 421;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            costValue = new TextField(101, 31, '', '', 24, 0xFFFFFF, false);
            costValue.touchable = false;
            costValue.hAlign = 'center';
            costValue.text = '';
            costValue.x = 81;
            costValue.y = 348;
            this.addQuiackChild(costValue);
            texture = assetMgr.getTexture('ui_zuanshi01_tubiao');
            image = new Image(texture);
            image.x = 54;
            image.y = 350;
            image.width = 25;
            image.height = 26;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            goodsName = new TextField(144, 33, '', '', 24, 0xFFFFFF, false);
            goodsName.touchable = false;
            goodsName.hAlign = 'center';
            goodsName.text = '';
            goodsName.x = 49;
            goodsName.y = 54;
            this.addQuiackChild(goodsName);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var buy_Scale9ButtonRect:Rectangle = new Rectangle(51, 0, 13, 62);
            buy_Scale9Button = new Scale9Button(texture, buy_Scale9ButtonRect);
            buy_Scale9Button.x = 28;
            buy_Scale9Button.y = 286;
            buy_Scale9Button.width = 186;
            buy_Scale9Button.height = 62;
            this.addQuiackChild(buy_Scale9Button);
            buy_Scale9Button.name = 'buy_Scale9Button';
            buy_Scale9Button.text = 'lable';
            buy_Scale9Button.fontColor = 0xFFFFFF;
            buy_Scale9Button.fontSize = 24;
            count = new TextField(163, 34, '', '', 26, 0xFFFFFF, false);
            count.touchable = false;
            count.hAlign = 'center';
            count.text = '';
            count.x = 38;
            count.y = 215;
            this.addQuiackChild(count);
            texture = assetMgr.getTexture('ui_daojukuangdi');
            image = new Image(texture);
            image.x = 72;
            image.y = 109;
            image.width = 98;
            image.height = 98;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('icon_1201')
            icon = new Image(texture);
            icon.x = 77;
            icon.y = 114;
            icon.width = 89;
            icon.height = 89;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            goods_quality = new Image(texture);
            goods_quality.x = 72;
            goods_quality.y = 109;
            goods_quality.width = 98;
            goods_quality.height = 98;
            this.addQuiackChild(goods_quality);
            goods_quality.touchable = false;
        }

        public function get assetMgr():AssetManager {
            return AssetMgr.instance;
        }
    }
}
