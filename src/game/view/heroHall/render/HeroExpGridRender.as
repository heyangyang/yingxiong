package game.view.heroHall.render {
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

    import game.data.Goods;
    import game.data.WidgetData;
    import game.view.uitils.Res;
    import game.view.viewBase.HeroExpGridRenderBase;

    import starling.events.Event;

    public class HeroExpGridRender extends HeroExpGridRenderBase {
        public function HeroExpGridRender() {
            super();
            btn_bg.addEventListener(Event.TRIGGERED, onClick);
            btn_bg.container.addQuiackChild(icon);
            btn_bg.container.addQuiackChild(quality);
            btn_bg.container.addQuiackChild(txt_add);
            btn_bg.container.addQuiackChild(txt_count);
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (value == null) {
                return;
            }
            var goods:Goods = value as Goods;
            icon.texture = Res.instance.getGoodIconTexture(goods.type);
            if (goods.type < 100 && goods.type != 5) {
                quality.texture = Res.instance.getQualityToolTexture(0);
            } else {
                quality.texture = Res.instance.getQualityToolTexture(goods.quality);
            }
            txt_add.text = "+" + goods.magicIndex;
            var count:int = WidgetData.pileByType(goods.type);
            txt_count.text = "x " + count;
            txt_count.color = count == 0 ? 0xff0000 : 0xffffff;
        }

        private function onClick():void {
            ViewDispatcher.dispatch(EventType.USE_EXP, data);
        }
    }
}
