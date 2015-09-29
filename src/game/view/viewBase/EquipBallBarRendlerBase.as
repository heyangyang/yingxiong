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

    public class EquipBallBarRendlerBase extends View
    {
        public var bg_0:Image;
        public var bg_1:Image;
        public var bg_2:Image;
        public var bg_3:Image;
        public var bg_4:Image;
        public var ad_0:Image;
        public var ad_1:Image;
        public var ad_2:Image;
        public var ad_3:Image;
        public var ad_4:Image;
        public var no_0:Image;
        public var no_1:Image;
        public var no_2:Image;
        public var no_3:Image;
        public var no_4:Image;

        public function EquipBallBarRendlerBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_xiangqiancaodi02_01')
            bg_0 = new Image(texture);
            bg_0.width = 52;
            bg_0.height = 52;
            this.addQuiackChild(bg_0);
            bg_0.touchable = false;
            texture = assetMgr.getTexture('ui_xiangqiancaodi02_01')
            bg_1 = new Image(texture);
            bg_1.x = 53;
            bg_1.width = 52;
            bg_1.height = 52;
            this.addQuiackChild(bg_1);
            bg_1.touchable = false;
            texture = assetMgr.getTexture('ui_xiangqiancaodi02_01')
            bg_2 = new Image(texture);
            bg_2.x = 104;
            bg_2.width = 52;
            bg_2.height = 52;
            this.addQuiackChild(bg_2);
            bg_2.touchable = false;
            texture = assetMgr.getTexture('ui_xiangqiancaodi02_01')
            bg_3 = new Image(texture);
            bg_3.x = 156;
            bg_3.width = 52;
            bg_3.height = 52;
            this.addQuiackChild(bg_3);
            bg_3.touchable = false;
            texture = assetMgr.getTexture('ui_xiangqiancaodi02_01')
            bg_4 = new Image(texture);
            bg_4.x = 208;
            bg_4.width = 52;
            bg_4.height = 52;
            this.addQuiackChild(bg_4);
            bg_4.touchable = false;
            texture = assetMgr.getTexture('ui_zengjia02_anniu')
            ad_0 = new Image(texture);
            ad_0.x = 58;
            ad_0.y = 5;
            ad_0.width = 42;
            ad_0.height = 42;
            this.addQuiackChild(ad_0);
            ad_0.touchable = false;
            texture = assetMgr.getTexture('ui_zengjia02_anniu')
            ad_1 = new Image(texture);
            ad_1.x = 213;
            ad_1.y = 5;
            ad_1.width = 42;
            ad_1.height = 42;
            this.addQuiackChild(ad_1);
            ad_1.touchable = false;
            texture = assetMgr.getTexture('ui_zengjia02_anniu')
            ad_2 = new Image(texture);
            ad_2.x = 5;
            ad_2.y = 5;
            ad_2.width = 42;
            ad_2.height = 42;
            this.addQuiackChild(ad_2);
            ad_2.touchable = false;
            texture = assetMgr.getTexture('ui_zengjia02_anniu')
            ad_3 = new Image(texture);
            ad_3.x = 109;
            ad_3.y = 5;
            ad_3.width = 42;
            ad_3.height = 42;
            this.addQuiackChild(ad_3);
            ad_3.touchable = false;
            texture = assetMgr.getTexture('ui_zengjia02_anniu')
            ad_4 = new Image(texture);
            ad_4.x = 161;
            ad_4.y = 5;
            ad_4.width = 42;
            ad_4.height = 42;
            this.addQuiackChild(ad_4);
            ad_4.touchable = false;
            texture = assetMgr.getTexture('ui_bukaifang')
            no_0 = new Image(texture);
            no_0.x = 5;
            no_0.y = 5;
            no_0.width = 42;
            no_0.height = 42;
            this.addQuiackChild(no_0);
            no_0.touchable = false;
            texture = assetMgr.getTexture('ui_bukaifang')
            no_1 = new Image(texture);
            no_1.x = 58;
            no_1.y = 5;
            no_1.width = 42;
            no_1.height = 42;
            this.addQuiackChild(no_1);
            no_1.touchable = false;
            texture = assetMgr.getTexture('ui_bukaifang')
            no_2 = new Image(texture);
            no_2.x = 109;
            no_2.y = 5;
            no_2.width = 42;
            no_2.height = 42;
            this.addQuiackChild(no_2);
            no_2.touchable = false;
            texture = assetMgr.getTexture('ui_bukaifang')
            no_3 = new Image(texture);
            no_3.x = 213;
            no_3.y = 5;
            no_3.width = 42;
            no_3.height = 42;
            this.addQuiackChild(no_3);
            no_3.touchable = false;
            texture = assetMgr.getTexture('ui_bukaifang')
            no_4 = new Image(texture);
            no_4.x = 161;
            no_4.y = 5;
            no_4.width = 42;
            no_4.height = 42;
            this.addQuiackChild(no_4);
            no_4.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
