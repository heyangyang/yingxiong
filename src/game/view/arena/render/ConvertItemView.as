package game.view.arena.render {
    import game.data.WidgetData;
    import game.view.uitils.Res;
    import game.view.viewBase.ConvertItemViewBase;

    public class ConvertItemView extends ConvertItemViewBase {
        public function ConvertItemView() {
            super();
            bgImage0.alpha = bgImage1.alpha = 0.5;
            bg.container.addChild(ico);
            bg.container.addChild(head);
            bg.container.addChild(hun);
            ico.x = (head.width - ico.width) >> 1;
            ico.y = (head.height - ico.height) >> 1;
            head.x = head.y = 0;
            hun.visible = false;
            hun.x = 57;
            hun.y = 10;
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (!value) {
                return;
            }
            var widgetData:WidgetData = value.widget as WidgetData;
            ico.texture = Res.instance.getGoodIconTexture(widgetData.type);
            if (widgetData.type > 30000 && widgetData.type < 40000 || widgetData.type < 100 && widgetData.type != 5) {
                head.texture = Res.instance.getQualityToolTexture(0);
            } else {
                head.texture = Res.instance.getQualityToolTexture(widgetData.quality);
            }
            txtFightNum.text = value.price + "";
            txtName.text = widgetData.name;

            if (widgetData.type > 30000 && widgetData.type < 40000) {
                hun.visible = true;
            } else {
                hun.visible = false;
            }
        }
    }
}
