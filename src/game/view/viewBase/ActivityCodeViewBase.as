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
    import feathers.controls.TextInput;
    import com.dialog.TabDialog;

    public class ActivityCodeViewBase extends TabDialog
    {
        public var ui_tipstanchukuangdi01_jiemian00:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian4475:Scale9Image;
        public var ui_danxiangkuangdi4490:Scale9Image;
        public var bgImage:Scale9Image;
        public var ok_Scale9Button:Scale9Button;
        public var txt_input:TextInput;
        public var ui_zhuangshixianquan01_jiemian59102:Scale9Image;

        public function ActivityCodeViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var ui_tipstanchukuangdi01_jiemian00Rect:Rectangle = new Rectangle(68,64,6,6);
            var ui_tipstanchukuangdi01_jiemian009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_tipstanchukuangdi01_jiemian00Rect);
            ui_tipstanchukuangdi01_jiemian00 = new Scale9Image(ui_tipstanchukuangdi01_jiemian009ScaleTexture);
            ui_tipstanchukuangdi01_jiemian00.width = 600;
            ui_tipstanchukuangdi01_jiemian00.height = 282;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian00);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian4475Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian44759ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian4475Rect);
            ui_zhuangshixianquan02_jiemian4475 = new Scale9Image(ui_zhuangshixianquan02_jiemian44759ScaleTexture);
            ui_zhuangshixianquan02_jiemian4475.x = 44;
            ui_zhuangshixianquan02_jiemian4475.y = 75;
            ui_zhuangshixianquan02_jiemian4475.width = 512;
            ui_zhuangshixianquan02_jiemian4475.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian4475);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 50;
            image.y = 41;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 550;
            image.y = 41;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 227;
            image.y = 74;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 373;
            image.y = 74;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var ui_danxiangkuangdi4490Rect:Rectangle = new Rectangle(18,32,34,2);
            var ui_danxiangkuangdi44909ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_danxiangkuangdi4490Rect);
            ui_danxiangkuangdi4490 = new Scale9Image(ui_danxiangkuangdi44909ScaleTexture);
            ui_danxiangkuangdi4490.x = 44;
            ui_danxiangkuangdi4490.y = 90;
            ui_danxiangkuangdi4490.width = 512;
            ui_danxiangkuangdi4490.height = 69;
            this.addQuiackChild(ui_danxiangkuangdi4490);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImageRect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.x = 63;
            bgImage.y = 106;
            bgImage.width = 474;
            bgImage.height = 36;
            this.addQuiackChild(bgImage);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var ok_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            ok_Scale9Button = new Scale9Button(texture,ok_Scale9ButtonRect);
            ok_Scale9Button.x = 210;
            ok_Scale9Button.y = 171;
            ok_Scale9Button.width = 186;
            ok_Scale9Button.height = 70;
            this.addQuiackChild(ok_Scale9Button);
            ok_Scale9Button.name = 'ok_Scale9Button';
            ok_Scale9Button.text= 'lable';
            ok_Scale9Button.fontColor= 0xFFFFFF;
            ok_Scale9Button.fontSize= 24;
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 548;
            image.y = 46;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 52;
            image.y = 46;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_duihuanmashuru_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 238;
            image.y = 43;
            image.width = 125;
            image.height = 30;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_input = new TextInput();
            txt_input.textEditorProperties.fontSize = 24;
            txt_input.text = '';
            txt_input.textEditorProperties.color = 0xFFFFFF;
            txt_input.x = 73;
            txt_input.y = 108;
            txt_input.width = 454;
            txt_input.height = 32;
            this.addQuiackChild(txt_input);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian59102Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian591029ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian59102Rect);
            ui_zhuangshixianquan01_jiemian59102 = new Scale9Image(ui_zhuangshixianquan01_jiemian591029ScaleTexture);
            ui_zhuangshixianquan01_jiemian59102.x = 59;
            ui_zhuangshixianquan01_jiemian59102.y = 102;
            ui_zhuangshixianquan01_jiemian59102.width = 482;
            ui_zhuangshixianquan01_jiemian59102.height = 44;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian59102);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            txt_input.dispose();
            super.dispose();
        
}
    }
}
