package game.view.achievement {
    import feathers.controls.renderers.DefaultListItemRenderer;

    import game.common.JTLogger;
    import game.data.Attain;
    import game.data.Goods;
    import game.data.HeroData;
    import game.data.RoleShow;
    import game.data.WidgetData;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.net.data.vo.AttainInfo;
    import game.view.achievement.data.AchievementData;
    import game.view.uitils.Res;
    import game.view.viewBase.ListItemRenderBase;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.events.Event;

    public class TaskItemRender extends DefaultListItemRenderer {
        public var skin:ListItemRenderBase = new ListItemRenderBase;
        private var maxPar:int;
        private var action:SpriterClip;

        public function TaskItemRender() {
            super();
            defaultSkin = skin;
            for (var i:int = 0; i < skin.numChildren; i++) {
                skin.getChildAt(0).touchable = true;
            }
            setSize(747, 98);
        }

        override public function set data(value:Object):void {
            action && action.removeFromParent(true);
            if (!value) {
                return;
            }
            var info:AttainInfo = value as AttainInfo;
            var attainData:Attain = Attain.hash.getValue(info.id);
            if (attainData == null) {
                JTLogger.warn("找不到成就：" + info.id, info.type);
                return;
            }
            skin.bgImage.alpha = 0.5;
            skin.caption.text = attainData.caption;
            skin.title.text = attainData.name;
            skin.caption.touchable = true;
            skin.title.touchable = true;
            skin.okReceive.visible = true;
            skin.okReceive.touchable = true;
            skin.hun.visible = false;

            if (attainData.goodsType != 5) {
                skin.values.text = "x " + attainData.values;
            } else {
                skin.values.text = "x " + 1;
            }
            if (info.type != 0) {
                action = AnimationCreator.instance.create("effect_012", AssetMgr.instance);
                action.play("effect_012");
                action.animation.looping = true;
                Starling.juggler.add(action);
                action.x = skin.quality.x + (skin.quality.width >> 1);
                action.y = skin.quality.y + (skin.quality.height >> 1);
                addQuiackChild(action);
                action.touchable = false;
            } else {
                skin.okReceive.visible = false;
            }

            if (attainData.goodsType == 2) {
                skin.goodsIcon.texture = Res.instance.getCommTexture(11); //ui_tubiao_zuanshi_da
            } else if (attainData.goodsType == 1) {
                skin.goodsIcon.texture = Res.instance.getCommTexture(10); //ui_tubiao_jinbi_da
            } else if (attainData.goodsType == 3) {
                skin.goodsIcon.texture = Res.instance.getCommTexture(12); //icon_3
            } else if (attainData.goodsType == 5) {
                var type:int = attainData.values;
                var heroData:HeroData = (HeroData.hero.getValue(type) as HeroData);
                var photo:String = (RoleShow.hash.getValue(heroData.show) as RoleShow).photo;
                skin.goodsIcon.texture = AssetMgr.instance.getTexture(photo);
                if (attainData.goodsType < 100 && attainData.goodsType != 5) {
                    skin.quality.texture = Res.instance.getCardIconTexture(0);
                } else {
                    skin.quality.texture = Res.instance.getCardIconTexture(heroData.quality);
                }
            } else {
                var d:WidgetData = new WidgetData(Goods.goods.getValue(attainData.goodsType));
                if (d.type < 40000 && d.type > 30000) {
                    var hd:HeroData = HeroData.hero.getValue(d.type) as HeroData;
                    skin.goodsIcon.texture = Res.instance.getHeroIconTexture(hd.show);
                    skin.hun.visible = true;
                } else {
                    skin.hun.visible = false;
                    skin.goodsIcon.texture = AssetMgr.instance.getTexture(d.picture);
                }

                if (d.type > 30000 && d.type < 40000 || d.type < 100 && d.type != 5) {
                    skin.quality.texture = Res.instance.getQualityToolTexture(0);
                } else {
                    skin.quality.texture = Res.instance.getQualityToolTexture(d.quality);
                }
            }
            var total:int = AchievementData.instance.total(attainData.conditionType);
            var currentIndex:int = AchievementData.instance.currentIndex(info.id);
            super.data = value;
        }

        override public function set isSelected(value:Boolean):void {
            super.isSelected = value;
            owner.dispatchEventWith(Event.SELECT);
        }

        override public function dispose():void {
            action && action.removeFromParent(true);
            skin && skin.removeFromParent(true);
            super.dispose();
        }
    }
}
