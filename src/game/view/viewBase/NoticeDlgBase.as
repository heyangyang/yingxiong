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
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;
    import com.components.Scale9Button;
    import com.dialog.Dialog;

    public class NoticeDlgBase extends Dialog
    {
        public var ui_tipstanchukuangdi01_jiemian00:Scale9Image;
        public var close_Scale9Button:Scale9Button;
        public var ui_zhuangshixianquan02_jiemian4275:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian42498:Scale9Image;
        public var infoTxt:TextField;

        public function NoticeDlgBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var ui_tipstanchukuangdi01_jiemian00Rect:Rectangle = new Rectangle(48,46,44,43);
            var ui_tipstanchukuangdi01_jiemian009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_tipstanchukuangdi01_jiemian00Rect);
            ui_tipstanchukuangdi01_jiemian00 = new Scale9Image(ui_tipstanchukuangdi01_jiemian009ScaleTexture);
            ui_tipstanchukuangdi01_jiemian00.width = 856;
            ui_tipstanchukuangdi01_jiemian00.height = 600;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian00);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var close_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            close_Scale9Button = new Scale9Button(texture,close_Scale9ButtonRect);
            close_Scale9Button.x = 338;
            close_Scale9Button.y = 501;
            close_Scale9Button.width = 180;
            close_Scale9Button.height = 70;
            this.addQuiackChild(close_Scale9Button);
            close_Scale9Button.name = 'close_Scale9Button';
            close_Scale9Button.text= 'lable';
            close_Scale9Button.fontColor= 0xFFFFFF;
            close_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian4275Rect:Rectangle = new Rectangle(3,0,3,2);
            var ui_zhuangshixianquan02_jiemian42759ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian4275Rect);
            ui_zhuangshixianquan02_jiemian4275 = new Scale9Image(ui_zhuangshixianquan02_jiemian42759ScaleTexture);
            ui_zhuangshixianquan02_jiemian4275.x = 42;
            ui_zhuangshixianquan02_jiemian4275.y = 75;
            ui_zhuangshixianquan02_jiemian4275.width = 772;
            ui_zhuangshixianquan02_jiemian4275.height = 3;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian4275);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian42498Rect:Rectangle = new Rectangle(3,0,3,2);
            var ui_zhuangshixianquan02_jiemian424989ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian42498Rect);
            ui_zhuangshixianquan02_jiemian42498 = new Scale9Image(ui_zhuangshixianquan02_jiemian424989ScaleTexture);
            ui_zhuangshixianquan02_jiemian42498.x = 42;
            ui_zhuangshixianquan02_jiemian42498.y = 498;
            ui_zhuangshixianquan02_jiemian42498.width = 772;
            ui_zhuangshixianquan02_jiemian42498.height = 3;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian42498);
            infoTxt = new TextField(754,382,'','',24,0xFFFFFF,false);
            infoTxt.touchable = false;
            infoTxt.hAlign= 'left';
            infoTxt.text= '';
            infoTxt.x = 51;
            infoTxt.y = 95;
            this.addQuiackChild(infoTxt);
            texture =assetMgr.getTexture('ui_gonggao_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 401;
            image.y = 38;
            image.width = 54;
            image.height = 30;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
