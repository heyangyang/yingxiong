package game.scene.world {
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

    import flash.geom.Rectangle;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getTimer;

    import feathers.system.DeviceCapabilities;

    import game.common.JTGlobalDef;
    import game.data.MainLineData;
    import game.managers.JTFunctionManager;
    import game.view.viewBase.MainMapDialogBase;

    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    /**
     * 主线地图 副本地图
     * @author Samuel
     *
     */
    public class MapBase extends MainMapDialogBase {
        protected var lineDatas:Array;
        protected var _container:Sprite;
        protected var _index:int;
        protected var _clipRect:Rectangle = new Rectangle(0, 0, 812, 510);
        protected var _list:Array = [];
        private var mIsDown:Boolean;
        protected static const MAX_DRAG_DIST:int = DeviceCapabilities.dpi * 0.5;
        protected static const MAX_DRAG_TIME:int = 1000;
        private var _oldPos:int;
        private var _oldTime:int;

        override protected function init():void {
            _closeButton = btn_close;
            figthView.visible = false;
            maskMap.touchable = false;
            isCache = true;
            bg.touchable = true;
            _container = new Sprite();
            var s:Sprite = new Sprite();
            s.addQuiackChild(_container);
            s.x = 44;
            s.y = 42;
            s.clipRect = _clipRect;
            addQuiackChildAt(s, this.getChildIndex(maskMap));
            this.addEventListener(TouchEvent.TOUCH, onTouch);
        }

        public function onTouch(event:TouchEvent):void {
            if (!bg.touchable) {
                return;
            }
            var touch:Touch = event.getTouch(this);
            if (touch == null) {
                return;
            }
            if (touch.phase == TouchPhase.BEGAN && !mIsDown) {
                _oldPos = touch.globalY;
                _oldTime = getTimer();
                mIsDown = true;
            } else if (touch.phase == TouchPhase.MOVED && mIsDown) {

            } else if (touch.phase == TouchPhase.ENDED && mIsDown) {
                mIsDown = false;
                var gap:int = touch.globalY - _oldPos;
                var gapTime:int = getTimer() - _oldTime;
                if (Math.abs(gap) > MAX_DRAG_DIST && gapTime < MAX_DRAG_TIME) {
                    if (gap > 0) // 往下
                    {
                        changePage("down");
                    } else // 往上
                    {
                        changePage("up");
                    }
                }
            }
            event.stopImmediatePropagation();
        }

        protected function changePage(type:String):void {
            if (!Starling.juggler.containsTweens(_container)) {
                if (type == "down") // 往下
                {
                    if (Math.abs(_container.y - 0) < 10) {
                        Starling.juggler.tween(_container, 0.1, {y: _container.y + _clipRect.height / 3, onComplete: function():void {
                            Starling.juggler.tween(_container, 0.1, {y: 0});
                        }})
                    } else {
                        Starling.juggler.tween(_container, 0.3, {y: _container.y + _clipRect.height, onComplete: function():void {
                            _list[_index + 1].visible = false;
                        }})
                        _index--;
                        _list[_index].visible = true;
                        _list[_index + 1].visible = true;
                    }

                } else // 往上
                {
                    if (Math.abs(_container.y - (-_container.height + _clipRect.height)) < 10) {
                        Starling.juggler.tween(_container, 0.1, {y: (-_container.height + _clipRect.height - _clipRect.height / 3),
                                                   onComplete: function():void {
                                                       Starling.juggler.tween(_container, 0.1, {y: -_container.height + _clipRect.height})
                                                   }})
                    } else {
                        Starling.juggler.tween(_container, 0.3, {y: _container.y - _clipRect.height, onComplete: function():void {
                            _list[_index - 1].visible = false;
                        }})
                        _index++;
                        _list[_index].visible = true;
                        _list[_index - 1].visible = true;
                    }
                }
                mapItem.setMapIndex(_index, lineDatas.length, lineDatas, getQualifiedClassName(this));
            }
        }

        protected function hideOther():void {
            var len:int = _list.length;
            for (var i:int = 0; i < len; i++) {
                var item:MapItemRender = _list[i];
                item.visible = item.index == _index;
            }
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            addViewListener(lastBtn, Event.TRIGGERED, lastPagehander);
            addViewListener(nextBtn, Event.TRIGGERED, nextPagehander);
            addViewListener(btn_close, Event.TRIGGERED, closeHandler);
            ViewDispatcher.instance.addEventListener(EventType.UPDATE_SELECTED_MAINLINE, onSelected);
        }

        private function closeHandler(e:Event):void {
            if (figthView.visible) {
                bg.touchable = lastBtn.visible = nextBtn.visible = !(figthView.visible = false);
                bg.touchable = lastBtn.visible = nextBtn.visible = btn_close.visible = true;
                _container.flatten();
            } else {
                this.close();
                JTFunctionManager.executeFunction(JTGlobalDef.PLAY_CITY_ANIMATABLE);
            }
        }

        private function onSelected(e:Event, data:MainLineData):void {
            bg.touchable = lastBtn.visible = nextBtn.visible = btn_close.visible = !(figthView.visible = true);
            _container.flatten();
            figthView.data = data;
            figthView.btn_close.addEventListener(Event.TRIGGERED, TriggredClose);
        }

        private function TriggredClose():void {
            figthView.visible = false;
			bg.touchable = lastBtn.visible = nextBtn.visible = btn_close.visible = true;
            _container.unflatten();
        }

        private function lastPagehander(e:Event):void {
            changePage("down");
        }

        private function nextPagehander(e:Event):void {
            changePage("up");
        }

        override protected function show():void {
            bg.touchable = lastBtn.visible = nextBtn.visible = btn_close.visible = !(figthView.visible = false);
            figthView.btn_close.addEventListener(Event.TRIGGERED, Triggred);
            _container.unflatten();
            if (_index > lineDatas.length - 1) {
                _index = lineDatas.length - 1;
            } else if (_index < 0) {
                _index = 0;
            }

            var len:int = lineDatas.length;
            for (var i:int = 0; i < len; i++) {
                var item:MapItemRender = _list[i]
                var data:MainLineData = lineDatas[i];
                if (!item) {
                    item = new MapItemRender();
                }

                item.data = data;
                item.index = i;
                item.y = i * _clipRect.height;
                _container.addQuiackChild(item);
                _list[i] = item;
            }

            _container.y = -_index * _clipRect.height;
            hideOther();
            mapItem.setMapIndex(_index, lineDatas.length, lineDatas, getQualifiedClassName(this));

            setToCenter();
        }

        private function Triggred():void {
            figthView.visible = true;
			bg.touchable = lastBtn.visible = nextBtn.visible = btn_close.visible = false;
            _container.flatten();
        }

        override public function dispose():void {
            figthView.btn_close.removeEventListener(Event.TRIGGERED, TriggredClose);
            figthView.btn_close.removeEventListener(Event.TRIGGERED, Triggred);
            super.dispose();

        }
    }
}
