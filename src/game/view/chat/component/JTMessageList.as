package game.view.chat.component {

    import feathers.controls.IScrollBar;
    import feathers.controls.List;
    import feathers.controls.ScrollBar;
    import feathers.controls.Scroller;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import starling.core.Starling;

    /**
     *聊天显示列表
     * @author lfr
     */
    public class JTMessageList extends List {
        public function JTMessageList() {
            super();
            initliaze();
        }

        public function initliaze():void {
            const listLayout:TiledRowsLayout = new TiledRowsLayout();
            listLayout.gap = 1;
            listLayout.paddingBottom = 4;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.verticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_BOTTOM;
            this.x = 175;
            this.y = 74;
            this.width = 738;
            this.height = 455;
            this.layout = listLayout;
            this.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            this.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
            this.itemRendererFactory = tileListItemRendererFactory;
        }

        private function getScrollBarFactory():IScrollBar {
            return new ScrollBar() as IScrollBar;
        }

        private function tileListItemRendererFactory():IListItemRenderer {
            var txt:JTTextField = new JTTextField();
            txt.setSize(738, 35);
            return txt;
        }

        public function restItemRender(str:String):void {
            if (!dataProvider) {
                dataProvider = new ListCollection();
            }

            if (!str) {
                dataProvider = new ListCollection();
                return;
            }

            if (str.length == 0 || str == "") {
                return;
            }
            dataProvider.addItem(str);

            if (dataProvider.length > 200) {
                dataProvider.removeItemAt(0);
            }

            if (dataProvider.length >= 14) {
                this.updateScrollBar();
            }
        }

        protected function refreshHeroList():void {
            Starling.juggler.delayCall(function():void {
                if (!dataProvider) {
                    return;
                }
                if (dataProvider.length > 100) {
                    throwToPage(0, -1, 0);
                } else {
                    throwToPage(1, -1, 0);
                }
            }, 0.03);
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}
