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

    public class LostViewBase extends Dialog
    {
        public var ui_zhuangshixianquan02_jiemian271462:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian271100:Scale9Image;
        public var list_view:List;
        public var return_Scale9Button:Scale9Button;
        public var replay_Scale9Button:Scale9Button;

        public function LostViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian271462Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian2714629ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian271462Rect);
            ui_zhuangshixianquan02_jiemian271462 = new Scale9Image(ui_zhuangshixianquan02_jiemian2714629ScaleTexture);
            ui_zhuangshixianquan02_jiemian271462.x = 271;
            ui_zhuangshixianquan02_jiemian271462.y = 462;
            ui_zhuangshixianquan02_jiemian271462.width = 682;
            ui_zhuangshixianquan02_jiemian271462.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian271462);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian271100Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian2711009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian271100Rect);
            ui_zhuangshixianquan02_jiemian271100 = new Scale9Image(ui_zhuangshixianquan02_jiemian2711009ScaleTexture);
            ui_zhuangshixianquan02_jiemian271100.x = 271;
            ui_zhuangshixianquan02_jiemian271100.y = 100;
            ui_zhuangshixianquan02_jiemian271100.width = 682;
            ui_zhuangshixianquan02_jiemian271100.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian271100);
            list_view = new List();
            list_view.x = 270;
            list_view.y = 140;
            list_view.width = 684;
            list_view.height = 281;
            this.addQuiackChild(list_view);
            texture = assetMgr.getTexture('ui_lan03_01_anniu');
            var return_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            return_Scale9Button = new Scale9Button(texture,return_Scale9ButtonRect);
            return_Scale9Button.x = 638;
            return_Scale9Button.y = 495;
            return_Scale9Button.width = 186;
            return_Scale9Button.height = 70;
            this.addQuiackChild(return_Scale9Button);
            return_Scale9Button.name = 'return_Scale9Button';
            return_Scale9Button.text= 'lable';
            return_Scale9Button.fontColor= 0xFFFFC9;
            return_Scale9Button.fontSize= 28;
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var replay_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            replay_Scale9Button = new Scale9Button(texture,replay_Scale9ButtonRect);
            replay_Scale9Button.x = 400;
            replay_Scale9Button.y = 495;
            replay_Scale9Button.width = 186;
            replay_Scale9Button.height = 70;
            this.addQuiackChild(replay_Scale9Button);
            replay_Scale9Button.name = 'replay_Scale9Button';
            replay_Scale9Button.text= 'lable';
            replay_Scale9Button.fontColor= 0xFFFFC9;
            replay_Scale9Button.fontSize= 28;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            list_view.dispose();
            super.dispose();
        
}
    }
}
