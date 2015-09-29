package game.scene {
import flash.system.System;

import game.data.MainLineData;
    import game.manager.GameMgr;
    import game.scene.world.MapBase;

    /**
     * 主线地图 副本地图
     * @author Samuel
     *
     */

    public class MainMapDialog extends MapBase {
        private var currentPage:int;
        private static var _isCache:Boolean;

        override protected function show():void {
            lineDatas = MainLineData.mainList;

            currentPage = MainLineData.getPageById(GameMgr.instance.tollgateID, 0);
            if (!_isCache) {
                _index = currentPage;
            }
            super.show();
        }

        override protected function hide():void {
            super.hide()
            _isCache = _index != MainLineData.getPageById(GameMgr.instance.tollgateID, 0);
        }


        override protected function changePage(type:String):void {
            if ((type == "up") && (_index >= currentPage)) {
                return;
            }
            super.changePage(type);
        }

        override public function dispose():void {
            super.dispose();

            System.pauseForGCIfCollectionImminent(0);
            System.gc();
        }
    }
}
