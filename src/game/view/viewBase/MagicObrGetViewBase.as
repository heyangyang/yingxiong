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

    public class MagicObrGetViewBase extends View
    {
        public var ui_zhuangshixianquan02_jiemian163407:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian161406:Scale9Image;
        public var btn_automatic:Button;
        public var list_orb:List;
        public var sell_Scale9Button:Scale9Button;
        public var complete_Scale9Button:Scale9Button;
        public var up_1:Image;
        public var up_2:Image;
        public var up_3:Image;
        public var up_4:Image;

        public function MagicObrGetViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian163407Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian1634079ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian163407Rect);
            ui_zhuangshixianquan02_jiemian163407 = new Scale9Image(ui_zhuangshixianquan02_jiemian1634079ScaleTexture);
            ui_zhuangshixianquan02_jiemian163407.x = 163;
            ui_zhuangshixianquan02_jiemian163407.y = 407;
            ui_zhuangshixianquan02_jiemian163407.width = 772;
            ui_zhuangshixianquan02_jiemian163407.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian163407);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian161406Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian1614069ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian161406Rect);
            ui_zhuangshixianquan02_jiemian161406 = new Scale9Image(ui_zhuangshixianquan02_jiemian1614069ScaleTexture);
            ui_zhuangshixianquan02_jiemian161406.x = 161;
            ui_zhuangshixianquan02_jiemian161406.y = 406;
            ui_zhuangshixianquan02_jiemian161406.width = 772;
            ui_zhuangshixianquan02_jiemian161406.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian161406);
            texture = assetMgr.getTexture('ui_yuanhonganniu01_anniu');
            btn_automatic = new Button(texture);
            btn_automatic.name= 'btn_automatic';
            btn_automatic.x = 819;
            btn_automatic.y = 421;
            btn_automatic.width = 113;
            btn_automatic.height = 113;
            this.addQuiackChild(btn_automatic);
            btn_automatic.text= 'lable';
            btn_automatic.fontColor= 0xFFFFFF;
            btn_automatic.fontSize= 24;
            list_orb = new List();
            list_orb.x = 191;
            list_orb.y = 85;
            list_orb.width = 713;
            list_orb.height = 304;
            this.addQuiackChild(list_orb);
            texture = assetMgr.getTexture('ui_hong02_01_anniu');
            var sell_Scale9ButtonRect:Rectangle = new Rectangle(25,10,50,20);
            sell_Scale9Button = new Scale9Button(texture,sell_Scale9ButtonRect);
            sell_Scale9Button.x = 208;
            sell_Scale9Button.y = 18;
            sell_Scale9Button.width = 150;
            sell_Scale9Button.height = 39;
            this.addQuiackChild(sell_Scale9Button);
            sell_Scale9Button.name = 'sell_Scale9Button';
            sell_Scale9Button.text= 'lable';
            sell_Scale9Button.fontColor= 0xFFFFFFB4;
            sell_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_hong02_01_anniu');
            var complete_Scale9ButtonRect:Rectangle = new Rectangle(25,10,50,20);
            complete_Scale9Button = new Scale9Button(texture,complete_Scale9ButtonRect);
            complete_Scale9Button.x = 696;
            complete_Scale9Button.y = 18;
            complete_Scale9Button.width = 150;
            complete_Scale9Button.height = 39;
            this.addQuiackChild(complete_Scale9Button);
            complete_Scale9Button.name = 'complete_Scale9Button';
            complete_Scale9Button.text= 'lable';
            complete_Scale9Button.fontColor= 0xFFFFFFB4;
            complete_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_zhishijiantou01_tubiao')
            up_1 = new Image(texture);
            up_1.x = 253;
            up_1.y = 437;
            up_1.width = 61;
            up_1.height = 53;
            this.addQuiackChild(up_1);
            up_1.touchable = false;
            texture = assetMgr.getTexture('ui_zhishijiantou02_tubiao')
            up_2 = new Image(texture);
            up_2.x = 390;
            up_2.y = 437;
            up_2.width = 61;
            up_2.height = 53;
            this.addQuiackChild(up_2);
            up_2.touchable = false;
            texture = assetMgr.getTexture('ui_zhishijiantou02_tubiao')
            up_3 = new Image(texture);
            up_3.x = 525;
            up_3.y = 437;
            up_3.width = 61;
            up_3.height = 53;
            this.addQuiackChild(up_3);
            up_3.touchable = false;
            texture = assetMgr.getTexture('ui_zhishijiantou02_tubiao')
            up_4 = new Image(texture);
            up_4.x = 660;
            up_4.y = 437;
            up_4.width = 61;
            up_4.height = 53;
            this.addQuiackChild(up_4);
            up_4.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btn_automatic.dispose();
            list_orb.dispose();
            super.dispose();
        
}
    }
}
