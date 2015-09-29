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

    public class EmbattleShowItemBase extends View
    {
        public var bg:Button;
        public var wenzi:Image;
        public var head:Image;
        public var hero:Image;

        public function EmbattleShowItemBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_daojukuangdi');
            bg = new Button(texture);
            bg.name= 'bg';
            bg.x = 1;
            bg.y = 1;
            bg.width = 98;
            bg.height = 98;
            this.addQuiackChild(bg);
            texture = assetMgr.getTexture('ui_weizhiqian_wenzi')
            wenzi = new Image(texture);
            wenzi.x = 27;
            wenzi.y = 27;
            wenzi.width = 47;
            wenzi.height = 46;
            this.addQuiackChild(wenzi);
            wenzi.touchable = false;
            texture = assetMgr.getTexture('photo_100')
            head = new Image(texture);
            head.x = 2;
            head.y = 2;
            head.width = 96;
            head.height = 96;
            this.addQuiackChild(head);
            head.touchable = false;
            texture = assetMgr.getTexture('ui_touxiangkuang_01')
            hero = new Image(texture);
            hero.width = 100;
            hero.height = 100;
            this.addQuiackChild(hero);
            hero.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            bg.dispose();
            super.dispose();
        
}
    }
}
