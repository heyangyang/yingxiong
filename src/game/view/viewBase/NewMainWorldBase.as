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
    import feathers.controls.List;
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;
    import com.components.Scale9Button;
    import game.scene.world.MainLineBottomPane;
    import com.scene.BaseScene;

    public class NewMainWorldBase extends BaseScene
    {
        public var list_map:List;
        public var btn_return:Button;
        public var view_reward:MainLineBottomPane;
        public var power:Sprite;
        public var view_title:Sprite;

        public function NewMainWorldBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            list_map = new List();
            list_map.width = 960;
            list_map.height = 639;
            this.addQuiackChild(list_map);
            texture = assetMgr.getTexture('ui_guanbi01_anniu');
            btn_return = new Button(texture);
            btn_return.name= 'btn_return';
            btn_return.x = 5;
            btn_return.y = 5;
            btn_return.width = 72;
            btn_return.height = 76;
            this.addQuiackChild(btn_return);
            view_reward = new MainLineBottomPane();
            view_reward.y = 446;
            this.addQuiackChild(view_reward);
            power = new Sprite();
            power.x = 789;
            power.y = 10;
            power.width = 166;
            power.height = 38;
            this.addQuiackChild(power);
            power.name= 'power';
            texture = assetMgr.getTexture('ui_dingbuxinxi_01_anniu');
            button = new Button(texture);
            button.name= 'btn_bg';
            button.width = 166;
            button.height = 38;
            power.addQuiackChild(button);
            textField = new TextField(98,31,'','',21,0xFFFFFF,false);
            textField.touchable = false;
            textField.x = 30;
            textField.y = 4;
            textField.hAlign= 'center';
            textField.text= '';
            textField.name= 'txt_power';
            power.addQuiackChild(textField);
            texture = assetMgr.getTexture('ui_zengjia01_anniu')
            image = new Image(texture);
            image.name= 'addGoods';
            image.x = 129;
            image.width = 36;
            image.height = 36;
            power.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_tili01_tubiao')
            image = new Image(texture);
            image.name= 'icon_type';
            image.x = 11;
            image.y = 7;
            image.width = 25;
            image.height = 26;
            power.addQuiackChild(image);
            image.touchable = false;
            view_title = new Sprite();
            view_title.x = 330;
            view_title.y = 10;
            view_title.width = 300;
            view_title.height = 50;
            this.addQuiackChild(view_title);
            view_title.name= 'view_title';
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var bgImgRect:Rectangle = new Rectangle(18,18,35,35);
            var bgImg9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImgRect);
            var bgImg : Scale9Image = new Scale9Image(bgImg9ScaleTexture);
            bgImg.width = 300;
            bgImg.height = 50;
            view_title.addQuiackChild(bgImg);
            textField = new TextField(300,36,'','',24,0xFFFF66,false);
            textField.touchable = false;
            textField.y = 6;
            textField.hAlign= 'center';
            textField.text= '';
            textField.name= 'text';
            view_title.addQuiackChild(textField);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            list_map.dispose();
            btn_return.dispose();
            view_reward.dispose();
            power.dispose();
            view_title.dispose();
            super.dispose();
        
}
    }
}
