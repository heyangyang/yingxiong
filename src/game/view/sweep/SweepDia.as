package game.view.sweep {
    import com.langue.Langue;

    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.net.data.IData;
    import game.net.data.s.SSweep;
    import game.net.data.vo.sweepResultVOS;
    import game.view.sweep.Render.SweepCarryOutView;
    import game.view.viewBase.SweepDiaBase;

    import starling.core.Starling;
    import starling.events.Event;

    public class SweepDia extends SweepDiaBase {
        private var sweepArr:Vector.<IData> = null;
        private var dataProvider1:Vector.<sweepResultVOS> = null;
        private var index:int = 0;
        public var gold:int = 0;

        public function SweepDia() {
            super();
        }

        override protected function init():void {
            setToCenter();
            clickBackroundClose();
            ok_Scale9Button.text = Langue.getLangue("Carry_on_Go_sweep");

            //扫荡掉落物品
            const layout:TiledRowsLayout = new TiledRowsLayout();
            layout.gap = 10;
            layout.useSquareTiles = false; //是否正方形显示
            layout.useVirtualLayout = true; //是否重用
            layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
            list_CarryOut.layout = layout;
            list_CarryOut.itemRendererFactory = itemRendererFactory;
        }

        private function itemRendererFactory():SweepCarryOutView {
            const renderer:SweepCarryOutView = new SweepCarryOutView();
            renderer.setSize(512, 418);
            return renderer;
        }

        override protected function show():void {
            gold = _parameter.data.tollgateData.gold; //金币
            var sweepData:SSweep = _parameter.sweep as SSweep;
            sweepArr = sweepData.sweepResult; //sweepResultVOS
            dataProvider1 = new Vector.<sweepResultVOS>;
            index = 0;
            sweepdHandler();
        }

        private function sweepdHandler():void {
            var len:int = sweepArr.length;
            index++;
            if (len > 0) {
                Starling.juggler.delayCall(function():void {
                    var _sweepResultVos:sweepResultVOS = sweepArr[0] as sweepResultVOS;
                    dataProvider1.push(_sweepResultVos);
                    list_CarryOut.dataProvider = new ListCollection(dataProvider1);
                    list_CarryOut.scrollToPageIndex(0, index);
                    sweepArr.splice(0, 1);
                    sweepdHandler();
                }, 0.5);
            }
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            addViewListener(ok_Scale9Button, Event.TRIGGERED, onTriggered);
        }

        private function onTriggered():void {
            close();
        }
    }
}
