package game.view.achievement {
    import com.langue.Langue;
    import com.sound.SoundManager;
    import com.view.base.event.EventType;

    import game.view.achievement.data.AchievementData;
    import game.view.viewBase.AchievementDlgBase;

    import starling.display.DisplayObjectContainer;
    import starling.events.Event;

    /**
     *
     * 成就弹出窗
     * @author litao
     *
     */
    public class AchievementDlg extends AchievementDlgBase {

        public function AchievementDlg() {
            super();
            _closeButton = btn_close;
            isVisible = true;
        }

        /**初始化*/
        override protected function init():void {
            AchievementData.instance.onUpate.add(onUpdate);
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            //选中标签页
            this.addContextListener(EventType.SELECTTAB, onSelectTab);
        }

        /**选中标签页*/
        private function onSelectTab(evt:Event = null, index:int = 0):void {
            if (index == 0) {
                currentPanel.restItemRender(null);
            } else {
                if (currentPanel) {
                    currentPanel.restItemRender(AchievementData.instance.SectionList(index + 1));
                }
            }
        }

        /**列出按钮*/
        override protected function listTabButton():Array {
            var arr:Array = Langue.getLans("AchievementMenu");
            tab_1.text = arr[0];
            tab_2.text = arr[1];
            tab_3.text = arr[2];
            tab_4.text = arr[3];
            return [tab_1, tab_2, tab_3, tab_4];
        }

        /**列出引用的类名*/
        override protected function listTabReference():Array {
            return [Overall, TaskList, TaskList, TaskList];
        }

        /**打开*/
        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            if (parameter && parameter is int) {
                defaultSelect = parameter as int;
            }
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
        }

        private function onUpdate():void {
            if (currentPanel) {
                if (defaultSelect == 0) {
                    currentPanel.restItemRender(null);
                } else {
                    currentPanel.restItemRender(AchievementData.instance.SectionList(defaultSelect + 1));
                }
                SoundManager.instance.playSound("chengjiulingqu");
            }
        }

        override public function dispose():void {
            AchievementData.instance.onUpate.removeAll();
            super.dispose();
        }
    }
}
