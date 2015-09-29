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

    public class EmailRenderItemBase extends DefaultListItemRenderer
    {
        public var tag_normal:Scale9Image;
        public var bgImage:Scale9Image;
        public var tag_selected:Scale9Image;
        public var box:Sprite;
        public var newMail:Image;
        public var read:Image;
        public var txt_name:TextField;
        public var txt_des1:TextField;
        public var txt_sender:TextField;
        public var txt_time:TextField;
        public var txt_des2:TextField;

        public function EmailRenderItemBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var tag_normalRect:Rectangle = new Rectangle(18,32,34,2);
            var tag_normal9ScaleTexture:Scale9Textures = new Scale9Textures(texture,tag_normalRect);
            tag_normal = new Scale9Image(tag_normal9ScaleTexture);
            tag_normal.x = 9;
            tag_normal.y = 9;
            tag_normal.width = 400;
            tag_normal.height = 98;
            this.addQuiackChild(tag_normal);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImageRect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImageRect);
            bgImage = new Scale9Image(bgImage9ScaleTexture);
            bgImage.x = 28;
            bgImage.y = 45;
            bgImage.width = 379;
            bgImage.height = 34;
            this.addQuiackChild(bgImage);
            texture = assetMgr.getTexture('ui_xuanzhongfaguang01_jiemian');
            var tag_selectedRect:Rectangle = new Rectangle(18,18,36,36);
            var tag_selected9ScaleTexture:Scale9Textures = new Scale9Textures(texture,tag_selectedRect);
            tag_selected = new Scale9Image(tag_selected9ScaleTexture);
            tag_selected.width = 416;
            tag_selected.height = 116;
            this.addQuiackChild(tag_selected);
            box = new Sprite();
            box.x = 9;
            box.y = 9;
            box.width = 98;
            box.height = 98;
            this.addQuiackChild(box);
            box.name= 'box';
            texture = assetMgr.getTexture('ui_daojukuangdi');
            button = new Button(texture);
            button.name= 'bg';
            button.width = 98;
            button.height = 98;
            box.addQuiackChild(button);
            texture = assetMgr.getTexture('ui_button_mail')
            image = new Image(texture);
            image.name= 'icon';
            image.x = 5;
            image.y = 5;
            image.width = 89;
            image.height = 89;
            box.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            image = new Image(texture);
            image.name= 'quality';
            image.width = 98;
            image.height = 98;
            box.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_yingxionghun_tubiao_02')
            image = new Image(texture);
            image.name= 'hun';
            image.x = 58;
            image.y = 10;
            image.width = 30;
            image.height = 30;
            box.addQuiackChild(image);
            image.touchable = false;
            textField = new TextField(86,30,'','',21,0xFFFFFF,false);
            textField.touchable = false;
            textField.x = 9;
            textField.y = 62;
            textField.hAlign= 'left';
            textField.text= '';
            textField.name= 'txt_num';
            box.addQuiackChild(textField);
            texture = assetMgr.getTexture('ui_button_mail_new')
            newMail = new Image(texture);
            newMail.x = 9;
            newMail.y = 9;
            newMail.width = 62;
            newMail.height = 43;
            this.addQuiackChild(newMail);
            newMail.touchable = false;
            texture = assetMgr.getTexture('ui_button_mail_read')
            read = new Image(texture);
            read.x = 347;
            read.y = 9;
            read.width = 62;
            read.height = 48;
            this.addQuiackChild(read);
            read.touchable = false;
            txt_name = new TextField(287,32,'','',24,0x6633FF,false);
            txt_name.touchable = false;
            txt_name.hAlign= 'left';
            txt_name.text= '';
            txt_name.x = 117;
            txt_name.y = 12;
            this.addQuiackChild(txt_name);
            txt_des1 = new TextField(87,28,'','',20,0xFFFFFF,false);
            txt_des1.touchable = false;
            txt_des1.hAlign= 'left';
            txt_des1.text= '';
            txt_des1.x = 117;
            txt_des1.y = 48;
            this.addQuiackChild(txt_des1);
            txt_sender = new TextField(201,28,'','',20,0xFFFFFF,false);
            txt_sender.touchable = false;
            txt_sender.hAlign= 'left';
            txt_sender.text= '';
            txt_sender.x = 204;
            txt_sender.y = 48;
            this.addQuiackChild(txt_sender);
            txt_time = new TextField(120,28,'','',20,0x66FF00,false);
            txt_time.touchable = false;
            txt_time.hAlign= 'center';
            txt_time.text= '';
            txt_time.x = 280;
            txt_time.y = 77;
            this.addQuiackChild(txt_time);
            txt_des2 = new TextField(111,28,'','',18,0x66FF00,false);
            txt_des2.touchable = false;
            txt_des2.hAlign= 'center';
            txt_des2.text= ' ';
            txt_des2.x = 166;
            txt_des2.y = 77;
            this.addQuiackChild(txt_des2);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            box.dispose();
            super.dispose();
        
}
    }
}
