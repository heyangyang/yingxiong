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
    import com.view.View;

    public class VipInfoViewBase extends View
    {
        public var btn_left:Button;
        public var btn_right:Button;
        public var list_vip:List;

        public function VipInfoViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_xiangzuotishi01_anniu');
            btn_left = new Button(texture);
            btn_left.name= 'btn_left';
            btn_left.y = 113;
            btn_left.width = 68;
            btn_left.height = 109;
            this.addQuiackChild(btn_left);
            texture = assetMgr.getTexture('ui_xiangzuotishi01_anniu');
            btn_right = new Button(texture);
            btn_right.name= 'btn_right';
            btn_right.x = 960;
            btn_right.y = 113;
            btn_right.width = 68;
            btn_right.height = 109;
            this.addQuiackChild(btn_right);
            list_vip = new List();
            list_vip.x = 100;
            list_vip.width = 760;
            list_vip.height = 335;
            this.addQuiackChild(list_vip);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btn_left.dispose();
            btn_right.dispose();
            list_vip.dispose();
            super.dispose();
        
}
    }
}
