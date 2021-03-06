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

    public class JTUIGitTollgateBase extends Dialog
    {
        public var ui_tipstanchukuangdi01_jiemian00:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian44218:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian4474:Scale9Image;
        public var txt_0:TextField;
        public var txt_1:TextField;
        public var txt_2:TextField;
        public var ui_zhuangshixianquan02_jiemian44143:Scale9Image;
        public var txt_tolltage_num:TextField;
        public var txt_cu_progress:TextField;
        public var getGift_Scale9Button:Scale9Button;
        public var ui_zhuangshixianquan02_jiemian44219:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian4475:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian44144:Scale9Image;
        public var icon_0:Image;
        public var icon_1:Image;
        public var icon_2:Image;

        public function JTUIGitTollgateBase()
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
            ui_tipstanchukuangdi01_jiemian00.width = 438;
            ui_tipstanchukuangdi01_jiemian00.height = 350;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian00);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian44218Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian442189ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian44218Rect);
            ui_zhuangshixianquan02_jiemian44218 = new Scale9Image(ui_zhuangshixianquan02_jiemian442189ScaleTexture);
            ui_zhuangshixianquan02_jiemian44218.x = 44;
            ui_zhuangshixianquan02_jiemian44218.y = 218;
            ui_zhuangshixianquan02_jiemian44218.width = 352;
            ui_zhuangshixianquan02_jiemian44218.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian44218);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian4474Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian44749ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian4474Rect);
            ui_zhuangshixianquan02_jiemian4474 = new Scale9Image(ui_zhuangshixianquan02_jiemian44749ScaleTexture);
            ui_zhuangshixianquan02_jiemian4474.x = 44;
            ui_zhuangshixianquan02_jiemian4474.y = 74;
            ui_zhuangshixianquan02_jiemian4474.width = 352;
            ui_zhuangshixianquan02_jiemian4474.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian4474);
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
            image.x = 390;
            image.y = 41;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_0 = new TextField(85,31,'','',24,0xFFFFFF,false);
            txt_0.touchable = false;
            txt_0.hAlign= 'center';
            txt_0.text= '';
            txt_0.x = 70;
            txt_0.y = 165;
            this.addQuiackChild(txt_0);
            txt_1 = new TextField(85,31,'','',24,0xFFFFFF,false);
            txt_1.touchable = false;
            txt_1.hAlign= 'center';
            txt_1.text= '';
            txt_1.x = 196;
            txt_1.y = 165;
            this.addQuiackChild(txt_1);
            txt_2 = new TextField(85,31,'','',24,0xFFFFFF,false);
            txt_2.touchable = false;
            txt_2.hAlign= 'center';
            txt_2.text= '';
            txt_2.x = 318;
            txt_2.y = 165;
            this.addQuiackChild(txt_2);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian44143Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian441439ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian44143Rect);
            ui_zhuangshixianquan02_jiemian44143 = new Scale9Image(ui_zhuangshixianquan02_jiemian441439ScaleTexture);
            ui_zhuangshixianquan02_jiemian44143.x = 44;
            ui_zhuangshixianquan02_jiemian44143.y = 143;
            ui_zhuangshixianquan02_jiemian44143.width = 352;
            ui_zhuangshixianquan02_jiemian44143.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian44143);
            txt_tolltage_num = new TextField(150,32,'','',24,0xFFFFFF,false);
            txt_tolltage_num.touchable = false;
            txt_tolltage_num.hAlign= 'center';
            txt_tolltage_num.text= '';
            txt_tolltage_num.x = 216;
            txt_tolltage_num.y = 94;
            this.addQuiackChild(txt_tolltage_num);
            txt_cu_progress = new TextField(129,31,'','',24,0xFFFFFF,false);
            txt_cu_progress.touchable = false;
            txt_cu_progress.hAlign= 'right';
            txt_cu_progress.text= '';
            txt_cu_progress.x = 79;
            txt_cu_progress.y = 94;
            this.addQuiackChild(txt_cu_progress);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 161;
            image.y = 73;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 277;
            image.y = 73;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_guankajiangli_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 168;
            image.y = 42;
            image.width = 102;
            image.height = 30;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 388;
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
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var getGift_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            getGift_Scale9Button = new Scale9Button(texture,getGift_Scale9ButtonRect);
            getGift_Scale9Button.x = 126;
            getGift_Scale9Button.y = 236;
            getGift_Scale9Button.width = 186;
            getGift_Scale9Button.height = 70;
            this.addQuiackChild(getGift_Scale9Button);
            getGift_Scale9Button.name = 'getGift_Scale9Button';
            getGift_Scale9Button.text= 'lable';
            getGift_Scale9Button.fontColor= 0xFFFFFF;
            getGift_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian44219Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian442199ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian44219Rect);
            ui_zhuangshixianquan02_jiemian44219 = new Scale9Image(ui_zhuangshixianquan02_jiemian442199ScaleTexture);
            ui_zhuangshixianquan02_jiemian44219.x = 44;
            ui_zhuangshixianquan02_jiemian44219.y = 219;
            ui_zhuangshixianquan02_jiemian44219.width = 352;
            ui_zhuangshixianquan02_jiemian44219.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian44219);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian4475Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian44759ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian4475Rect);
            ui_zhuangshixianquan02_jiemian4475 = new Scale9Image(ui_zhuangshixianquan02_jiemian44759ScaleTexture);
            ui_zhuangshixianquan02_jiemian4475.x = 44;
            ui_zhuangshixianquan02_jiemian4475.y = 75;
            ui_zhuangshixianquan02_jiemian4475.width = 352;
            ui_zhuangshixianquan02_jiemian4475.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian4475);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian44144Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian441449ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian44144Rect);
            ui_zhuangshixianquan02_jiemian44144 = new Scale9Image(ui_zhuangshixianquan02_jiemian441449ScaleTexture);
            ui_zhuangshixianquan02_jiemian44144.x = 44;
            ui_zhuangshixianquan02_jiemian44144.y = 144;
            ui_zhuangshixianquan02_jiemian44144.width = 352;
            ui_zhuangshixianquan02_jiemian44144.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian44144);
            texture = assetMgr.getTexture('ui_zuanshi01_tubiao')
            icon_0 = new Image(texture);
            icon_0.x = 45;
            icon_0.y = 167;
            icon_0.width = 25;
            icon_0.height = 26;
            this.addQuiackChild(icon_0);
            icon_0.touchable = false;
            texture = assetMgr.getTexture('ui_tili01_tubiao')
            icon_1 = new Image(texture);
            icon_1.x = 171;
            icon_1.y = 167;
            icon_1.width = 25;
            icon_1.height = 26;
            this.addQuiackChild(icon_1);
            icon_1.touchable = false;
            texture = assetMgr.getTexture('ui_xingyunxing01_tubiao')
            icon_2 = new Image(texture);
            icon_2.x = 291;
            icon_2.y = 167;
            icon_2.width = 25;
            icon_2.height = 26;
            this.addQuiackChild(icon_2);
            icon_2.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
