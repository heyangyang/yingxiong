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

    public class GoodsGuideListBase extends View
    {
        public var ui_tipstanchukuangdi01_jiemian00:Scale9Image;
        public var list_equip:List;

        public function GoodsGuideListBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var ui_tipstanchukuangdi01_jiemian00Rect:Rectangle = new Rectangle(48,46,44,43);
            var ui_tipstanchukuangdi01_jiemian009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_tipstanchukuangdi01_jiemian00Rect);
            ui_tipstanchukuangdi01_jiemian00 = new Scale9Image(ui_tipstanchukuangdi01_jiemian009ScaleTexture);
            ui_tipstanchukuangdi01_jiemian00.width = 408;
            ui_tipstanchukuangdi01_jiemian00.height = 570;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian00);
            list_equip = new List();
            list_equip.x = 34;
            list_equip.y = 48;
            list_equip.width = 340;
            list_equip.height = 470;
            this.addQuiackChild(list_equip);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            list_equip.dispose();
            super.dispose();
        
}
    }
}
