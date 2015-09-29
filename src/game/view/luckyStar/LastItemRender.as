package game.view.luckyStar {
    import com.langue.Langue;

    import feathers.controls.renderers.DefaultListItemRenderer;

    import game.data.Goods;
    import game.data.LuckyStarData;
    import game.data.WidgetData;
    import game.net.data.vo.RebateRank;
    import game.view.viewBase.LastItemRenderBase;

    public class LastItemRender extends DefaultListItemRenderer {
        private var skin:LastItemRenderBase = new LastItemRenderBase;

        public function LastItemRender() {
            defaultSkin = skin;
            skin.bgImage.alpha = 0.5;
            setSize(504, 30);
        }

        override public function set data(value:Object):void {
            if (!value) {
                return;
            }
            skin.nameTxt.text = (value as RebateRank).name;
            var id:int = (value as RebateRank).reward_id;
            var vect:Vector.<LuckyStarData> = StarData.instance.goodsList;

            if (id == 1) {
                skin.awardTxt.text = Langue.getLangue("buyMoney") + " x " + (value as RebateRank).reward_num; //金币
            } else if (id == 2) {
                skin.awardTxt.text = Langue.getLangue("buyDiamond") + " x " + (value as RebateRank).reward_num; //钻石
            } else if (id == 3) {
                skin.awardTxt.text = Langue.getLangue("buyDiamond_Rebates") + " x " + (value as RebateRank).reward_num; //钻石返利
            } else if (id == 5) {
                skin.awardTxt.text = Langue.getLangue("Hero") + " x " + (value as RebateRank).reward_num; //英雄
            } else {
                var widget:WidgetData = new WidgetData(Goods.goods.getValue(id));
                skin.awardTxt.text = widget.name + " x " + (value as RebateRank).reward_num;
            }
            super.data = value;
        }
    }
}

