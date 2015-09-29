package game.view.userLog {
    import com.langue.Langue;
    import com.view.base.event.EventType;

    import feathers.controls.List;
    import feathers.controls.Scroller;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.dialog.ShowLoader;
    import game.utils.HttpServerList;
    import game.view.viewBase.ShowServerListDlgBase;

    import starling.events.Event;

    /**
             * 服务器列表
             * @author hyy
             *
             */
    public class ShowServerListDlg extends ShowServerListDlgBase {
        public function ShowServerListDlg() {
            super();
        }


        override protected function init():void {
            txt_des1.text = Langue.getLangue("Recently_Logged_erver");
            txt_des2.text = Langue.getLangue("Server_List");

            list_server.layout = getLayout();
            list_login.layout = getLayout();
            list_server.itemRendererFactory = itemRendererFactory;
            list_login.itemRendererFactory = itemRendererFactory;
            list_login.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_login.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;

            clickBackroundClose();
        }

        private function itemRendererFactory():IListItemRenderer {
            const renderer:ShowServerRender = new ShowServerRender();
            renderer.setSize(357, 69);
            return renderer;
        }

        private function getLayout():TiledRowsLayout {
            const listLayout:TiledRowsLayout = new TiledRowsLayout();
            listLayout.gap = 5;
            listLayout.verticalGap = 18;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            return listLayout;
        }

        override protected function show():void {
            setToCenter();
            this.y -= 30;
            //请求服务器列表\
            HttpServerList.getInstance().getServerList();
        }

        override protected function addListenerHandler():void {
            this.addViewListener(list_server, Event.CHANGE, onSelectServer);
            this.addViewListener(list_login, Event.CHANGE, onSelectServer);
            this.addContextListener(EventType.GET_SERVER_LIST_OK, getHttpListOk);
            this.addContextListener(EventType.GET_SERVER_LIST_FAIL, getHttpListFail);
        }

        private function getHttpListOk():void {
            ShowLoader.remove();
            list_server.dataProvider = new ListCollection(HttpServerList.list_server.reverse());
            list_login.dataProvider = new ListCollection(HttpServerList.list_login);
        }

        private function getHttpListFail():void {
            ShowLoader.remove();
            close();
        }

        private function onSelectServer(evt:Event):void {
            var list:List = evt.target as List;

            if (list.selectedItem) {
                dispatch(EventType.SELECTED_SERVER, list.selectedItem);
                this.close();
            }
        }


    }
}
