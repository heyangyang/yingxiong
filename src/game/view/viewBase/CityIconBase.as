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
    import game.view.city.CityMenuBar;
    import game.view.city.CityActiveBar;
    import com.view.View;

    public class CityIconBase extends View
    {
        public var cityMenubar:CityMenuBar;
        public var btn_strategy:Button;
        public var cityAticveBar:CityActiveBar;
        public var bg1:Image;
        public var ico_hero:Button;
        public var bg2:Image;
        public var btn_vip:Button;
        public var txt_vip:TextField;
        public var btn_tcouh:Button;

        public function CityIconBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            cityMenubar = new CityMenuBar();
            cityMenubar.x = 864;
            this.addQuiackChild(cityMenubar);
            texture = assetMgr.getTexture('icon_renwu_tubiao');
            btn_strategy = new Button(texture);
            btn_strategy.name= 'btn_strategy';
            btn_strategy.y = 183;
            btn_strategy.width = 86;
            btn_strategy.height = 86;
            this.addQuiackChild(btn_strategy);
            cityAticveBar = new CityActiveBar();
            cityAticveBar.x = 242;
            this.addQuiackChild(cityAticveBar);
            texture = assetMgr.getTexture('ui_touxiangdi01_01')
            bg1 = new Image(texture);
            bg1.width = 100;
            bg1.height = 100;
            this.addQuiackChild(bg1);
            bg1.touchable = false;
            texture = assetMgr.getTexture('photo_525');
            ico_hero = new Button(texture);
            ico_hero.name= 'ico_hero';
            ico_hero.x = 9;
            ico_hero.y = 9;
            ico_hero.width = 82;
            ico_hero.height = 82;
            this.addQuiackChild(ico_hero);
            texture = assetMgr.getTexture('ui_touxiangdi01_02')
            bg2 = new Image(texture);
            bg2.width = 100;
            bg2.height = 100;
            this.addQuiackChild(bg2);
            bg2.touchable = false;
            texture = assetMgr.getTexture('ui_vipzuoshang01_tubiao');
            btn_vip = new Button(texture);
            btn_vip.name= 'btn_vip';
            btn_vip.x = 27;
            btn_vip.y = 88;
            btn_vip.width = 50;
            btn_vip.height = 59;
            this.addQuiackChild(btn_vip);
            txt_vip = new TextField(50,31,'','',24,0xFFFFFF,false);
            txt_vip.touchable = false;
            txt_vip.hAlign= 'center';
            txt_vip.text= '22';
            txt_vip.x = 27;
            txt_vip.y = 106;
            this.addQuiackChild(txt_vip);
            texture = assetMgr.getTexture('icon_dakaicaozuolan_tubiao');
            btn_tcouh = new Button(texture);
            btn_tcouh.name= 'btn_tcouh';
            btn_tcouh.x = 864;
            btn_tcouh.y = -4;
            btn_tcouh.width = 98;
            btn_tcouh.height = 80;
            this.addQuiackChild(btn_tcouh);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            cityMenubar.dispose();
            btn_strategy.dispose();
            cityAticveBar.dispose();
            ico_hero.dispose();
            btn_vip.dispose();
            btn_tcouh.dispose();
            super.dispose();
        
}
    }
}
