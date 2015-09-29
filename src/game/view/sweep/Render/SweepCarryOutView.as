package game.view.sweep.Render {
    import com.dialog.DialogMgr;
    import com.langue.Langue;

    import feathers.controls.Scroller;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.data.Goods;
    import game.net.data.vo.sweepResultVOS;
    import game.view.sweep.SweepDia;
    import game.view.viewBase.SweepCarryOutViewBase;

    public class SweepCarryOutView extends SweepCarryOutViewBase {
        public function SweepCarryOutView() {
            super();
            init();
        }

        private function init():void {
            const layoutResu:TiledRowsLayout = new TiledRowsLayout();
            layoutResu.horizontalGap = 2;
            layoutResu.useSquareTiles = false;
            layoutResu.useVirtualLayout = true;
            layoutResu.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layoutResu.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            layoutResu.paging = TiledRowsLayout.PAGING_HORIZONTAL;
            list_results.layout = layoutResu;
            list_results.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_results.horizontalScrollPolicy = Scroller.SCROLL_POLICY_ON;
            list_results.itemRendererFactory = tileListItemRendererFactory;

            const layoutCarry:TiledRowsLayout = new TiledRowsLayout();
            layoutCarry.horizontalGap = 2;
            layoutCarry.useSquareTiles = false;
            layoutCarry.useVirtualLayout = true;
            layoutCarry.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layoutCarry.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            layoutCarry.paging = TiledRowsLayout.PAGING_HORIZONTAL;
            list_carry.layout = layoutCarry;
            list_carry.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_carry.horizontalScrollPolicy = Scroller.SCROLL_POLICY_ON;
            list_carry.itemRendererFactory = tileListItemRendererFactorys;
        }

        private function tileListItemRendererFactory():SweepResultItemRender {
            var itemRender:SweepResultItemRender = new SweepResultItemRender();
            itemRender.setSize(98, 98);
            return itemRender;
        }

        private function tileListItemRendererFactorys():SweepCarryOutItemRender {
            var itemRender:SweepCarryOutItemRender = new SweepCarryOutItemRender();
            itemRender.setSize(98, 98);
            return itemRender;
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (value == null) {
                return;
            }

            var dialog:SweepDia = DialogMgr.instance.getDlg(SweepDia) as SweepDia;
            text_chip.text = dialog.gold.toString();

            var sweepResult:sweepResultVOS = value as sweepResultVOS;
            text_round.text = Langue.getLans("the_war_raids")[0].replace("*", sweepResult.nth); //第几次扫荡
            text_reward.text = Langue.getLans("the_war_raids")[1].replace("*", sweepResult.nth); //额外奖励
            var arr:Vector.<Goods> = new Vector.<Goods>;
            var arr1:Vector.<Goods> = new Vector.<Goods>;
            var goods:Goods = null;
            for each (var type:int in sweepResult.sweepResult) {
                goods = Goods.goods.getValue(type);
                arr.push(goods.clone());
            }
            list_results.dataProvider = new ListCollection(arr);

            for each (var type1:int in sweepResult.sweepResultExtra) {
                goods = Goods.goods.getValue(type1);
                arr1.push(goods.clone());
            }
            list_carry.dataProvider = new ListCollection(arr1);
        }

    }
}
