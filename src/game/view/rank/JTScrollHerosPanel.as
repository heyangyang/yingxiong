package game.view.rank {
    import game.common.JTGlobalDef;
    import game.common.JTLogger;
    import game.common.JTScrollerMenu;
    import game.data.HeroData;
    import game.managers.JTFunctionManager;
    import game.view.hero.item.HeroItemRender;
    import game.view.rank.ui.JTUIHeroList;

    import starling.display.Sprite;

    /**
     *
     * @author Administrator
     *查看角斗场 玩家拥有的英雄列表
     */
    public class JTScrollHerosPanel extends JTUIHeroList {
        private const MAX_HERO_NUM:int = 9;
        private static var instance:JTScrollHerosPanel = null;
        private var scrollbar:JTScrollerMenu = null;

        public function JTScrollHerosPanel(dataList:Object) {
            super();

            if (!dataList) {
                JTLogger.error("[JTHeroListComponent.JTHeroListComponent]dataList is empty!");
            }
            initiliaze(dataList);
        }

        private function initiliaze(dataList:Object):void {
            scrollbar = JTScrollerMenu.createScrollerMenu(HeroItemRender, onMouseClickHandler, convertHeroInfos(dataList));
            scrollbar.layout = scrollbar.getTiledColumnsLayout();
            scrollbar.x = 26;
            scrollbar.y = 49;
            scrollbar.width = 750;
            scrollbar.height = 100;

            if (scrollbar.dataProvider.length > 0) {
                scrollbar.selectedIndex = 0;
                JTFunctionManager.executeFunction(JTGlobalDef.REFRESH_HERO_EQUIPMENT, scrollbar.selectedItem);
            }
            addQuiackChildAt(scrollbar, 1);
        }

        private function convertHeroInfos(list:Object):Object {
            list.sort(sortFun);
            var l:int = list.length;
            function sortFun(a:HeroData, b:HeroData):Number {
                var result:int = 0;

                if (a.getPower > b.getPower) {
                    result = -1;
                } else {
                    result = 1;
                }
                return result;
            }

            if (l < MAX_HERO_NUM) {
                var i:int = 0;

                for (i = 0; i < MAX_HERO_NUM; i++) {
                    if (l > i) {
                        continue;
                    }
                    list[i] = new HeroData;
                }
            }
            return list;
        }

        private function onMouseClickHandler(itemInfo:HeroData):void {
            JTFunctionManager.executeFunction(JTGlobalDef.REFRESH_HERO_EQUIPMENT, itemInfo);
        }

        override public function dispose():void {
            if (this.scrollbar) {
                this.scrollbar.removeFromParent();
                this.scrollbar.dispose();
                this.scrollbar = null;
            }
            super.dispose();
        }

        public static function show(parent:Sprite, dataList:Object):void {
            if (!instance) {
                instance = new JTScrollHerosPanel(dataList);
                instance.y = parent.y + parent.height - 30;
                instance.x = parent.x;
                parent.addChildAt(instance, 0);
            }
        }

        public static function hide():void {
            if (instance) {
                instance.removeFromParent();
                instance.dispose();
                instance = null;
            }
        }
    }
}
