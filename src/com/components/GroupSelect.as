package com.components
{
    import starling.events.EventDispatcher;

    [Event(name="Select", type="com.components.GroupSelectEvent")]
    public class GroupSelect extends EventDispatcher
    {
        protected var _selects:Array;
        private var _selectHandler:Function;
        private var _unSelectHandler:Function;
        protected var _selectIndex:int=-1; //初始化-1  没有任何选择
        private var _elementType:Class;
        protected var _selectTarget:Object;

        public function GroupSelect(selects:Array=null, selectHandler:Function=null, unSelectHandler:Function=null)
        {
            _selects=selects;
            _selectHandler=selectHandler;
            _unSelectHandler=unSelectHandler;
        }

        public function setList(selects:Array):GroupSelect
        {
            if (selects == null)
            {
                throw new Error('setList()参数不能为空！')
            }
            if (_selects != null && _selects.length > 0)
            {
                uninitListener();
            }
            _selects=selects;
            doInit();
            return this;
        }

        protected function doInit():void
        {

        }

        public function uninitListener():void
        {

        }

        public function bindHandler(selectHandler:Function=null, unSelectHandler:Function=null):GroupSelect
        {
            _selectHandler=selectHandler;
            _unSelectHandler=unSelectHandler;
            return this;
        }

        /**
         *
         *因为 是循环处理 耗费性能 所以避免选择相同的 目标对象，不要试图用只为重新调用一次select获unselect方法。
         */
        public function selectTarget(tabButton:Object):void
        {
            if (_selectHandler == null)
            {
                trace('maybe you should bind selectHandler at first');
            }
            var index:int=_selects.indexOf(tabButton);
            if (index == _selectIndex)
            {
                return;
            } //当两次选择的一样
            _selectIndex=index;
            if (_selects == null)
            {
                throw new Error('tabList is null');
            }
            _selects.forEach(function(item:Object, index:int, arr:Array):void
            {
                if (tabButton == item)
                {
                    if (_selectHandler != null)
                        _selectHandler(item);
                }
                else
                {
                    if (_unSelectHandler != null)
                        _unSelectHandler(item);
                }
            });
            dispatchEvent(new GroupSelectEvent(_selectIndex, _selects[_selectIndex]));
        }

        //根据 序号选择某一个元素
        public function select(index:int):void
        {
            if (_selectHandler == null)
            {
                trace('maybe you should bind selectHandler at first');
            }
            if (index == selectIndex)
            {
                return;
            } //当两次选择的一样
            _selectIndex=index;
            for (var i:int=0, j:int=_selects.length; i < j; i++)
            {
                if (i == index)
                {
                    _selectHandler(_selects[i]);
                }
                else
                {
                    _unSelectHandler(_selects[i]);
                }
            }
            dispatchEvent(new GroupSelectEvent(_selectIndex, _selects[_selectIndex]));
        }


        public function setElementsType(claz:Class):void
        {
            _elementType=claz;
        }

        public function get list():Array
        {
            return _selects;
        }

        public function get selectIndex():int
        {
            return _selectIndex;
        }

        public function set selectIndex(index:int):void
        {
            _selectIndex=index;
        }

        public function dispose():void
        {
            _selects=null;
            _selectHandler=null;
            _unSelectHandler=null;
            _selectIndex=0; //初始化-1  没有任何选择
            _elementType=null;
            _selectTarget=null;
            uninitListener();
        }
    }
}

