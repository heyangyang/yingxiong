package game.view.achievement {
    import com.langue.Langue;
    import com.mvc.interfaces.INotification;

    import flash.geom.Rectangle;

    import game.data.Attain;
    import game.dialog.ShowLoader;
    import game.net.GameSocket;
    import game.net.data.IData;
    import game.net.data.c.CAttain_init;
    import game.net.data.s.SAttain_init;
    import game.view.achievement.data.AchievementData;
    import game.view.viewBase.OverallBase;

    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * 成就   总览
     * @author litao
     *
     */
    public class Overall extends OverallBase {
        private var _data:AchievementData = AchievementData.instance;
        public var list:TaskList;
        private var m_width:int = 273;

        public function Overall() {
            super();
            initView();
        }

        protected function initView():void {
            var arr:Array = Langue.getLans("AchievementMenu");
            for (var i:int = 0; i < arr.length; i++) {
                this["Progress" + (i + 1)].text = arr[i];
            }

            list = new TaskList(770, 310);
            addQuiackChild(list);
            if (!_data.isSend) {
                send();
            } else {
                restItemRender(null);
            }
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            //选中标签页
            list.addEventListener(Event.CHANGE, onChange);
        }

        private function onChange(e:Event):void {
            list.dataViewPort.dataProvider_refreshItemHandler(); //刷新List整页数据
        }

        public function showProgress():void {
            var parcent:Number = 0;
            var heroTotal:int = _data.getSectionTotals(4);
            var heroComplete:int = heroTotal - (_data.getSectionCompletes(_data.SectionList(4)));
            ProgressRate4.text = heroComplete + " / " + heroTotal;
            parcent = heroComplete / heroTotal;
            maskBar(par_4, m_width, 32, parcent);

            var fightTotal:int = _data.getSectionTotals(3);
            var fightComplete:int = fightTotal - (_data.getSectionCompletes(_data.SectionList(3)));
            ProgressRate3.text = fightComplete + " / " + fightTotal;
            parcent = fightComplete / fightTotal;
            maskBar(par_3, m_width, 32, parcent);

            var dailyTotal:int = _data.getSectionTotals(2);
            var dailyComplete:int = dailyTotal - (_data.getSectionCompletes(_data.SectionList(2)));
            ProgressRate2.text = dailyComplete + " / " + dailyTotal;
            parcent = dailyComplete / dailyTotal;
            maskBar(par_2, m_width, 32, parcent);

            var totals:int = Attain.totals;
            var complete:int = fightComplete + heroComplete + dailyComplete;
            ProgressRate1.text = complete + " / " + totals;
            parcent = complete / totals;
            maskBar(par_1, 646, 32, parcent);
        }

        private function maskBar(mask:Sprite, w:Number, h:Number, parcent:Number):void {
            mask.clipRect = new Rectangle(0, 0, w * parcent, h);
        }

        public function restItemRender(dataList:Vector.<IData>):void {
            if (_data.attainInfo) {
                list.restItemRender(_data.attainInfo);
                showProgress();
            }
        }

        private function send():void {
            var cmd:CAttain_init = new CAttain_init;
            GameSocket.instance.sendData(cmd);
            ShowLoader.add();
        }

        override public function handleNotification(_arg1:INotification):void {
            var info:SAttain_init = _arg1 as SAttain_init;
            _data.attainInfo = info.ids;
            _data.receive();

            restItemRender(null);
            _data.isSend = true;

            ShowLoader.remove();
        }

        override public function listNotificationName():Vector.<String> {
            var vect:Vector.<String> = new Vector.<String>;
            vect.push(SAttain_init.CMD);
            return vect;
        }

        override public function dispose():void {
            list && list.dispose();
            super.dispose();
            list = null;
            m_width = 0;
        }
    }
}
