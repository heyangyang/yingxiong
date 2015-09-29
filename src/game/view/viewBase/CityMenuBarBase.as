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
    import com.view.View;

    public class CityMenuBarBase extends View
    {
        public var bg_btn:Scale9Image;
        public var btn_mail:Button;
        public var btn_bag:Button;
        public var btn_pic:Button;
        public var btn_reward:Button;
        public var btn_xingyun:Button;

        public function CityMenuBarBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bg_btnRect:Rectangle = new Rectangle(12,12,20,20);
            var bg_btn9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bg_btnRect);
            bg_btn = new Scale9Image(bg_btn9ScaleTexture);
            bg_btn.width = 98;
            bg_btn.height = 640;
            this.addQuiackChild(bg_btn);
            texture = assetMgr.getTexture('icon_youxiang_tubiao');
            btn_mail = new Button(texture);
            btn_mail.name= 'btn_mail';
            btn_mail.x = 5;
            btn_mail.y = 418;
            btn_mail.width = 86;
            btn_mail.height = 86;
            this.addQuiackChild(btn_mail);
            texture = assetMgr.getTexture('icon_beibao_tubiao');
            btn_bag = new Button(texture);
            btn_bag.name= 'btn_bag';
            btn_bag.x = 5;
            btn_bag.y = 532;
            btn_bag.width = 86;
            btn_bag.height = 86;
            this.addQuiackChild(btn_bag);
            texture = assetMgr.getTexture('icon_tujian_tubiao');
            btn_pic = new Button(texture);
            btn_pic.name= 'btn_pic';
            btn_pic.x = 5;
            btn_pic.y = 190;
            btn_pic.width = 86;
            btn_pic.height = 86;
            this.addQuiackChild(btn_pic);
            texture = assetMgr.getTexture('icon_chengjiu_tubiao');
            btn_reward = new Button(texture);
            btn_reward.name= 'btn_reward';
            btn_reward.x = 6;
            btn_reward.y = 304;
            btn_reward.width = 86;
            btn_reward.height = 86;
            this.addQuiackChild(btn_reward);
            texture = assetMgr.getTexture('icon_xingyunxing_tubiao');
            btn_xingyun = new Button(texture);
            btn_xingyun.name= 'btn_xingyun';
            btn_xingyun.x = 6;
            btn_xingyun.y = 76;
            btn_xingyun.width = 86;
            btn_xingyun.height = 86;
            this.addQuiackChild(btn_xingyun);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btn_mail.dispose();
            btn_bag.dispose();
            btn_pic.dispose();
            btn_reward.dispose();
            btn_xingyun.dispose();
            super.dispose();
        
}
    }
}
