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
    import com.view.View;

    public class MainLineBottomPaneBase extends View
    {
        public var bg:Scale9Image;
        public var battle_Scale9Button:Scale9Button;
        public var txt_castPower:TextField;
        public var modeButton_Scale9Button:Scale9Button;
        public var txt_des1:TextField;
        public var Icon_tired:Image;
        public var goodsList:Scale9Image;
        public var list_reward:List;

        public function MainLineBottomPaneBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var bgRect:Rectangle = new Rectangle(68,64,6,6);
            var bg9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgRect);
            bg = new Scale9Image(bg9ScaleTexture);
            bg.width = 984;
            bg.height = 214;
            this.addQuiackChild(bg);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var battle_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            battle_Scale9Button = new Scale9Button(texture,battle_Scale9ButtonRect);
            battle_Scale9Button.x = 766;
            battle_Scale9Button.y = 70;
            battle_Scale9Button.width = 186;
            battle_Scale9Button.height = 70;
            this.addQuiackChild(battle_Scale9Button);
            battle_Scale9Button.name = 'battle_Scale9Button';
            txt_castPower = new TextField(53,36,'','',24,0xFFFFCC,false);
            txt_castPower.touchable = false;
            txt_castPower.hAlign= 'center';
            txt_castPower.text= '';
            txt_castPower.x = 883;
            txt_castPower.y = 86;
            this.addQuiackChild(txt_castPower);
            texture = assetMgr.getTexture('ui_hong03_01_anniu');
            var modeButton_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            modeButton_Scale9Button = new Scale9Button(texture,modeButton_Scale9ButtonRect);
            modeButton_Scale9Button.x = 32;
            modeButton_Scale9Button.y = 70;
            modeButton_Scale9Button.width = 186;
            modeButton_Scale9Button.height = 70;
            this.addQuiackChild(modeButton_Scale9Button);
            modeButton_Scale9Button.name = 'modeButton_Scale9Button';
            modeButton_Scale9Button.text= 'lable';
            modeButton_Scale9Button.fontColor= 0xFFFFFF;
            modeButton_Scale9Button.fontSize= 24;
            txt_des1 = new TextField(75,36,'','',24,0xFFFFCC,false);
            txt_des1.touchable = false;
            txt_des1.hAlign= 'center';
            txt_des1.text= '';
            txt_des1.x = 783;
            txt_des1.y = 86;
            this.addQuiackChild(txt_des1);
            texture = assetMgr.getTexture('ui_tili01_tubiao')
            Icon_tired = new Image(texture);
            Icon_tired.x = 857;
            Icon_tired.y = 91;
            Icon_tired.width = 25;
            Icon_tired.height = 26;
            this.addQuiackChild(Icon_tired);
            Icon_tired.touchable = false;
            texture = assetMgr.getTexture('ui_zhuangshixianquan04_jiemian');
            var goodsListRect:Rectangle = new Rectangle(40,40,50,50);
            var goodsList9ScaleTexture:Scale9Textures = new Scale9Textures(texture,goodsListRect);
            goodsList = new Scale9Image(goodsList9ScaleTexture);
            goodsList.x = 220;
            goodsList.y = 41;
            goodsList.width = 544;
            goodsList.height = 126;
            this.addQuiackChild(goodsList);
            list_reward = new List();
            list_reward.x = 232;
            list_reward.y = 49;
            list_reward.width = 520;
            list_reward.height = 110;
            this.addQuiackChild(list_reward);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            list_reward.dispose();
            super.dispose();
        
}
    }
}
