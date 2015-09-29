package game.view.vip {
    import com.dialog.DialogMgr;

    import game.data.Goods;
    import game.data.HeroData;
    import game.manager.AssetMgr;
    import game.view.goodsGuide.EquipInfoDlg;
    import game.view.uitils.Res;
    import game.view.viewBase.VipRewardRenderBase;

    public class VipRewardRender extends VipRewardRenderBase {
        public function VipRewardRender() {
            super();
            setSize(98, 130);

            ico_goods.visible = false;
            bg.touchable = true;
            bg.container.addQuiackChild(ico_goods);
            bg.container.addQuiackChild(quality);
            bg.container.addQuiackChild(txt_name);
            bg.container.addQuiackChild(txt_num);
        }

        override public function set data(value:Object):void {
            super.data = value;

            if (value == null) {
                return;
            }

            if (value is Goods) {
                var goods:Goods = value as Goods;
                txt_name.text = goods.name;
                txt_num.text = "x " + goods.pile;
                ico_goods.texture = AssetMgr.instance.getTexture(goods.picture);
                if (goods.type < 100 && goods.type != 5) {
                    quality.texture = Res.instance.getQualityToolTexture(0);
                } else {
                    quality.texture = Res.instance.getQualityToolTexture(goods.quality);
                }
            } else if (value is HeroData) {
                var heroData:HeroData = value as HeroData;
                txt_name.text = heroData.name;
                txt_num.text = "x 1";
                ico_goods.texture = Res.instance.getHeroIconTexture(heroData.show);
                quality.texture = Res.instance.getQualityToolTexture(heroData.quality);
            }
            ico_goods.visible = true;
        }

        override public function set isSelected(value:Boolean):void {
            if (value) {
                var goods:Goods = data as Goods;
                goods = goods.clone() as Goods;
                goods.Price = 0;
                goods.isPack = false;
                DialogMgr.instance.isVisibleDialogs(true);
                DialogMgr.instance.open(EquipInfoDlg, goods);
            }
        }

    }
}
