package game.view.activity.activity.AllGifts {
    import com.utils.ObjectUtil;

    import flash.geom.Point;

    import game.data.FestPrizeData;
    import game.data.Goods;
    import game.data.HeroData;
    import game.data.RoleShow;
    import game.manager.AssetMgr;
    import game.view.uitils.Res;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.textures.Texture;

    /**
     *
     * @author Administrator
     *
     */
    public class Box extends Sprite {
        private var point:Point = new Point(23, 260);
        private var box:Image;
        private var qualityDi:Image = null;

        public function Box(texture:Texture) {
            box = new Image(texture);
            addChild(box);

            this.x = point.x;
            this.y = point.y;
        }

        public function set data(data:FestPrizeData):void {
            var type:int = data.ReceiveType;
            var num:int = data.num;
            var image:Image;
            var texture:Texture;

            if (qualityDi == null) {
                qualityDi = new Image(Res.instance.getQualityToolTexture(0));
                this.addQuiackChildAt(qualityDi, 0);
            }

            switch (type) {
                case 1:
                    texture = Res.instance.getCommTexture(10);
                    break;
                case 2:
                    texture = Res.instance.getCommTexture(11);
                    break;
                case 3:
                    texture = Res.instance.getCommTexture(12);
                    break;
                case 5:
                    var heroData:HeroData = HeroData.hero.getValue(type);
                    var photo:String = (RoleShow.hash.getValue(heroData.show) as RoleShow).photo;
                    box.texture = Res.instance.getQualityHeroTexture(heroData.quality);
                    texture = AssetMgr.instance.getTexture(photo);
                    break;
                case 7:
                    texture = AssetMgr.instance.getTexture("ui_tili01_tubiao");
                    break;
                default:
                    var goods:Goods = Goods.goods.getValue(type);
                    texture = AssetMgr.instance.getTexture(goods.picture);
                    box.texture = Res.instance.getQualityToolTexture(goods.quality);
                    break;
            }
            image = new Image(texture);
            image.x = (qualityDi.width - image.width) >> 1;
            image.y = (qualityDi.height - image.height) >> 1;
            addChild(image);

            var text:TextField = new TextField(80, 35, "", "", 21, 0xffffff);
            text.hAlign = 'right';
            text.y = 50;
            text.text = "x " + data.num;
            addChild(text);
        }
        private var state:Image;
        public var stuate:int;

        public function set stuat(value:int):void {
            stuate = value;
        /*var texture:Texture;

        if(value == 0)
        {
            texture = AssetMgr.instance.getTexture("");
        }
        else if(value == 1)
        {
            texture = AssetMgr.instance.getTexture("ui_gongyong_jianglilingqu");
        }
        else if(value == 2)
        {
            texture = AssetMgr.instance.getTexture("ui_reward_yilingqu");
        }
        if(state)
        {
            state .texture = texture;
        }
        else
        {
            state = new Image(texture);
            addChild(state);
            ObjectUtil.setToCenter(box,state);
        }*/
        }

        public function addStuat():void {
            var texture:Texture;
            stuate = 2;
            texture = AssetMgr.instance.getTexture("ui_reward_yilingqu");
            state = new Image(texture);
            addChild(state);
            ObjectUtil.setToCenter(box, state);
        }
    }
}
