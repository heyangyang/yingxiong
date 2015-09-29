package com.components
{
    import starling.events.Event;

    public class GroupSelectEvent extends Event
    {
        public static const SELECT:String='Select';
        private var _obj:Object;
        private var _select:int; //选种的

        public function GroupSelectEvent(select:int=0, obj:Object=null)
        {
            _select=select;
            _obj=obj;
            super(SELECT, bubbles);
        }

        public function get obj():Object
        {
            return _obj;
        }

        public function get select():int
        {
            return _select;
        }

        public function clone():Event
        {
            return new GroupSelectEvent(_select);
        }
    }
}
