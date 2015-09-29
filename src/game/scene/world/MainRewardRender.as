package game.scene.world {
    import com.dialog.DialogMgr;

    import game.data.Goods;
    import game.data.HeroData;
    import game.manager.AssetMgr;
    import game.view.goodsGuide.EquipInfoDlg;
    import game.view.uitils.Res;
    import game.view.viewBase.MainRewardRenderBase;

    public class MainRewardRender extends MainRewardRenderBase {
        private var goods:Goods;

        public function MainRewardRender() {
            super();
            but_bg.container.addQuiackChild(icon)
            but_bg.container.addQuiackChild(quality)
            but_bg.container.addQuiackChild(txt_name);
            but_bg.container.addChild(hun);
            hun.touchable = false;
            hun.visible = false;
        }

        override public function set data(value:Object):void {
            super.data = value;
            goods = value as Goods;
            if (goods) {
                if (goods.type < 40000 && goods.type > 30000) {
                    hun.visible = true;
                    var hero:HeroData = HeroData.hero.getValue(goods.type) as HeroData;
                    icon.texture = Res.instance.getHeroIconTexture(hero.show);
                } else {
                    hun.visible = false;
                    icon.texture = AssetMgr.instance.getTexture(goods.picture);
                }

                if (goods.type > 30000 && goods.type < 40000 || goods.type < 100 && goods.type != 5) {
                    quality.texture = Res.instance.getQualityToolTexture(0);
                } else {
                    quality.texture = Res.instance.getQualityToolTexture(goods.quality);
                }
                txt_name.text = goods.name;
            }
        }

        override public function set isSelected(value:Boolean):void {
            if (value) {
                var goods:Goods = data as Goods;
                goods = goods.clone() as Goods;
                goods.drop_location = "";
                goods.Price = 0;
                goods.isPack = false;
                DialogMgr.instance.isVisibleDialogs(true);
                DialogMgr.instance.open(EquipInfoDlg, goods);
            }
        }
    }
}
