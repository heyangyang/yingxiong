package game.view.goodsGuide.view {
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

    import game.data.Goods;
    import game.data.HeroData;
    import game.data.WidgetData;
    import game.manager.AssetMgr;
    import game.view.uitils.Res;
    import game.view.viewBase.GoodsGuideGridBase;

    public class GoodsGuideGrid extends GoodsGuideGridBase {
        public function GoodsGuideGrid() {
            super();
            hun.visible = false;
            ico_equip.visible = false;
            but_bg.container.addChild(ico_equip);
            but_bg.container.addChild(ico_quality);
            but_bg.container.addChild(txt_name);
            but_bg.container.addChild(txt_level);
            but_bg.container.addChild(hun);
        }

        override public function set data(value:Object):void {
            super.data = value;

            if (value == null) {
                return;
            }
            var goods:Goods = value as Goods;
            var hasCount:int = WidgetData.pileByType(goods.type);
            txt_name.text = hasCount + "/" + goods.need_FusionCount;
            txt_name.color = hasCount >= goods.need_FusionCount ? 0x00ff00 : 0xff0000;

            if (goods.type > 30000 && goods.type < 40000) {
                var hero:HeroData = HeroData.hero.getValue(goods.type) as HeroData;
                ico_equip.texture = Res.instance.getHeroIconTexture(hero.show);
                hun.visible = true;
            } else {
                ico_equip.texture = AssetMgr.instance.getTexture(goods.picture);
                hun.visible = false;
            }
            ico_equip.visible = true;

            if (goods.type > 30000 && goods.type < 40000 || goods.type < 100 && goods.type != 5) {
                ico_quality.texture = Res.instance.getQualityToolTexture(0);
            } else {
                ico_quality.texture = Res.instance.getQualityToolTexture(goods.quality);
            }
        }

        override public function set isSelected(value:Boolean):void {
            value && ViewDispatcher.dispatch(EventType.SELECTED_GOODS_GUIDE, this);
        }

    }
}
