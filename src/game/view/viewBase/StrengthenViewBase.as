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
    import game.view.blacksmith.render.StrengthenGrid;
    import game.view.blacksmith.view.EquipViewBase;

    public class StrengthenViewBase extends EquipViewBase
    {
        public var strengthen_grid:EquipRender;
        public var txt_rate:TextField;
        public var grid2:StrengthenGrid;
        public var txt_hp:TextField;
        public var txt_attack:TextField;
        public var grid1:StrengthenGrid;
        public var grid0:StrengthenGrid;
        public var txt_time:TextField;
        public var txt_des1:TextField;

        public function StrengthenViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            strengthen_grid = new EquipRender();
            strengthen_grid.x = 158;
            strengthen_grid.y = 126;
            this.addQuiackChild(strengthen_grid);
            txt_rate = new TextField(104,36,'','',24,0xFFFFCC,false);
            txt_rate.touchable = false;
            txt_rate.hAlign= 'center';
            txt_rate.text= '';
            txt_rate.x = 150;
            txt_rate.y = 273;
            this.addQuiackChild(txt_rate);
            grid2 = new StrengthenGrid();
            grid2.x = 306;
            grid2.y = 160;
            this.addQuiackChild(grid2);
            texture =assetMgr.getTexture('ui_text_chenggonglv');
            image = new Image(texture);
            image.x = 163;
            image.y = 249;
            image.width = 78;
            image.height = 27;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_tubiao_gongjilitubiao');
            image = new Image(texture);
            image.x = 286;
            image.y = 22;
            image.width = 20;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_tubiao_xueliangtubiao');
            image = new Image(texture);
            image.x = 280;
            image.y = 58;
            image.width = 34;
            image.height = 31;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_hp = new TextField(96,28,'','',22,0x4EF80F,false);
            txt_hp.touchable = false;
            txt_hp.hAlign= 'left';
            txt_hp.text= '';
            txt_hp.x = 316;
            txt_hp.y = 57;
            this.addQuiackChild(txt_hp);
            txt_attack = new TextField(94,28,'','',22,0x4EF80F,false);
            txt_attack.touchable = false;
            txt_attack.hAlign= 'left';
            txt_attack.text= '';
            txt_attack.x = 317;
            txt_attack.y = 22;
            this.addQuiackChild(txt_attack);
            grid1 = new StrengthenGrid();
            grid1.x = 6;
            grid1.y = 158;
            this.addQuiackChild(grid1);
            grid0 = new StrengthenGrid();
            grid0.x = 154;
            this.addQuiackChild(grid0);
            txt_time = new TextField(104,30,'','',20,0xFFFFCC,false);
            txt_time.touchable = false;
            txt_time.hAlign= 'left';
            txt_time.text= '';
            txt_time.x = 180;
            txt_time.y = 340;
            this.addQuiackChild(txt_time);
            txt_des1 = new TextField(151,65,'','',24,0x00FF00,false);
            txt_des1.touchable = false;
            txt_des1.hAlign= 'left';
            txt_des1.text= '';
            txt_des1.y = 22;
            this.addQuiackChild(txt_des1);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            strengthen_grid.dispose();
            grid2.dispose();
            grid1.dispose();
            grid0.dispose();
            super.dispose();
        
}
    }
}
