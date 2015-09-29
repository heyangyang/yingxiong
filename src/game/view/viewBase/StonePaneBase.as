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

    public class StonePaneBase extends View
    {
        public var ui_zhuangshixianquan02_jiemian0361:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian034:Scale9Image;
        public var title:TextField;
        public var list_stone:List;
        public var cancelScale9Button:Scale9Button;

        public function StonePaneBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian0361Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian03619ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian0361Rect);
            ui_zhuangshixianquan02_jiemian0361 = new Scale9Image(ui_zhuangshixianquan02_jiemian03619ScaleTexture);
            ui_zhuangshixianquan02_jiemian0361.y = 361;
            ui_zhuangshixianquan02_jiemian0361.width = 336;
            ui_zhuangshixianquan02_jiemian0361.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian0361);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian034Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian0349ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian034Rect);
            ui_zhuangshixianquan02_jiemian034 = new Scale9Image(ui_zhuangshixianquan02_jiemian0349ScaleTexture);
            ui_zhuangshixianquan02_jiemian034.y = 34;
            ui_zhuangshixianquan02_jiemian034.width = 336;
            ui_zhuangshixianquan02_jiemian034.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian034);
            title = new TextField(102,32,'','',24,0xffffff,false);
            title.touchable = false;
            title.hAlign= 'center';
            title.text= '';
            title.x = 117;
            this.addQuiackChild(title);
            list_stone = new List();
            list_stone.x = 11;
            list_stone.y = 41;
            list_stone.width = 315;
            list_stone.height = 310;
            this.addQuiackChild(list_stone);
            texture = assetMgr.getTexture('ui_hong02_01_anniu');
            var cancelScale9ButtonRect:Rectangle = new Rectangle(25,10,50,20);
            cancelScale9Button = new Scale9Button(texture,cancelScale9ButtonRect);
            cancelScale9Button.x = 88;
            cancelScale9Button.y = 375;
            cancelScale9Button.width = 150;
            cancelScale9Button.height = 39;
            this.addQuiackChild(cancelScale9Button);
            cancelScale9Button.name = 'cancelScale9Button';
            cancelScale9Button.text= 'lable';
            cancelScale9Button.fontColor= 0xffffff;
            cancelScale9Button.fontSize= 24;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            list_stone.dispose();
            super.dispose();
        
}
    }
}
