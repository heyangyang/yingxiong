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
    import game.view.viewBase.MapSelectButtonBase;
    import com.view.View;

    public class MapItemListBase extends View
    {
        public var txt_8:TextField;
        public var txt_7:TextField;
        public var txt_6:TextField;
        public var txt_5:TextField;
        public var txt_4:TextField;
        public var txt_3:TextField;
        public var txt_2:TextField;
        public var txt_1:TextField;
        public var txt_15:TextField;
        public var txt_14:TextField;
        public var txt_13:TextField;
        public var txt_12:TextField;
        public var txt_11:TextField;
        public var txt_10:TextField;
        public var itemBtn:MapSelectButtonBase;

        public function MapItemListBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 189;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_8 = new TextField(70,24,'','',18,0x725F3F,false);
            txt_8.touchable = false;
            txt_8.hAlign= 'center';
            txt_8.text= '';
            txt_8.y = 182;
            this.addQuiackChild(txt_8);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 163;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_7 = new TextField(70,24,'','',18,0x725F3F,false);
            txt_7.touchable = false;
            txt_7.hAlign= 'center';
            txt_7.text= '';
            txt_7.y = 156;
            this.addQuiackChild(txt_7);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 137;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_6 = new TextField(70,24,'','',18,0x725F3F,false);
            txt_6.touchable = false;
            txt_6.hAlign= 'center';
            txt_6.text= '';
            txt_6.y = 130;
            this.addQuiackChild(txt_6);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 111;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_5 = new TextField(70,24,'','',18,0x725F3F,false);
            txt_5.touchable = false;
            txt_5.hAlign= 'center';
            txt_5.text= '';
            txt_5.y = 104;
            this.addQuiackChild(txt_5);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 85;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_4 = new TextField(70,24,'','',18,0x725F3F,false);
            txt_4.touchable = false;
            txt_4.hAlign= 'center';
            txt_4.text= '';
            txt_4.y = 78;
            this.addQuiackChild(txt_4);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 59;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_3 = new TextField(70,24,'','',18,0x725F3F,false);
            txt_3.touchable = false;
            txt_3.hAlign= 'center';
            txt_3.text= '';
            txt_3.y = 52;
            this.addQuiackChild(txt_3);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 33;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_2 = new TextField(70,24,'','',18,0x725F3F,false);
            txt_2.touchable = false;
            txt_2.hAlign= 'center';
            txt_2.text= '';
            txt_2.y = 26;
            this.addQuiackChild(txt_2);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 7;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_1 = new TextField(70,24,'','',18,0x725F3F,false);
            txt_1.touchable = false;
            txt_1.hAlign= 'center';
            txt_1.text= '';
            this.addQuiackChild(txt_1);
            txt_15 = new TextField(70,24,'','',18,0xFF9900,false);
            txt_15.touchable = false;
            txt_15.hAlign= 'center';
            txt_15.text= '';
            txt_15.y = 375;
            this.addQuiackChild(txt_15);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 381;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_14 = new TextField(70,24,'','',18,0xFF9900,false);
            txt_14.touchable = false;
            txt_14.hAlign= 'center';
            txt_14.text= '';
            txt_14.y = 349;
            this.addQuiackChild(txt_14);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 356;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_13 = new TextField(70,24,'','',18,0xFF9900,false);
            txt_13.touchable = false;
            txt_13.hAlign= 'center';
            txt_13.text= '';
            txt_13.y = 323;
            this.addQuiackChild(txt_13);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 330;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_12 = new TextField(70,24,'','',18,0xFF9900,false);
            txt_12.touchable = false;
            txt_12.hAlign= 'center';
            txt_12.text= '';
            txt_12.y = 296;
            this.addQuiackChild(txt_12);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 303;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_11 = new TextField(70,24,'','',18,0xFF9900,false);
            txt_11.touchable = false;
            txt_11.hAlign= 'center';
            txt_11.text= '';
            txt_11.y = 270;
            this.addQuiackChild(txt_11);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 277;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_10 = new TextField(70,24,'','',18,0xFF9900,false);
            txt_10.touchable = false;
            txt_10.hAlign= 'center';
            txt_10.text= '';
            txt_10.y = 244;
            this.addQuiackChild(txt_10);
            texture =assetMgr.getTexture('ui_ditu_zhishibiaoshiyanse');
            image = new Image(texture);
            image.x = 80;
            image.y = 251;
            image.width = 11;
            image.height = 11;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            itemBtn = new MapSelectButtonBase();
            itemBtn.x = -11;
            itemBtn.y = 207;
            this.addQuiackChild(itemBtn);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            itemBtn.dispose();
            super.dispose();
        
}
    }
}
