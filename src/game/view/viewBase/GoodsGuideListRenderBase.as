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

    public class GoodsGuideListRenderBase extends DefaultListItemRenderer
    {
        public var bg:Scale9Image;
        public var tag_selected:Scale9Image;
        public var but_bg:Button;
        public var ico_equip:Image;
        public var ico_quality:Image;
        public var hun:Image;
        public var txt_name:TextField;
        public var txt_sort:TextField;
        public var txt_level:TextField;
        public var txt_strengthen:TextField;
        public var btnbuy_Scale9Button:Scale9Button;
        public var diaIcon:Image;

        public function GoodsGuideListRenderBase()
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
            bg.x = 2;
            bg.y = 2;
            bg.width = 322;
            bg.height = 130;
            this.addQuiackChild(bg);
            texture = assetMgr.getTexture('ui_xuanzhongfaguang01_jiemian');
            var tag_selectedRect:Rectangle = new Rectangle(24,22,26,25);
            var tag_selected9ScaleTexture:Scale9Textures = new Scale9Textures(texture,tag_selectedRect);
            tag_selected = new Scale9Image(tag_selected9ScaleTexture);
            tag_selected.width = 326;
            tag_selected.height = 134;
            this.addQuiackChild(tag_selected);
            texture = assetMgr.getTexture('ui_daojukuangdi');
            but_bg = new Button(texture);
            but_bg.name= 'but_bg';
            but_bg.x = 27;
            but_bg.y = 18;
            but_bg.width = 98;
            but_bg.height = 98;
            this.addQuiackChild(but_bg);
            texture = assetMgr.getTexture('icon_300010')
            ico_equip = new Image(texture);
            ico_equip.x = 31;
            ico_equip.y = 22;
            ico_equip.width = 90;
            ico_equip.height = 90;
            this.addQuiackChild(ico_equip);
            ico_equip.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            ico_quality = new Image(texture);
            ico_quality.x = 27;
            ico_quality.y = 18;
            ico_quality.width = 98;
            ico_quality.height = 98;
            this.addQuiackChild(ico_quality);
            ico_quality.touchable = false;
            texture = assetMgr.getTexture('ui_yingxionghun_tubiao_02')
            hun = new Image(texture);
            hun.x = 84;
            hun.y = 28;
            hun.width = 30;
            hun.height = 30;
            this.addQuiackChild(hun);
            hun.touchable = false;
            txt_name = new TextField(164,36,'','',24,0x33FF00,false);
            txt_name.touchable = false;
            txt_name.hAlign= 'center';
            txt_name.text= '';
            txt_name.x = 135;
            txt_name.y = 19;
            this.addQuiackChild(txt_name);
            txt_sort = new TextField(81,32,'','',20,0xFFFFFF,false);
            txt_sort.touchable = false;
            txt_sort.hAlign= 'center';
            txt_sort.text= '';
            txt_sort.x = 159;
            txt_sort.y = 73;
            this.addQuiackChild(txt_sort);
            txt_level = new TextField(98,32,'','',21,0xFFFFFF,false);
            txt_level.touchable = false;
            txt_level.hAlign= 'center';
            txt_level.text= '';
            txt_level.x = 26;
            txt_level.y = 26;
            this.addQuiackChild(txt_level);
            txt_strengthen = new TextField(79,32,'','',21,0xFFFFFF,false);
            txt_strengthen.touchable = false;
            txt_strengthen.hAlign= 'left';
            txt_strengthen.text= '';
            txt_strengthen.x = 36;
            txt_strengthen.y = 77;
            this.addQuiackChild(txt_strengthen);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var btnbuy_Scale9ButtonRect:Rectangle = new Rectangle(37,18,45,22);
            btnbuy_Scale9Button = new Scale9Button(texture,btnbuy_Scale9ButtonRect);
            btnbuy_Scale9Button.x = 135;
            btnbuy_Scale9Button.y = 58;
            btnbuy_Scale9Button.width = 168;
            btnbuy_Scale9Button.height = 62;
            this.addQuiackChild(btnbuy_Scale9Button);
            btnbuy_Scale9Button.name = 'btnbuy_Scale9Button';
            btnbuy_Scale9Button.text= 'lable';
            btnbuy_Scale9Button.fontColor= 0xFFFFFF;
            btnbuy_Scale9Button.fontSize= 22;
            texture = assetMgr.getTexture('ui_zuanshi01_tubiao')
            diaIcon = new Image(texture);
            diaIcon.x = 252;
            diaIcon.y = 76;
            diaIcon.width = 25;
            diaIcon.height = 26;
            this.addQuiackChild(diaIcon);
            diaIcon.touchable = false;
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            but_bg.dispose();
            super.dispose();
        
}
    }
}
