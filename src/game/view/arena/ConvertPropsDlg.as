package game.view.arena {
    import com.langue.Langue;

    import game.data.Goods;
    import game.net.message.GoodsMessage;
    import game.view.goodsGuide.EquipInfoDlg;

    public class ConvertPropsDlg extends EquipInfoDlg {
        public function ConvertPropsDlg() {
            super();
        }

        override protected function show():void {
            setToCenter();
            var labls:Array = Langue.getLans("arenaMenuText");
            var goods:Goods = _parameter.widget as Goods;
            view_goodsInfo.btnSwallow_Scale9Button.visible = false
            view_goodsInfo.data = goods;
            view_goodsInfo.btnok_Scale9Button.text = labls[2] + _parameter.money;
        }

        override protected function onChangeForgeViewHandler():void {
            var goods:Goods = _parameter.widget as Goods;
            GoodsMessage.onSendBuyPvpEquip(goods.type);
        }
    }
}
