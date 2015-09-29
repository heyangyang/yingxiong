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
    import com.dialog.Dialog;

    public class ShowServerListDlgBase extends Dialog
    {
        public var ui_zhuangshixianquan04_jiemian093:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian6148:Scale9Image;
        public var txt_des2:TextField;
        public var list_server:List;
        public var ui_zhuangshixianquan04_jiemian00:Scale9Image;
        public var txt_des1:TextField;
        public var list_login:List;

        public function ShowServerListDlgBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_zhuangshixianquan04_jiemian');
            var ui_zhuangshixianquan04_jiemian093Rect:Rectangle = new Rectangle(40,40,50,50);
            var ui_zhuangshixianquan04_jiemian0939ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan04_jiemian093Rect);
            ui_zhuangshixianquan04_jiemian093 = new Scale9Image(ui_zhuangshixianquan04_jiemian0939ScaleTexture);
            ui_zhuangshixianquan04_jiemian093.y = 93;
            ui_zhuangshixianquan04_jiemian093.width = 886;
            ui_zhuangshixianquan04_jiemian093.height = 484;
            this.addQuiackChild(ui_zhuangshixianquan04_jiemian093);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian6148Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian61489ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian6148Rect);
            ui_zhuangshixianquan02_jiemian6148 = new Scale9Image(ui_zhuangshixianquan02_jiemian61489ScaleTexture);
            ui_zhuangshixianquan02_jiemian6148.x = 6;
            ui_zhuangshixianquan02_jiemian6148.y = 148;
            ui_zhuangshixianquan02_jiemian6148.width = 874;
            ui_zhuangshixianquan02_jiemian6148.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian6148);
            txt_des2 = new TextField(289,38,'','',30,0xFFFFFF,false);
            txt_des2.touchable = false;
            txt_des2.hAlign= 'center';
            txt_des2.text= '';
            txt_des2.x = 299;
            txt_des2.y = 106;
            this.addQuiackChild(txt_des2);
            list_server = new List();
            list_server.x = 28;
            list_server.y = 159;
            list_server.width = 830;
            list_server.height = 400;
            this.addQuiackChild(list_server);
            texture = assetMgr.getTexture('ui_zhuangshixianquan04_jiemian');
            var ui_zhuangshixianquan04_jiemian00Rect:Rectangle = new Rectangle(40,40,50,50);
            var ui_zhuangshixianquan04_jiemian009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan04_jiemian00Rect);
            ui_zhuangshixianquan04_jiemian00 = new Scale9Image(ui_zhuangshixianquan04_jiemian009ScaleTexture);
            ui_zhuangshixianquan04_jiemian00.width = 886;
            ui_zhuangshixianquan04_jiemian00.height = 90;
            this.addQuiackChild(ui_zhuangshixianquan04_jiemian00);
            txt_des1 = new TextField(132,70,'','',24,0xFFFFFF,false);
            txt_des1.touchable = false;
            txt_des1.hAlign= 'center';
            txt_des1.text= '';
            txt_des1.x = 8;
            txt_des1.y = 10;
            this.addQuiackChild(txt_des1);
            list_login = new List();
            list_login.x = 144;
            list_login.y = 9;
            list_login.width = 720;
            list_login.height = 72;
            this.addQuiackChild(list_login);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            list_server.dispose();
            list_login.dispose();
            super.dispose();
        
}
    }
}
