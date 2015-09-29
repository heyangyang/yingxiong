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

    public class HeroEquipRenderBase extends DefaultListItemRenderer
    {
        public var but_bg:Button;
        public var ico_equip:Image;
        public var tag_equip:Image;
        public var quality:Image;
        public var tag_add:Image;
        public var txt_level:TextField;

        public function HeroEquipRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_daojukuangdi');
            but_bg = new Button(texture);
            but_bg.name= 'but_bg';
            but_bg.width = 98;
            but_bg.height = 98;
            this.addQuiackChild(but_bg);
            texture = assetMgr.getTexture('icon_20001')
            ico_equip = new Image(texture);
            ico_equip.x = 5;
            ico_equip.y = 5;
            ico_equip.width = 89;
            ico_equip.height = 89;
            this.addQuiackChild(ico_equip);
            ico_equip.touchable = false;
            texture = assetMgr.getTexture('ui_yingxiongshengdian_wuqikuangbiaozhi1')
            tag_equip = new Image(texture);
            tag_equip.x = 5;
            tag_equip.y = 5;
            tag_equip.width = 89;
            tag_equip.height = 89;
            this.addQuiackChild(tag_equip);
            tag_equip.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            quality = new Image(texture);
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
            texture = assetMgr.getTexture('ui_zengjia02_anniu')
            tag_add = new Image(texture);
            tag_add.x = 12;
            tag_add.y = 13;
            tag_add.width = 26;
            tag_add.height = 29;
            this.addQuiackChild(tag_add);
            tag_add.touchable = false;
            txt_level = new TextField(74,36,'','',24,0x00FF00,false);
            txt_level.touchable = false;
            txt_level.hAlign= 'right';
            txt_level.text= '';
            txt_level.x = 10;
            txt_level.y = 56;
            this.addQuiackChild(txt_level);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            but_bg.dispose();
            super.dispose();
        
}
    }
}
