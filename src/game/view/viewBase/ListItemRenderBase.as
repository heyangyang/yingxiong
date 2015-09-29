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

    public class ListItemRenderBase extends Sprite
    {
        public var ui_danxiangkuangdi4614:Scale9Image;
        public var bgImage:Scale9Image;
        public var goodsIcon:Image;
        public var icon:Image;
        public var quality:Image;
        public var title:TextField;
        public var caption:TextField;
        public var hun:Image;
        public var okReceive:Image;
        public var values:TextField;

        public function ListItemRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var ui_danxiangkuangdi4614Rect:Rectangle = new Rectangle(18,32,34,2);
            var ui_danxiangkuangdi46149ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_danxiangkuangdi4614Rect);
            ui_danxiangkuangdi4614 = new Scale9Image(ui_danxiangkuangdi46149ScaleTexture);
            ui_danxiangkuangdi4614.x = 46;
            ui_danxiangkuangdi4614.y = 14;
            ui_danxiangkuangdi4614.width = 700;
            ui_danxiangkuangdi4614.height = 69;
            this.addQuiackChild(ui_danxiangkuangdi4614);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImageRect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.x = 65;
            bgImage.y = 51;
            bgImage.width = 588;
            bgImage.height = 30;
            this.addQuiackChild(bgImage);
            texture =assetMgr.getTexture('ui_touxiangdi01_01');
            image = new Image(texture);
            image.x = 1;
            image.y = 7;
            image.width = 84;
            image.height = 84;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_daojukuangdi');
            image = new Image(texture);
            image.x = 649;
            image.width = 98;
            image.height = 98;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('icon_10101')
            goodsIcon = new Image(texture);
            goodsIcon.x = 653;
            goodsIcon.y = 3;
            goodsIcon.width = 89;
            goodsIcon.height = 89;
            this.addQuiackChild(goodsIcon);
            goodsIcon.touchable = false;
            texture = assetMgr.getTexture('ui_iocn_qualifying1')
            icon = new Image(texture);
            icon.y = 21;
            icon.width = 85;
            icon.height = 57;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            quality = new Image(texture);
            quality.x = 649;
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
            title = new TextField(524,31,'','',24,0x6633FF,false);
            title.touchable = false;
            title.hAlign= 'center';
            title.text= '';
            title.x = 112;
            title.y = 18;
            this.addQuiackChild(title);
            caption = new TextField(524,28,'','',21,0xFFFFCC,false);
            caption.touchable = false;
            caption.hAlign= 'center';
            caption.text= '';
            caption.x = 112;
            caption.y = 52;
            this.addQuiackChild(caption);
            texture =assetMgr.getTexture('ui_touxiangdi01_02');
            image = new Image(texture);
            image.x = 1;
            image.y = 7;
            image.width = 84;
            image.height = 84;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_yingxionghun_tubiao_02')
            hun = new Image(texture);
            hun.x = 706;
            hun.y = 11;
            hun.width = 30;
            hun.height = 30;
            this.addQuiackChild(hun);
            hun.touchable = false;
            texture = assetMgr.getTexture('ui_gongyong_jianglilingqu')
            okReceive = new Image(texture);
            okReceive.x = 662;
            okReceive.y = 39;
            okReceive.width = 71;
            okReceive.height = 29;
            this.addQuiackChild(okReceive);
            okReceive.touchable = false;
            values = new TextField(80,32,'','',21,0xFFFFFF,false);
            values.touchable = false;
            values.hAlign= 'left';
            values.text= '';
            values.x = 657;
            values.y = 63;
            this.addQuiackChild(values);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
