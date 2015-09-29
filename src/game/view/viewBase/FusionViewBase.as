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
    import game.view.blacksmith.render.EquipRender;
    import game.view.blacksmith.view.EquipViewBase;

    public class FusionViewBase extends EquipViewBase
    {
        public var fusion_equipGrid:EquipRender;
        public var list_equip:List;

        public function FusionViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            fusion_equipGrid = new EquipRender();
            fusion_equipGrid.x = 155;
            fusion_equipGrid.y = 186;
            this.addQuiackChild(fusion_equipGrid);
            texture =assetMgr.getTexture('ui_background_intensify_indicate1');
            image = new Image(texture);
            image.x = 175;
            image.y = 112;
            image.width = 53;
            image.height = 61;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            list_equip = new List();
            list_equip.width = 425;
            list_equip.height = 127;
            this.addQuiackChild(list_equip);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            fusion_equipGrid.dispose();
            list_equip.dispose();
            super.dispose();
        
}
    }
}
