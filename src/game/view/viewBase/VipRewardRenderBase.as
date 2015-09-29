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

    public class VipRewardRenderBase extends DefaultListItemRenderer
    {
        public var bg:Button;
        public var ico_goods:Image;
        public var quality:Image;
        public var txt_name:TextField;
        public var txt_num:TextField;

        public function VipRewardRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_daojukuangdi');
            bg = new Button(texture);
            bg.name= 'bg';
            bg.width = 98;
            bg.height = 98;
            this.addQuiackChild(bg);
            texture = assetMgr.getTexture('icon_002')
            ico_goods = new Image(texture);
            ico_goods.x = 5;
            ico_goods.y = 5;
            ico_goods.width = 89;
            ico_goods.height = 89;
            this.addQuiackChild(ico_goods);
            ico_goods.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            quality = new Image(texture);
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
            txt_name = new TextField(130,32,'','',21,0xFFFFFF,false);
            txt_name.touchable = false;
            txt_name.hAlign= 'center';
            txt_name.text= '';
            txt_name.x = -18;
            txt_name.y = 98;
            this.addQuiackChild(txt_name);
            txt_num = new TextField(75,32,'','',22,0xFFFFFF,false);
            txt_num.touchable = false;
            txt_num.hAlign= 'left';
            txt_num.text= '';
            txt_num.x = 11;
            txt_num.y = 61;
            this.addQuiackChild(txt_num);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            bg.dispose();
            super.dispose();
        
}
    }
}
