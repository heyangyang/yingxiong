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
    import feathers.controls.renderers.DefaultListItemRenderer;

    public class HeroIcoRenderBase extends DefaultListItemRenderer
    {
        public var tag_bg:Button;
        public var ico_head:Image;
        public var quality:Image;
        public var tag_battle:Image;
        public var txt_desopen:TextField;
        public var textLv:TextField;
        public var txt_open:TextField;

        public function HeroIcoRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_gongyong_100yingxiongkuang_kong');
            tag_bg = new Button(texture);
            tag_bg.name= 'tag_bg';
            tag_bg.width = 96;
            tag_bg.height = 96;
            this.addQuiackChild(tag_bg);
            texture = assetMgr.getTexture('photo_100')
            ico_head = new Image(texture);
            ico_head.y = 1;
            ico_head.width = 94;
            ico_head.height = 94;
            this.addQuiackChild(ico_head);
            ico_head.touchable = false;
            texture = assetMgr.getTexture('ui_touxiangkuang_01')
            quality = new Image(texture);
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
            texture = assetMgr.getTexture('ui_kexuanzhuangtai2')
            tag_battle = new Image(texture);
            tag_battle.x = 53;
            tag_battle.y = 58;
            tag_battle.width = 38;
            tag_battle.height = 34;
            this.addQuiackChild(tag_battle);
            tag_battle.touchable = false;
            txt_desopen = new TextField(98,32,'','',22,0xFFFFFF,false);
            txt_desopen.touchable = false;
            txt_desopen.hAlign= 'center';
            txt_desopen.text= '扩充';
            txt_desopen.y = 6;
            this.addQuiackChild(txt_desopen);
            textLv = new TextField(47,35,'','',23,0xFFFFFF,false);
            textLv.touchable = false;
            textLv.hAlign= 'left';
            textLv.text= '';
            textLv.x = 8;
            textLv.y = 4;
            this.addQuiackChild(textLv);
            txt_open = new TextField(98,32,'','',22,0xFFFFFF,false);
            txt_open.touchable = false;
            txt_open.hAlign= 'center';
            txt_open.text= '0/0';
            txt_open.y = 62;
            this.addQuiackChild(txt_open);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            tag_bg.dispose();
            super.dispose();
        
}
    }
}
