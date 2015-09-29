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

    public class GoodsDropGuideRenderBase extends DefaultListItemRenderer
    {
        public var bg:Scale9Image;
        public var ico_hero:Image;
        public var but_bg:Image;
        public var taggoto_Scale9Button:Scale9Button;
        public var txt_isOpen:TextField;
        public var txt_des1:TextField;
        public var txt_drop:TextField;
        public var txt_droptype:TextField;

        public function GoodsDropGuideRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_zhuangshixianquan03_jiemian');
            var bgRect:Rectangle = new Rectangle(30,30,10,10);
            var bg9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgRect);
            bg = new Scale9Image(bg9ScaleTexture);
            bg.width = 350;
            bg.height = 150;
            this.addQuiackChild(bg);
            texture =assetMgr.getTexture('ui_touxiangdi02_01');
            image = new Image(texture);
            image.x = 14;
            image.y = 25;
            image.width = 100;
            image.height = 100;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('photo_101')
            ico_hero = new Image(texture);
            ico_hero.x = 29;
            ico_hero.y = 35;
            ico_hero.width = 78;
            ico_hero.height = 80;
            this.addQuiackChild(ico_hero);
            ico_hero.touchable = false;
            texture = assetMgr.getTexture('ui_touxiangdi02_02')
            but_bg = new Image(texture);
            but_bg.x = 14;
            but_bg.y = 25;
            but_bg.width = 100;
            but_bg.height = 100;
            this.addQuiackChild(but_bg);
            but_bg.touchable = false;
            texture = assetMgr.getTexture('ui_lan03_01_anniu');
            var taggoto_Scale9ButtonRect:Rectangle = new Rectangle(23,16,71,27);
            taggoto_Scale9Button = new Scale9Button(texture,taggoto_Scale9ButtonRect);
            taggoto_Scale9Button.x = 205;
            taggoto_Scale9Button.y = 77;
            taggoto_Scale9Button.width = 130;
            taggoto_Scale9Button.height = 62;
            this.addQuiackChild(taggoto_Scale9Button);
            taggoto_Scale9Button.name = 'taggoto_Scale9Button';
            taggoto_Scale9Button.text= 'lable';
            taggoto_Scale9Button.fontColor= 0xFFFFC9;
            taggoto_Scale9Button.fontSize= 22;
            txt_isOpen = new TextField(72,32,'','',21,0x66FF00,false);
            txt_isOpen.touchable = false;
            txt_isOpen.hAlign= 'center';
            txt_isOpen.text= '';
            txt_isOpen.x = 127;
            txt_isOpen.y = 91;
            this.addQuiackChild(txt_isOpen);
            txt_des1 = new TextField(95,32,'','',21,0xFFFFFF,false);
            txt_des1.touchable = false;
            txt_des1.hAlign= 'left';
            txt_des1.text= '';
            txt_des1.x = 127;
            txt_des1.y = 15;
            this.addQuiackChild(txt_des1);
            txt_drop = new TextField(202,32,'','',21,0xFFFFFF,false);
            txt_drop.touchable = false;
            txt_drop.hAlign= 'left';
            txt_drop.text= '';
            txt_drop.x = 126;
            txt_drop.y = 49;
            this.addQuiackChild(txt_drop);
            txt_droptype = new TextField(103,32,'','',21,0x00FF00,false);
            txt_droptype.touchable = false;
            txt_droptype.hAlign= 'left';
            txt_droptype.text= '';
            txt_droptype.x = 225;
            txt_droptype.y = 15;
            this.addQuiackChild(txt_droptype);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
