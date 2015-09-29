package game.view.arena.render {
    import com.utils.Constants;

    import feathers.dragDrop.DragData;
    import feathers.dragDrop.DragDropManager;
    import feathers.dragDrop.IDragSource;
    import feathers.events.DragDropEvent;

    import game.base.DragImage;
    import game.common.JTGlobalDef;
    import game.data.HeroData;
    import game.manager.AssetMgr;
    import game.managers.JTFunctionManager;
    import game.view.uitils.Res;
    import game.view.viewBase.EmbattleShowItemBase;

    import starling.display.DisplayObject;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class EmbattleShowItem extends EmbattleShowItemBase implements IDragSource {
        private var _posIndex:uint = 0;
        private var _data:HeroData;
        private var isDraging:Boolean;

        public function EmbattleShowItem() {
            super();
        }

        override public function advanceTime(time:Number):void {

        }

        override protected function init():void {
            bg.container.addChild(wenzi);
            bg.container.addChild(head);
            bg.container.addChild(hero);
            head.visible = false;
        }

        override protected function addListenerHandler():void {
            addViewListener(this, TouchEvent.TOUCH, touchHandler);
            addViewListener(this, DragDropEvent.DRAG_ENTER, dragEnterHandler);
            addViewListener(this, DragDropEvent.DRAG_DROP, dragDropHandler);
            addViewListener(this, DragDropEvent.DRAG_COMPLETE, dragCompleteHandler);
        }

        private function touchHandler(event:TouchEvent):void {
            if (!data || data.id == 0) {
                return;
            }
            var touch:Touch = event.getTouch(this);
            if (touch == null) {
                return;
            }
            if (!DragDropManager.isDragging && !isDraging) {

                if (touch.phase == TouchPhase.MOVED) {
                    isDraging = true;
                    var dragData:DragData = new DragData();
                    dragData.setDataForFormat("cur_data", {type: 2, pos: _posIndex, data: data}); //set current hero data
                    var avatar:DisplayObject = new DragImage(head.texture);
                    avatar.scaleX = avatar.scaleY = Constants.scale;
                    DragDropManager.startDrag(this, touch, dragData, avatar, -(this.width >> 1), -(this.height >> 1));

                    head.visible = false;
                } else if (touch.phase == TouchPhase.ENDED) {
                    //直接卸下英雄
                    JTFunctionManager.executeFunction(JTGlobalDef.PVP_REFRHES_BATTLE, {type: 2, curData: {type: 2, pos: _posIndex,
                                                              data: data}, tagetData: {pos: 0, data: null}});
                    isDraging = false;
                }
                return;
            }
            isDraging = false;
        }

        private function dragEnterHandler(event:DragDropEvent, dragData:DragData):void {
            DragDropManager.acceptDrag(this); //drag and drop accept

        }

        private function dragDropHandler(event:DragDropEvent, dragData:DragData):void {
            dragData.setDataForFormat("taget_data", {type: 2, pos: _posIndex, data: data}); //set taget hero data
        }

        private function dragCompleteHandler(event:DragDropEvent, dragData:DragData):void {
            var curData:Object = dragData.getDataForFormat("cur_data");
            var tagetData:Object = dragData.getDataForFormat("taget_data");
            JTFunctionManager.executeFunction(JTGlobalDef.PVP_REFRHES_BATTLE, {type: 3, curData: curData, tagetData: tagetData});
        }

        public function setPosIndex(value:uint):void {
            _posIndex = value;
            if (value < 4) {
                wenzi.texture = AssetMgr.instance.getTexture("ui_weizhiqian_wenzi");
            } else if (value < 7) {
                wenzi.texture = AssetMgr.instance.getTexture("ui_weizhizhong_wenzi");
            } else if (value < 10) {
                wenzi.texture = AssetMgr.instance.getTexture("ui_weizhihou_wenzi");
            }
        }

        public function getPosIndex():uint {
            return _posIndex;
        }

        public function set data(value:HeroData):void {
            _data = value;
            if (_data == null) {
                head.visible = false;
                head.texture = Res.instance.getHeroIconTexture(0);
                hero.texture = Res.instance.getQualityHeroTexture(0);
            } else {
                head.visible = true;
                head.texture = Res.instance.getHeroIconTexture(_data.show);
                if (hero) {
                    hero.texture = Res.instance.getQualityHeroTexture(value.quality);
                }
            }
        }

        public function get data():HeroData {
            return _data;
        }

    }
}
