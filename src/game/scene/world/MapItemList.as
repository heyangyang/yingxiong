package game.scene.world {
    import com.langue.Langue;
    import com.view.base.event.EventType;

    import game.data.MainLineData;
    import game.manager.GameMgr;
    import game.view.viewBase.MapItemListBase;

    import starling.text.TextField;

    public class MapItemList extends MapItemListBase {
        public function MapItemList() {
            super();
//            itemBtn.txt.fontSize = 16;
        }

        public function setMapIndex(index:int, maxIndex:int, arr:Array, type:String):void {
            const typeConst:String = "game.scene::MainMapDialog";
            var currentIndex:int = MainLineData.getPageById(GameMgr.instance.tollgateID, typeConst == type ? 0 : 1);
//            var currentChapter:MainLineData = MainLineData.getPoint(currentIndex);
//            var currentChapterIndex:int = arr[currentIndex];
            if(currentIndex == 0)
            {
                currentIndex = 17;
            }
            const chapter:String = Langue.getLangue("chapter");
            var mainLineData:MainLineData = arr[index];
            var nameStr:String = type == typeConst ? chapter.replace("*", mainLineData.chapterID) : mainLineData.chapterName;
            itemBtn.txt.text = nameStr;
            var i:int = 0;
            var txt:TextField;
            for (i = 0; i < 9; i++) {
                if (!this.hasOwnProperty("txt_" + (9 - (i + 1)))) {
                    break;
                }
                txt = this["txt_" + (9 - (i + 1))] as TextField;

                mainLineData = arr[index - (i + 1)];
                if (mainLineData) {
                    if (mainLineData.chapterID <= currentIndex + 1) {
                        txt.color = 0xFF9900;
                    } else {
                        txt.color = 0x725F3F;
                    }
                    txt.text = type == typeConst ? chapter.replace("*", mainLineData.chapterID) : mainLineData.chapterName;
                } else {
                    txt.text = "";
                }
            }

            for (i = 0; i < 9; i++) {
                if (!this.hasOwnProperty("txt_" + (9 + i + 1))) {
                    break;
                }
                txt = this["txt_" + (9 + i + 1)] as TextField;

                mainLineData = arr[index + (i + 1)];
                if (mainLineData) {
                    if (mainLineData.chapterID <= currentIndex + 1) {
                        txt.color = 0xFF9900;
                    } else {
                        txt.color = 0x725F3F;
                    }
                    txt.text = type == typeConst ? chapter.replace("*", mainLineData.chapterID) : mainLineData.chapterName;
                } else {
                    txt.text = "";
                }
            }
            this.dispatch(EventType.SELECT_MAP_ITEM, index);
        }
    }
}
