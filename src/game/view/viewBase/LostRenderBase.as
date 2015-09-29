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

    public class LostRenderBase extends DefaultListItemRenderer
    {
        public var ui_danxiangkuangdi00:Scale9Image;
        public var bgImage:Scale9Image;
        public var txt_des:TextField;
        public var ok_Scale9Button:Scale9Button;
        public var icon:Image;
        public var quality:Image;
        public var txt_level:TextField;

        public function LostRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var ui_danxiangkuangdi00Rect:Rectangle = new Rectangle(18,32,34,2);
            var ui_danxiangkuangdi009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_danxiangkuangdi00Rect);
            ui_danxiangkuangdi00 = new Scale9Image(ui_danxiangkuangdi009ScaleTexture);
            ui_danxiangkuangdi00.width = 684;
            ui_danxiangkuangdi00.height = 126;
            this.addQuiackChild(ui_danxiangkuangdi00);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImageRect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.x = 125;
            bgImage.y = 8;
            bgImage.width = 364;
            bgImage.height = 110;
            this.addQuiackChild(bgImage);
            txt_des = new TextField(340,100,'','',24,0xFFFFFF,false);
            txt_des.touchable = false;
            txt_des.hAlign= 'left';
            txt_des.text= '';
            txt_des.x = 136;
            txt_des.y = 12;
            this.addQuiackChild(txt_des);
            texture = assetMgr.getTexture('ui_hong02_01_anniu');
            var ok_Scale9ButtonRect:Rectangle = new Rectangle(25,10,50,20);
            ok_Scale9Button = new Scale9Button(texture,ok_Scale9ButtonRect);
            ok_Scale9Button.x = 511;
            ok_Scale9Button.y = 43;
            ok_Scale9Button.width = 150;
            ok_Scale9Button.height = 39;
            this.addQuiackChild(ok_Scale9Button);
            ok_Scale9Button.name = 'ok_Scale9Button';
            ok_Scale9Button.text= 'lable';
            ok_Scale9Button.fontColor= 0xFFFFFF;
            ok_Scale9Button.fontSize= 24;
            texture =assetMgr.getTexture('ui_daojukuangdi');
            image = new Image(texture);
            image.x = 14;
            image.y = 14;
            image.width = 98;
            image.height = 98;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('icon_201002')
            icon = new Image(texture);
            icon.x = 18;
            icon.y = 17;
            icon.width = 89;
            icon.height = 89;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang07')
            quality = new Image(texture);
            quality.x = 14;
            quality.y = 14;
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
            txt_level = new TextField(61,36,'','',24,0xFFCC66,false);
            txt_level.touchable = false;
            txt_level.hAlign= 'right';
            txt_level.text= '+15';
            txt_level.x = 40;
            txt_level.y = 70;
            this.addQuiackChild(txt_level);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
