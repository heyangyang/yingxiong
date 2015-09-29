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

    public class HeroCardShowBase extends View
    {
        public var heroCard:Image;
        public var heroName:TextField;
        public var job:Image;
        public var star_0:Image;
        public var star_4:Image;
        public var star_3:Image;
        public var star_2:Image;
        public var star_1:Image;

        public function HeroCardShowBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_renwukapai_01')
            heroCard = new Image(texture);
            heroCard.width = 216;
            heroCard.height = 279;
            this.addQuiackChild(heroCard);
            heroCard.touchable = false;
            heroName = new TextField(196,31,'','',24,0xffffff,false);
            heroName.touchable = false;
            heroName.hAlign= 'center';
            heroName.text= '';
            heroName.x = 10;
            heroName.y = 239;
            this.addQuiackChild(heroName);
            texture = assetMgr.getTexture('ui_texingtubiao_01')
            job = new Image(texture);
            job.x = 11;
            job.y = 11;
            job.width = 28;
            job.height = 28;
            this.addQuiackChild(job);
            job.touchable = false;
            texture = assetMgr.getTexture('ui_xingyunxing02_tubiao')
            star_0 = new Image(texture);
            star_0.x = 58;
            star_0.y = 12;
            star_0.width = 25;
            star_0.height = 26;
            this.addQuiackChild(star_0);
            star_0.touchable = false;
            texture = assetMgr.getTexture('ui_xingyunxing02_tubiao')
            star_4 = new Image(texture);
            star_4.x = 166;
            star_4.y = 12;
            star_4.width = 25;
            star_4.height = 26;
            this.addQuiackChild(star_4);
            star_4.touchable = false;
            texture = assetMgr.getTexture('ui_xingyunxing02_tubiao')
            star_3 = new Image(texture);
            star_3.x = 139;
            star_3.y = 12;
            star_3.width = 25;
            star_3.height = 26;
            this.addQuiackChild(star_3);
            star_3.touchable = false;
            texture = assetMgr.getTexture('ui_xingyunxing02_tubiao')
            star_2 = new Image(texture);
            star_2.x = 112;
            star_2.y = 12;
            star_2.width = 25;
            star_2.height = 26;
            this.addQuiackChild(star_2);
            star_2.touchable = false;
            texture = assetMgr.getTexture('ui_xingyunxing02_tubiao')
            star_1 = new Image(texture);
            star_1.x = 85;
            star_1.y = 12;
            star_1.width = 25;
            star_1.height = 26;
            this.addQuiackChild(star_1);
            star_1.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
