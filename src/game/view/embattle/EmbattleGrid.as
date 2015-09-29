package game.view.embattle {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.utils.Constants;
    import com.view.View;
    import com.view.base.event.EventType;

    import flash.geom.Point;

    import feathers.dragDrop.DragData;
    import feathers.dragDrop.DragDropManager;
    import feathers.dragDrop.IDragSource;
    import feathers.events.DragDropEvent;

    import game.data.Goods;
    import game.data.HeroData;
    import game.data.Val;
    import game.data.WidgetData;
    import game.dialog.ResignDlg;
    import game.dialog.ShowLoader;
    import game.hero.AnimationCreator;
    import game.hero.Hero;
    import game.manager.BattleAssets;
    import game.manager.BattleHeroMgr;
    import game.manager.HeroDataMgr;
    import game.view.tavern.TavernDialog;
    import game.view.viewBase.EmbattleGridBase;

    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    /**
     * 布阵英雄格子
     * @author hyy
     *
     */
    public class EmbattleGrid extends EmbattleGridBase implements IDragSource {
        private var isDraging:Boolean;
        private var _curr_hero:HeroData;
        private var heroAnimation:Hero;
        private var myPoint:Point;
        private static const list_loader:Array = [];
        private var assets:BattleAssets = BattleAssets.instance;

        public function EmbattleGrid() {
            super();
        }

        override protected function init():void {
            empty_ico.touchable = true;
            empty_ico.alpha = 0;
            click_target = empty_ico;
            btn_add.container.addChild(addIamge);
            addIamge.x = (btn_add.width - addIamge.width) >> 1;
            addIamge.y = -addIamge.height * 0.5;
        }

        public function set index(value:int):void {
        }

        override protected function addListenerHandler():void {
            this.addClickFun(onBgClick);
            addViewListener(empty_ico, Event.TRIGGERED, onClick);
            addViewListener(btn_add, Event.TRIGGERED, onClick);
            addViewListener(this, TouchEvent.TOUCH, touchHandler);
            addViewListener(this, DragDropEvent.DRAG_ENTER, dragEnterHandler);
            addViewListener(this, DragDropEvent.DRAG_DROP, dragDropHandler);
            addViewListener(this, DragDropEvent.DRAG_COMPLETE, dragCompleteHandler);
        }

        public function updateView(tmp_data:HeroData, isNow:Boolean = true):void {
            if (curr_hero && curr_hero.id == 0)
                tmp_data = curr_hero;
            _curr_hero = null;
            curr_hero = tmp_data;
            startLoader(isNow);
        }

        public function get data():HeroData {
            return _curr_hero;
        }

        private function onBgClick(view:View):void {
            if (!DragDropManager.isDragging && (btn_add.visible || curr_hero || (HeroDataMgr.instance.getOnBattleHeroCount() < HeroDataMgr.instance.seatMax))) {
                if (data && data.id > 0)
                    this.dispatch(EventType.UPDATE_HERO_LIST_STATUS, name);
            }
        }

        private function onClick(evt:Event):void {
            var freeCount:int = HeroDataMgr.instance.getFreeBattleHero().length;
            var count:int = HeroDataMgr.instance.getOnBattleHeroCount();
            var bool:Boolean = data == null && count < HeroDataMgr.instance.seatMax && freeCount > 0;
            if (bool) {
                this.dispatch(EventType.UPDATE_HERO_LIST_STATUS, name);
            } else {
                if (!data && HeroDataMgr.instance.hash.size() < HeroDataMgr.instance.seatMax) {
                    var tip:ResignDlg = DialogMgr.instance.open(ResignDlg) as ResignDlg;
                    tip.text = Langue.getLangue("hero_buy_tip");
                    tip.ok_Scale9Button.addEventListener(Event.TRIGGERED, onTipTriggered);
                }
            }
        }

        private function onTipTriggered():void {
            DialogMgr.instance.open(TavernDialog, null, null, canceFunHandler);
        }

        private function canceFunHandler(e:Event):void {
            dispatch(EventType.UPDATE_HERO_LIST);
        }

        private function touchHandler(event:TouchEvent):void {
            var touch:Touch = event.getTouch(this);
            if (touch == null || curr_hero == null) {
                return;
            }
            if (curr_hero.id == 0) {
                if (touch.phase == TouchPhase.BEGAN) {
                    addTips(Langue.getLangue("not_move_hero"));
                }
                return;
            }
            if (curr_hero.id != 0 && !DragDropManager.isDragging && !isDraging) {
                if (touch.phase == TouchPhase.MOVED) {
                    isDraging = true;
                    var dragData:DragData = new DragData();
                    dragData.setDataForFormat("hero_change", curr_hero);
                    heroAnimation.scaleX = heroAnimation.scaleY = Constants.scale;
                    DragDropManager.startDrag(this, touch, dragData, heroAnimation, 0, 0);
                } else if (touch.phase == TouchPhase.ENDED) {
                    isDraging = false;
                }
                return;
            }
            isDraging = false;
        }

        private function dragEnterHandler(event:DragDropEvent, dragData:DragData):void {
            if (dragData.hasDataForFormat("hero") || dragData.hasDataForFormat("hero_change")) {
                DragDropManager.acceptDrag(this);
            }
        }

        /**
         * 英雄列表当中拖过来的处理
         * @param event
         * @param dragData
         */
        private function dragDropHandler(event:DragDropEvent, dragData:DragData):void {
            //英雄之间拖动不需要进入判断
            if (curr_hero == null && HeroDataMgr.instance.getOnBattleHeroCount() == HeroDataMgr.instance.seatMax && dragData.hasDataForFormat("hero")) {
                RollTips.add(Langue.getLangue("EMBATTLE_FOUR").replace("*", HeroDataMgr.instance.seatMax));
                return;
            }

            var isFromList:Boolean = dragData.hasDataForFormat("hero");
            var tmp_heroData:HeroData = dragData.getDataForFormat(dragData.hasDataForFormat("hero") ? "hero" : "hero_change") as HeroData;
            var old_heroData:HeroData = curr_hero;

            //固有英雄不可拖动
            if (curr_hero && curr_hero.id == 0) {
                dragData.setDataForFormat("hero", tmp_heroData);
                return;
            }

            //把当前英雄传过去
            dragData.setDataForFormat("hero", old_heroData);

            //英雄之间拖动不需要移除位置信息
            if (!isFromList && curr_hero) {
                _curr_hero = null;
            }
            curr_hero = tmp_heroData;

            if (old_heroData != tmp_heroData) {
                curr_hero && dispatch(EventType.UPDATE_HERO_LIST, curr_hero);
            }

            if (old_heroData && isFromList) {
                old_heroData && dispatch(EventType.UPDATE_HERO_LIST, old_heroData);
            }
            startLoader();
        }

        /**
         * 开始加载
         * @param isNow 是否立马加载，点击自动布阵的时候可能需要多个英雄一起加载
         */
        private function startLoader(isNow:Boolean = true):void {
            if (curr_hero) {
                //不是立马加载的时候才需要添加滚动
                AnimationCreator.instance.loadHeroRes(curr_hero, assets);
                AnimationCreator.instance.loadHeroSkillRes(curr_hero, assets);
                ShowLoader.add();
                list_loader.push(this);
                //没有加载过，立马加载
                isNow && assets.loadQueue(onLoadComplete);
            } else {
                if (isNow && list_loader.length > 0 && !assets.isLoading) {
                    assets.loadQueue(onLoadComplete);
                } else if (isNow && !assets.isLoading) {
                    ShowLoader.remove();
                }
                createAvatarHandler();
            }
        }

        /**
         * 加载完成
         * @param ratio
         */
        private function onLoadComplete(ratio:Number):void {
            if (ratio == 1.0) {
                //如果有同类型的，需要广播,才没有直接创建
                for each (var render:EmbattleGrid in list_loader) {
                    render.createAvatarHandler();
                }
                list_loader.length = 0;
                ShowLoader.remove();
            }
        }

        /**
         * 上阵英雄之间的拖动处理
         * @param event
         * @param dragData
         */
        private function dragCompleteHandler(event:DragDropEvent, dragData:DragData):void {
            if (curr_hero && curr_hero.id == 0) {
                return;
            }
            var tmp_heroData:HeroData = dragData.getDataForFormat("hero") as HeroData;

            //英雄之间互换位置
            if (event.isDropped) {
                _curr_hero = null;
                if (tmp_heroData) {
                    curr_hero = tmp_heroData;
                    startLoader();
                }
            } else {
                var tmp_hero:HeroData = curr_hero;
                curr_hero = null;
                //下阵英雄
                if (tmp_hero) {
                    dispatch(EventType.UPDATE_HERO_LIST, tmp_hero);
                    return;
                }
            }
            this.dispatch(EventType.UPDATE_HERO_LIST);
        }

        /**
         * 创建avatar
         */
        public function createAvatarHandler():void {
            if (heroAnimation) {
                heroAnimation.removeFromParent(true);
                heroAnimation.stopAnimation();
            }
            heroAnimation = null;

            if (curr_hero == null) {
                return;
            }
            curr_hero.team = HeroData.BLUE;

            var tmp_hero:HeroData = curr_hero.clone() as HeroData;
            tmp_hero.id = tmp_hero.seat;
            heroAnimation = BattleHeroMgr.instance.createHero(tmp_hero, false, BattleAssets.instance);
            var weapon:int = curr_hero.seat1;

            if (weapon > 0) {
                var goods:Goods = WidgetData.hash.getValue(weapon);
                if (goods == null) {
                    goods = Goods.goods.getValue(weapon);
                }
                if (goods && goods.avatar) {
                    heroAnimation.swapPieceByTex("role_weapon", assets.getTexture(goods.avatar));
                }
            } else {
                heroAnimation.unswapPiece("role_weapon");
            }
            heroAnimation.scaleX = heroAnimation.scaleY = 1;
            heroAnimation.data.seat = curr_hero.seat;
            heroAnimation.startAnimation();
            heroAnimation.reastPos();
            addChild(heroAnimation);

            if (myPoint == null) {
                myPoint = this.localToGlobal(new Point());
            }
            heroAnimation.x = heroAnimation.x - myPoint.x / Constants.scale;
            heroAnimation.y = heroAnimation.y - myPoint.y / Constants.scale;
        }

        public function get curr_hero():HeroData {
            return _curr_hero;
        }

        public function set curr_hero(value:HeroData):void {
            if (_curr_hero) {
                _curr_hero.seat = 0;
            }
            _curr_hero = value;

            if (_curr_hero) {
                _curr_hero.currenthp = _curr_hero.hp;
                _curr_hero.seat = Val.posC2S(int(name));
            }
        }

        override public function dispose():void {
            super.dispose();
            heroAnimation = null;
            _curr_hero = null;
        }
    }
}
