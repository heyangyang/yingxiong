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

    public class ConvertItemViewBase extends DefaultListItemRenderer
    {
        public var ui_danxiangkuangdi00:Scale9Image;
        public var bgImage0:Scale9Image;
        public var bgImage1:Scale9Image;
        public var txtName:TextField;
        public var txtFightNum:TextField;
        public var bg:Button;
        public var ico:Image;
        public var head:Image;
        public var hun:Image;

        public function ConvertItemViewBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var ui_danxiangkuangdi00Rect:Rectangle = new Rectangle(18,18,35,35);
            var ui_danxiangkuangdi009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_danxiangkuangdi00Rect);
            ui_danxiangkuangdi00 = new Scale9Image(ui_danxiangkuangdi009ScaleTexture);
            ui_danxiangkuangdi00.width = 152;
            ui_danxiangkuangdi00.height = 190;
            this.addQuiackChild(ui_danxiangkuangdi00);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage0Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage09ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage0Rect);
            bgImage0 = new Scale9Image(bgImage09ScaleTexture);
            bgImage0.x = 6;
            bgImage0.y = 6;
            bgImage0.width = 141;
            bgImage0.height = 34;
            this.addQuiackChild(bgImage0);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage1Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage19ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage1Rect);
            bgImage1 = new Scale9Image(bgImage19ScaleTexture);
            bgImage1.x = 6;
            bgImage1.y = 150;
            bgImage1.width = 141;
            bgImage1.height = 34;
            this.addQuiackChild(bgImage1);
            txtName = new TextField(132,31,'','',24,0xFFFFFF,false);
            txtName.touchable = false;
            txtName.hAlign= 'center';
            txtName.text= '';
            txtName.x = 9;
            txtName.y = 7;
            this.addQuiackChild(txtName);
            txtFightNum = new TextField(100,31,'','',24,0xFFFFFF,false);
            txtFightNum.touchable = false;
            txtFightNum.hAlign= 'center';
            txtFightNum.text= '';
            txtFightNum.x = 38;
            txtFightNum.y = 151;
            this.addQuiackChild(txtFightNum);
            texture =assetMgr.getTexture('ui_rongyuzhi_01_tubiao');
            image = new Image(texture);
            image.x = 14;
            image.y = 149;
            image.width = 27;
            image.height = 39;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_daojukuangdi');
            bg = new Button(texture);
            bg.name= 'bg';
            bg.x = 27;
            bg.y = 46;
            bg.width = 98;
            bg.height = 98;
            this.addQuiackChild(bg);
            texture = assetMgr.getTexture('icon_20001')
            ico = new Image(texture);
            ico.x = 32;
            ico.y = 51;
            ico.width = 89;
            ico.height = 89;
            this.addQuiackChild(ico);
            ico.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            head = new Image(texture);
            head.x = 27;
            head.y = 46;
            head.width = 98;
            head.height = 98;
            this.addQuiackChild(head);
            head.touchable = false;
            texture = assetMgr.getTexture('ui_yingxionghun_tubiao_02')
            hun = new Image(texture);
            hun.x = 85;
            hun.y = 56;
            hun.width = 30;
            hun.height = 30;
            this.addQuiackChild(hun);
            hun.touchable = false;
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            bg.dispose();
            super.dispose();
        
}
    }
}
