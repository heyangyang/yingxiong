package game.view.sweep.Render {
    import game.manager.AssetMgr;
    import game.view.uitils.Res;
    import game.view.viewBase.SweepItemRenderBase;

    public class SweepResultItemRender extends SweepItemRenderBase {
        public function SweepResultItemRender() {
            super();
            btn_bg.container.addChild(icon);
            icon.visible = false;
            btn_bg.container.addChild(quality);
            btn_bg.container.addChild(text_num);
            btn_bg.touchable = false;
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (value == null) {
                return;
            }
            if (value) {
                icon.visible = true;
                icon.texture = AssetMgr.instance.getTexture(value.picture);
                if (value.type < 100 && value.type != 5) {
                    quality.texture = Res.instance.getQualityToolTexture(0);
                } else {
                    quality.texture = Res.instance.getQualityToolTexture(value.quality);
                }
            }
        }
    }
}
