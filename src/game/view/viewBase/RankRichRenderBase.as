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
    import feathers.controls.renderers.DefaultListItemRenderer;

    public class RankRichRenderBase extends DefaultListItemRenderer
    {
        public var bgImage0:Scale9Image;
        public var bgImage1:Scale9Image;
        public var userName:TextField;
        public var valueTxt:TextField;
        public var btn_bg:Image;
        public var txt_rank:TextField;
        public var icon:Image;
        public var mask:Image;

        public function RankRichRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var bgImage0Rect:Rectangle = new Rectangle(18,32,34,2);
            var bgImage09ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage0Rect);
            bgImage0 = new Scale9Image(bgImage09ScaleTexture);
            bgImage0.y = 7;
            bgImage0.width = 738;
            bgImage0.height = 69;
            this.addQuiackChild(bgImage0);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage1Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage19ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage1Rect);
            bgImage1 = new Scale9Image(bgImage19ScaleTexture);
            bgImage1.x = 187;
            bgImage1.y = 22;
            bgImage1.width = 550;
            bgImage1.height = 40;
            this.addQuiackChild(bgImage1);
            userName = new TextField(238,31,'','',24,0xFFFFFF,false);
            userName.touchable = false;
            userName.hAlign= 'center';
            userName.text= '';
            userName.x = 220;
            userName.y = 26;
            this.addQuiackChild(userName);
            valueTxt = new TextField(198,35,'','',28,0xFFFFFF,false);
            valueTxt.touchable = false;
            valueTxt.hAlign= 'left';
            valueTxt.text= '';
            valueTxt.x = 532;
            valueTxt.y = 24;
            this.addQuiackChild(valueTxt);
            texture = assetMgr.getTexture('ui_touxiangdi01_01')
            btn_bg = new Image(texture);
            btn_bg.x = 113;
            btn_bg.width = 84;
            btn_bg.height = 84;
            this.addQuiackChild(btn_bg);
            btn_bg.touchable = false;
            txt_rank = new TextField(104,35,'','',28,0xFFFFFF,false);
            txt_rank.touchable = false;
            txt_rank.hAlign= 'center';
            txt_rank.text= '';
            txt_rank.x = 8;
            txt_rank.y = 24;
            this.addQuiackChild(txt_rank);
            texture =assetMgr.getTexture('ui_zuanshi01_tubiao');
            image = new Image(texture);
            image.x = 501;
            image.y = 29;
            image.width = 25;
            image.height = 26;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('photo_100')
            icon = new Image(texture);
            icon.x = 119;
            icon.y = 6;
            icon.width = 72;
            icon.height = 72;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_touxiangdi01_02')
            mask = new Image(texture);
            mask.x = 113;
            mask.width = 84;
            mask.height = 84;
            this.addQuiackChild(mask);
            mask.touchable = false;
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
