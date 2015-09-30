package game.view.picture {
    import com.dialog.DialogMgr;
    
    import feathers.controls.Scroller;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;
    
    import game.data.HeroData;
    import game.net.data.c.CPictorialial;
    import game.net.data.s.SPictorialial;
    import game.net.data.vo.Pictorial;
    import game.view.viewBase.PictureViewBase;
    
    import starling.display.DisplayObjectContainer;
    import starling.events.Event;

    /**
     * 图鉴
     * @author hyy
     */
    public class PictureView extends PictureViewBase {
        public function PictureView() {
            super();
        }

        override protected function init():void {
            _closeButton = btn_close;
            const listLayout:TiledRowsLayout = new TiledRowsLayout();
            listLayout.horizontalGap = 10;
            listLayout.paddingTop = 10;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.tileVerticalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
//            listLayout.paging = TiledColumnsLayout.PAGING_HORIZONTAL; //自动排列
            list_pic.layout = listLayout;
//            list_pic.snapToPages = true;
            list_pic.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_pic.itemRendererFactory = itemRendererFactory;
        }

        override protected function show():void
		{
			//请求图鉴列表
			sendMessage(CPictorialial);
		}
        override protected function addListenerHandler():void {
            super.addListenerHandler();
            this.addViewListener(list_pic, Event.CHANGE, onListHandler);
//            this.addViewListener(list_pic, Event.SCROLL, onListScrollHanlder);
            this.addContextListener(CPictorialial.CMD + "", updateHeroList);
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
        }

        private function itemRendererFactory():IListItemRenderer {
            const renderer:PictureRender = new PictureRender();
            renderer.setSize(98, 150);
            return renderer;
        }

        /**
         * 获取图鉴列表，更新图鉴界面
         * @param evt
         * @param info
         *
         */
        private function updateHeroList(evt:Event, info:SPictorialial):void {
            HeroData.getHeroList.length = 0;
            //英雄数据里面所有英雄

            for each (var hero:Pictorial in info.herose) {
                HeroData.getHeroList.push(hero.id);
            }

            var _heroData:Vector.<*> = HeroData.hero.values();
            var len:int = _heroData.length;
            var heroArr:Array = [];
            var tmpHero:HeroData;
            for (var i:int = 0; i < len; i++) {
                tmpHero = _heroData[i];
                if (tmpHero.isShowHero != 2) {
					heroArr.push(tmpHero);
                }
            }
            //排序，优先已获得的和老英雄
			heroArr.sortOn(["isGet", "get_hard"], [Array.DESCENDING, 0]);
            list_pic.dataProvider = new ListCollection(heroArr);
        }

        /**
         * 点击英雄查看详细信息
         * @param evt
         */
        private function onListHandler(evt:Event):void {
            if (list_pic.selectedItem == null) {
                return;
            }
            var heroData:HeroData = list_pic.selectedItem as HeroData;
//            if (heroData.isGet) {
				this.isVisible = true;
                DialogMgr.instance.open(PictureInfoView, heroData);
//            } else {
//                RollTips.add(Langue.getLangue("HERO_PROPERTY_INFO"));
//            }
            list_pic.selectedIndex = -1;
        }

        override public function dispose():void {
            super.dispose();
        }

    }
}
