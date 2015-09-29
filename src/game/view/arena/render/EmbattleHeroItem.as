package game.view.arena.render {
    import com.utils.Constants;

    import feathers.dragDrop.DragData;
    import feathers.dragDrop.DragDropManager;
    import feathers.dragDrop.IDragSource;
    import feathers.events.DragDropEvent;

    import game.base.DragImage;
    import game.common.JTGlobalDef;
    import game.data.HeroData;
    import game.managers.JTFunctionManager;
    import game.view.uitils.Res;
    import game.view.viewBase.EmbattleHeroItemBase;

    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class EmbattleHeroItem extends EmbattleHeroItemBase implements IDragSource, IAnimatable {
        private var isDraging:Boolean;
        private var _param:Object = {};

        public function EmbattleHeroItem() {
            super();
            init();
        }

        protected function init():void {
            bg.container.addChild(head);
            bg.container.addChild(hero);
            bg.container.addChild(gou);
            addListenerHandler();
        }

        protected function addListenerHandler():void {
            this.addEventListener(TouchEvent.TOUCH, touchHandler);
            this.addEventListener(DragDropEvent.DRAG_ENTER, dragEnterHandler);
            this.addEventListener(DragDropEvent.DRAG_DROP, dragDropHandler);
            this.addEventListener(DragDropEvent.DRAG_COMPLETE, dragCompleteHandler);
        }

        public function advanceTime(time:Number):void {

        }

        private function touchHandler(event:TouchEvent):void {
            if (this.owner.isScrolling) {
                return;
            }
            if (!data || data.id == 0) {
                return;
            }
            var touch:Touch = event.getTouch(this);
            if (touch == null) {
                return;
            }
            if (!DragDropManager.isDragging && !isDraging) {

                if (touch.phase == TouchPhase.MOVED) {
                    this.owner.stopScrolling();
                    isDraging = true;
                    var dragData:DragData = new DragData();
                    dragData.setDataForFormat("cur_data", {type: 1, pos: index, data: data}); //set current hero data
                    var avatar:DisplayObject = new DragImage(head.texture);
                    avatar.scaleX = avatar.scaleY = Constants.scale;
                    DragDropManager.startDrag(this, touch, dragData, avatar, -(this.width >> 1), -(this.height >> 1));
                } else if (touch.phase == TouchPhase.ENDED) {
                    //直接上阵英雄
                    JTFunctionManager.executeFunction(JTGlobalDef.PVP_REFRHES_BATTLE, {type: 1, curData: {type: 1, pos: index,
                                                              data: data}, tagetData: {pos: 0, data: null}});
                    isDraging = false;

                    Starling.juggler.remove(this);
                }
                return;
            }
            isDraging = false;
        }

        private function dragEnterHandler(event:DragDropEvent, dragData:DragData):void {
            DragDropManager.acceptDrag(this); //drag and drop accept

        }

        private function dragDropHandler(event:DragDropEvent, dragData:DragData):void {
            dragData.setDataForFormat("taget_data", {type: 1, pos: index, data: data}); //set taget hero data
        }

        private function dragCompleteHandler(event:DragDropEvent, dragData:DragData):void {
            var curData:Object = dragData.getDataForFormat("cur_data");
            var tagetData:Object = dragData.getDataForFormat("taget_data");
            JTFunctionManager.executeFunction(JTGlobalDef.PVP_REFRHES_BATTLE, {type: 3, curData: curData, tagetData: tagetData});
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (value) {
                var heroData:HeroData = value as HeroData;
                hero.texture = Res.instance.getQualityHeroTexture(heroData.quality);
                head.texture = Res.instance.getHeroIconTexture(heroData.show);
                if (heroData.seat > 0) {
                    gou.visible = true;
                } else {
                    gou.visible = false;
                }
                touchable = true;
            } else {
                gou.visible = false;
                touchable = false;
            }
        }
    }
}
