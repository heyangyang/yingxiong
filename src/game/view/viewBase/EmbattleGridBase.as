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
    import com.view.View;

    public class EmbattleGridBase extends View
    {
        public var empty_ico:Button;
        public var btn_add:Button;
        public var addIamge:Image;

        public function EmbattleGridBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_zhuangshixianquan04_jiemian');
            empty_ico = new Button(texture);
            empty_ico.name= 'empty_ico';
            empty_ico.width = 120;
            empty_ico.height = 90;
            this.addQuiackChild(empty_ico);
            texture = assetMgr.getTexture('ui_array_base_map');
            btn_add = new Button(texture);
            btn_add.name= 'btn_add';
            btn_add.x = 16;
            btn_add.y = 30;
            btn_add.width = 89;
            btn_add.height = 36;
            this.addQuiackChild(btn_add);
            texture = assetMgr.getTexture('ui_wenzi_tianjiayingxiong')
            addIamge = new Image(texture);
            addIamge.x = 38;
            addIamge.y = 32;
            addIamge.width = 44;
            addIamge.height = 24;
            this.addQuiackChild(addIamge);
            addIamge.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            empty_ico.dispose();
            btn_add.dispose();
            super.dispose();
        
}
    }
}
