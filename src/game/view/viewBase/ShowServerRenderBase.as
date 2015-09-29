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

    public class ShowServerRenderBase extends DefaultListItemRenderer
    {
        public var ui_danxiangkuangdi00:Scale9Image;
        public var bgImage:Scale9Image;
        public var txt_name:TextField;
        public var tag_new:Image;
        public var tag_hot:Image;
        public var tag_afterOpen:Image;

        public function ShowServerRenderBase()
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
            ui_danxiangkuangdi00.width = 357;
            ui_danxiangkuangdi00.height = 69;
            this.addQuiackChild(ui_danxiangkuangdi00);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImageRect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.x = 1;
            bgImage.y = 14;
            bgImage.width = 354;
            bgImage.height = 41;
            this.addQuiackChild(bgImage);
            txt_name = new TextField(355,32,'','',24,0xFF9900,false);
            txt_name.touchable = false;
            txt_name.hAlign= 'center';
            txt_name.text= '';
            txt_name.y = 19;
            this.addQuiackChild(txt_name);
            texture = assetMgr.getTexture('ui_district_iocn_xinqu')
            tag_new = new Image(texture);
            tag_new.x = 286;
            tag_new.width = 61;
            tag_new.height = 47;
            this.addQuiackChild(tag_new);
            tag_new.touchable = false;
            texture = assetMgr.getTexture('ui_district_iocn_huobao')
            tag_hot = new Image(texture);
            tag_hot.x = 286;
            tag_hot.width = 61;
            tag_hot.height = 47;
            this.addQuiackChild(tag_hot);
            tag_hot.touchable = false;
            texture = assetMgr.getTexture('ui_district_iocn_jijiangkaifang')
            tag_afterOpen = new Image(texture);
            tag_afterOpen.x = 261;
            tag_afterOpen.width = 96;
            tag_afterOpen.height = 60;
            this.addQuiackChild(tag_afterOpen);
            tag_afterOpen.touchable = false;
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
