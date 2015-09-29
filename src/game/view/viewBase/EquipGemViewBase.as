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
    import game.view.blacksmith.render.EquipRender;
    import game.view.blacksmith.render.EquipGemRender;
    import game.view.blacksmith.view.EquipViewBase;

    public class EquipGemViewBase extends EquipViewBase
    {
        public var ico_weapon:EquipRender;
        public var gem0:EquipGemRender;
        public var gem1:EquipGemRender;
        public var gem2:EquipGemRender;
        public var gem3:EquipGemRender;
        public var gem4:EquipGemRender;

        public function EquipGemViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            ico_weapon = new EquipRender();
            ico_weapon.x = 9;
            ico_weapon.y = 80;
            this.addQuiackChild(ico_weapon);
            gem0 = new EquipGemRender();
            gem0.x = 115;
            this.addQuiackChild(gem0);
            gem1 = new EquipGemRender();
            gem1.x = 115;
            gem1.y = 56;
            this.addQuiackChild(gem1);
            gem2 = new EquipGemRender();
            gem2.x = 115;
            gem2.y = 108;
            this.addQuiackChild(gem2);
            gem3 = new EquipGemRender();
            gem3.x = 115;
            gem3.y = 164;
            this.addQuiackChild(gem3);
            gem4 = new EquipGemRender();
            gem4.x = 115;
            gem4.y = 220;
            this.addQuiackChild(gem4);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            ico_weapon.dispose();
            gem0.dispose();
            gem1.dispose();
            gem2.dispose();
            gem3.dispose();
            gem4.dispose();
            super.dispose();
        
}
    }
}
