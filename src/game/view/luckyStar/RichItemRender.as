package game.view.luckyStar {
    import com.langue.Langue;

    import feathers.controls.renderers.DefaultListItemRenderer;

    import game.net.data.vo.LuckRank;
    import game.view.viewBase.RichItemRenderBase;

    public class RichItemRender extends DefaultListItemRenderer {
        private var skin:RichItemRenderBase = new RichItemRenderBase;

        public function RichItemRender() {
            this.defaultSkin = skin;
            skin.touchable = false;
            skin.bgImage.alpha = 0.5;
            setSize(504, 33);
        }

        override public function set data(value:Object):void {
            if (!value) {
                super.data = value;
                skin.nameTxt.text = Langue.getLangue("Name"); //名字
                skin.starTxt.text = Langue.getLangue("buyLucky"); //幸运星
                skin.valuesTxt.text = Langue.getLangue("The_Total_Value"); //总价值
                return;
            }
            skin.nameTxt.text = (value as LuckRank).name;
            skin.starTxt.text = (value as LuckRank).sum + "";
            skin.valuesTxt.text = (value as LuckRank).values + "";
            super.data = value;
        }
    }
}

