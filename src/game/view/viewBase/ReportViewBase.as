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

    public class ReportViewBase extends View
    {
        public var list_hero:List;

        public function ReportViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            list_hero = new List();
            list_hero.x = 167;
            list_hero.y = 79;
            list_hero.width = 760;
            list_hero.height = 450;
            this.addQuiackChild(list_hero);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            list_hero.dispose();
            super.dispose();
        
}
    }
}
