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
    import feathers.controls.List;
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;
    import com.components.Scale9Button;
    import com.dialog.TabDialog;

    public class VipRewardDlgBase extends TabDialog {
        public var ui_tipstanchukuangdi01_jiemian00:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian42248:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian4275:Scale9Image;
        public var get_Scale9Button:Scale9Button;
        public var list_reward:List;

        public function VipRewardDlgBase() {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var ui_tipstanchukuangdi01_jiemian00Rect:Rectangle = new Rectangle(68, 64, 6, 6);
            var ui_tipstanchukuangdi01_jiemian009ScaleTexture:Scale9Textures = new Scale9Textures(texture, ui_tipstanchukuangdi01_jiemian00Rect);
            ui_tipstanchukuangdi01_jiemian00 = new Scale9Image(ui_tipstanchukuangdi01_jiemian009ScaleTexture);
            ui_tipstanchukuangdi01_jiemian00.width = 660;
            ui_tipstanchukuangdi01_jiemian00.height = 384;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian00);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian42248Rect:Rectangle = new Rectangle(3, 0, 3, 1);
            var ui_zhuangshixianquan02_jiemian422489ScaleTexture:Scale9Textures = new Scale9Textures(texture, ui_zhuangshixianquan02_jiemian42248Rect);
            ui_zhuangshixianquan02_jiemian42248 = new Scale9Image(ui_zhuangshixianquan02_jiemian422489ScaleTexture);
            ui_zhuangshixianquan02_jiemian42248.x = 42;
            ui_zhuangshixianquan02_jiemian42248.y = 248;
            ui_zhuangshixianquan02_jiemian42248.width = 576;
            ui_zhuangshixianquan02_jiemian42248.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian42248);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian4275Rect:Rectangle = new Rectangle(3, 0, 3, 1);
            var ui_zhuangshixianquan02_jiemian42759ScaleTexture:Scale9Textures = new Scale9Textures(texture, ui_zhuangshixianquan02_jiemian4275Rect);
            ui_zhuangshixianquan02_jiemian4275 = new Scale9Image(ui_zhuangshixianquan02_jiemian42759ScaleTexture);
            ui_zhuangshixianquan02_jiemian4275.x = 42;
            ui_zhuangshixianquan02_jiemian4275.y = 75;
            ui_zhuangshixianquan02_jiemian4275.width = 576;
            ui_zhuangshixianquan02_jiemian4275.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian4275);
            texture = assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 50;
            image.y = 41;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 615;
            image.y = 41;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 243;
            image.y = 74;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 419;
            image.y = 74;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_vipmeiridalibao_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 248;
            image.y = 44;
            image.width = 164;
            image.height = 31;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var get_Scale9ButtonRect:Rectangle = new Rectangle(56, 24, 4, 2);
            get_Scale9Button = new Scale9Button(texture, get_Scale9ButtonRect);
            get_Scale9Button.x = 237;
            get_Scale9Button.y = 268;
            get_Scale9Button.width = 186;
            get_Scale9Button.height = 70;
            this.addQuiackChild(get_Scale9Button);
            get_Scale9Button.name = 'get_Scale9Button';
            get_Scale9Button.text = 'lable';
            get_Scale9Button.fontColor = 0xFFFFFF;
            get_Scale9Button.fontSize = 24;
            list_reward = new List();
            list_reward.x = 53;
            list_reward.y = 94;
            list_reward.width = 554;
            list_reward.height = 135;
            this.addQuiackChild(list_reward);
            texture = assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 613;
            image.y = 46;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 52;
            image.y = 46;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            init();
        }

        public function get assetMgr():AssetManager {
            return AssetMgr.instance;
        }

        override public function dispose():void {
            list_reward.dispose();
            super.dispose();

        }
    }
}
