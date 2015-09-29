package game.view.achievement {
    import feathers.controls.List;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.dialog.ShowLoader;
    import game.net.GameSocket;
    import game.net.data.IData;
    import game.net.data.c.CAttain_get;
    import game.net.data.vo.AttainInfo;
    import game.view.achievement.data.AchievementData;

    import starling.core.Starling;
    import starling.events.Event;

    public class TaskList extends List {
		
        private var currentData:Object;
		public function TaskList(w:int = 0, h:int = 0){
			super();
			inits(w ,h);
		}
		
        private function inits(w:int = 0, h:int = 0):void {
            const listLayout:TiledRowsLayout = new TiledRowsLayout();
            listLayout.gap = 5;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            this.x = 164;
            this.y = 80;
            if (w == 0 && h == 0) {
                this.width = 770;
                this.height = 435;
            } else {
                this.width = w;
                this.height = h;
            }
            layout = listLayout;
            paddingTop = 5;
            itemRendererFactory = tileListItemRendererFactory;
            super.addEventListener(Event.SELECT, onSelect);
        }

        public function restItemRender(dataList:Vector.<IData>):void {
            var i:int = 0;
            var length:int = dataList.length;
            var obj:AttainInfo;
            var data:Vector.<IData> = new Vector.<IData>;
            var k:int;
            for (i; i < length; i++) {
                obj = dataList[i] as AttainInfo;
                if (obj.type == 2)
                    continue;
                if (obj.id != 0) {
                    data[k++] = obj;
                }
            }

            data.sort(sortFun);
            function sortFun(a:AttainInfo, b:AttainInfo):Number {
                var result:int = 0;
                if (a.type > b.type) {
                    result = -1;
                } else if (a.type < b.type) {
                    result = 1;
                } else {
                    if (a.id < b.id) {
                        result = -1;
                    } else if (a.id > b.id) {
                        result = 1;
                    }
                }
                return result;
            }
            const collection:ListCollection = new ListCollection(data);

            dataProvider = collection;
            verticalScrollPosition = 800;
            Starling.juggler.delayCall(function():void {
                verticalScrollPosition = 0;
                var i:int = 0;
                var len:int = dataViewPort.numChildren;
                var item:Object;

                for (i; i < len; i++) {
                    item = dataViewPort.getChildAt(i);

                    if (item.data == currentData) {
                        item.data = item.data;
                        break;
                    }
                }
            }, 0.01);
        }

        private function tileListItemRendererFactory():IListItemRenderer {
            return new TaskItemRender();
        }

        private function onSelect(e:Event):void {
            if (selectedIndex == -1) {
                return;
            }
            var info:AttainInfo = selectedItem as AttainInfo;
            currentData = selectedItem;
            selectedIndex = -1;
            if (info.type == 1) {
                var cmd:CAttain_get = new CAttain_get();
                cmd.id = info.id;
                AchievementData.instance.getId = info.id;
                GameSocket.instance.sendData(cmd);
                ShowLoader.add();
            }
        }

        override public function dispose():void {
            super.dispose();
            currentData = null;
        }
    }
}
