package com.components
{
    import starling.events.Event;

    public class GroupTabSelect extends GroupSelect
    {
        private var _selectHandler:Function;
        private var _unSelectHandler:Function;


        public function GroupTabSelect()
        {

        }

        override public function setList(tabList:Array):GroupSelect
        {
            super.setList(tabList);

            return this;
        }

        override protected function doInit():void
        {
            _selects.forEach(function(item:TabButton, index:int, arr:Array):void
            {
                item.addEventListener(Event.TRIGGERED, selectHandler);
            });
        }


        public function addTab(tab:TabButton):void
        {
            if (_selects == null)
            {
                _selects=[];
            }
            _selects.push(tab);
            tab.addEventListener(Event.TRIGGERED, selectHandler);
        }

        protected function selectHandler(evt:Event):void
        {
            selectTarget(evt.currentTarget as TabButton);
        }

        public function adjustDefaultPos():void
        {
            adjustPos(25, 45, 4);
        }

        public function adjustPos(startX:Number, startY:Number, intervalX:Number, intervalY:Number=0):void
        {
            if (_selects == null || _selects.length == 0)
            {
                throw new Error('plz add tabList first');
            }
            _selects.forEach(function(item:TabButton, index:int, arr:Array):void
            {
                if (index == 0)
                {
                    item.x=startX;
                    item.y=startY;
                }
                else
                {
                    var lsItem:TabButton=_selects[index - 1];
                    if (intervalX != 0)
                    {
                        item.x=lsItem.x + 100 + intervalX;
                    }
                    else
                    {
                        item.x=lsItem.x;
                    }
                    if (intervalY != 0)
                    {
                        item.y=lsItem.y + 26 + intervalY;
                    }
                    else
                    {
                        item.y=lsItem.y;
                    }
                }

            });
        }


        override public function uninitListener():void
        {
            if (_selects == null)
                return;
            _selects.forEach(function(item:TabButton, index:int, arr:Array):void
            {
                item.removeEventListener(Event.TRIGGERED, selectHandler);
            });
        }

        override public function dispose():void
        {
            super.dispose();
            _selects=null;
            _selectHandler=null;
            _unSelectHandler=null;
        }

    }
}


